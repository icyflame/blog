---
layout: post
comments: true
title: Conversion from HTML to ePub Format
categories: technology reading books
---

Recently, I have taken to reading magazine articles and long newsletter posts on my Kindle by
converting them to the ePub format, rather than reading them on the computer, where the process of
making highlights and taking notes differs from the process that I use for all the e-books that I
read. As I started doing this for some long articles (such as [this one](https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/)), I realized that the best
online options out there are not good enough. I have been using [dotepub.com](https://dotepub.com/) which seems popular and
converts to both the generic Epub format, and the Kindle-specific Mobi format. While it does a good
job with all the text, this particular article was particularly heavy on images, and all the images
were required to understand the text. When I converted the page to an Epub format, it told me that
it would not include all the images from the article. So, I set out to write a few scripts which
could fix that problem and actually export web pages as self-contained epub files.

<!--more-->

_Aside:_ You can skip this explanation and directly read the scripts [here](https://github.com/icyflame/html-to-epub).

Dotepub's hesitation to download all the images, and then include them in the epub file, is probably
an attempt to restrict the amount of bandwidth that is consumed by each user. As a user-facing
service, where the developer would have to spend quite some time to prevent abuse, I understand
that. While the epub file **will certainly** get bigger when you include all the images from an
article, I doubt that anyone on a broadband connection will mind that. And they have _anyway_ loaded
all the images locally on their computer once. Downloading an Epub container with the same images
might be something that they explicitly want to do (and that's why they are using dotepub in the
first place.)

Before converting the raw HTML of the webpage into an Epub file though, it is important to
understand the structure of the Epub file itself. And to do this, I checked out [this talk](https://www.blackhat.com/eu-21/briefings/schedule/#how-your-e-book-might-be-reading-you-exploiting-epub-reading-systems-24898) from the
BlackHat Europe 2021 conference ([Talk video](https://www.youtube.com/watch?v=ixSZyuPsXNU)). The talk has a clear explanation of what an Epub file
is (just a set of HTML, JS, CSS. Sound familiar?), what are its common constituents (some manifests
files that point to various locations with the data, the images), and the engines that ePub readers
use to render the content of ePub files. After this, I looked at some of the real world ePub files
that one can download from [Project Gutenberg](https://www.gutenberg.org/) to see how these are implemented in practice. I was
pleasantly surprised to see that the XML manifest itself was short, easy to understand, and
well-documented; and that it had very few **required** fields; with most of the fields being
optional. I guess eBook readers have to work with a huge variety of files so they impose the least
amount of constraints possible.

Around this time, I also found out about the [Readability](https://github.com/mozilla/readability) library, the library that is used by
Firefox to generate their excellent "Reader view" for pages with a lot of text. I wanted to use this
library because it would give me a cleaner, more ebook friendly version of the text that is
generally on webpages. Most magazine websites have sidebars, headers, and footers with links to
other articles or sections. All of these would just be distracting on an ereader device, which is
designed to take a blob of text and render it in a pleasant way.

I also found the [DOMPurify](https://github.com/cure53/DOMPurify) library, which sanitizes HTML and removes any cross-site scripting (XSS)
vulnerabilities from HTML. This is important because, as mentioned in the Blackhat talk, e-readers
**do** have the ability to run JavaScript. Even though my Kindle is not connected to a network most of
the time, it is still possible that the JavaScript that is part of these HTML pages reaches out to
external services (like Analytics.) I don't want these external requests to be made from my Kindle;
an environment which does not have the convenience of installing the [uBlock Origin](https://ublockorigin.com/) extension.[^1]

I experimented with some methods of downloading the webpage. I tried to download the HTML, and other
associated resources (CSS, images) manually, using some Node.js/Go code. I gave up on this approach
pretty quickly, because I realized that I was just re-implementing what every browser's rendering
engine already does well. Then, I used the "Save" feature built into Firefox. This feature is very
good and works well when you want to save just the images on a page. But it did not work well to
create an exact copy of the page, because many of the resources that were referred to on the webpage
could be served from another domain (such as a webpage `example.com/article` which downloads static
images, CSS and JavaScript from `static.example.com`.) This is a common pattern and followed by many
websites. So, consider that `example.com/article` refers to 2 images `example.com/images/first.png`
and `static.example.com/images/second.png`. On saving the webpage, the first path would be changed
to `/images/first.png` and rendered properly. However, the second path would be left untouched by
Firefox. So, the simple Save feature did not work either.

My third attempt worked well: [SingleFileZ](https://github.com/gildas-lormeau/SingleFileZ). SingleFileZ is a browser extension which allows you to
download all the resources that are required to render a webpage as a zip archive which contains an
HTML file and its associated resources. The paths to the resources are also appropriately
changed. As SingleFileZ attempts to create a copy of the webpage that will work without any network
connection, it downloads everything, renames those files, and prepares a new HTML file which is
completely self-sufficient. (It simply does not care about which domain the resource originally came
from.) Also, files are neatly arranged based on their type; i.e. images are all put inside a single
folder. This extension is really useful even if you plan to just re-read magazine articles directly
on a computer.

After downloading the HTML, and putting it through DOMPurify and Readability, I planned to use
Pandoc (inside a Docker container) to convert the resulting HTML file into an Epub file.

With these three pieces, the only part left was to write some Node.js code to deal with the HTML and
some Bash script which would invoke these tools in the correct order. This was fairly simple. One of
the hiccups that I ran into along the way was that the HTML that is produced by many websites is not
valid (i.e. some closing tags are omitted). Pandoc expects strict HTML as input. So, I had to
convert from HTML to XHTML using Pandoc once, and then convert from XHTML to Epub in the second
step. This worked well and produced very readable Epub files.

There are still _many_ shortcomings in the process. The most glaring one is that there is no cover
image for the Epub files that are generated. Although we have all the images from the webpage,
deciding which one should be the cover image would require manual intervention. For now, I use the
Kindle's Library List view which shows the title of the books as a list, rather than the (visually
pleasing) Covers view, which shows a bookshelf with book covers arranged on it.

-   [Scripts on GitHub](https://github.com/icyflame/html-to-epub/blob/master/batch-html-to-epub.sh)

[^1]: I know why this extension is not a default on all browsers: because it will hurt the bottom lines of the companies making the browsers, which also _happen_ to be running, by complete coincidence, the biggest advertisements networks. But I don't know why users are still using the Internet on a browser which does not have this extension installed. Install [uBlock Origin](https://ublockorigin.com/) now!
