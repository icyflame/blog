---
layout: post
comments: true
title: Firefox Add-on to jump from GitHub to CircleCI extremely fast!
categories: dev-tools github circle-ci firefox extensions
---

## What?

I use GitHub and CircleCI at work. One of the most common workflows for me, is
to merge a PR, click on the repository name to go to the repo page, scroll down
to the Readme and click on the CircleCI indicator to check the status of the CI
job kicked by the merge.

When the CI workflow is done and completes successfully, I go back to the repo
page and click on "Releases", create a new release (a Git tag) and then again go
to the readme to go back and wait for the Release CI to finish.

Once that is done, I open Spinnaker and wait some more for that to get
triggered. For reason, [Spinnaker][1] takes about 10 minutes to detect that a
new image with a tag matching a provided regex was pushed to GCR.

In any case, you might have noticed that I switch between GitHub and CircleCI a
lot. Now, most repositories at work have a CircleCI indicator at the top. If
they don't, there's always the option to open a PR and wait for someone to
approve it and then you can finally merge it. But this whole process was
extremely annoying to me, because there's no _need_ for this indicator.

You see, the link patterns are fixed and extremely easy to generate using just
regex!

GitHub:   `https://github.com/username/repository/.*`
CircleCI: `https://circleci.com/gh/username/repository/`

So, all you really need to do is replace the beginning and remove anything after
the end of the repository name: that's a textbook usecase for a bookmarklet with
JavaScript!

## Why _not_ a bookmarklet?

So, I wrote a bookmarklet. Very short and sweet!

```javascript
javascript:
var url = location.href;
if (url.match(/https:\/\/github.com\//)) {
    var baseRemoved = url.replace('https://github.com/', '');
    var components = baseRemoved.split('/');
    if (components.length >= 2) {
        var account = components[0];
        var repo = components[1];
        var newURL = "https://circleci.com/gh/" + account + "/" + repo;
        location.href = newURL;
    }
}
```

I add it into a bookmark and click it. Nothing happens. The console shows me an
error that sort-of tells me something useful, but not really:

![error][2]

CSP [shouldn't][3] affect bookmarklets, but it [does on Firefox][4], for the
[time-being][5] at least. The issue in Firefox that stops the bookmarklet from
running has been going on for nearly 6 years now! That's an awful lot of time
people have been dealing with this.

## The Add-On!

Extensions have more permissions than a bookmarklet. A user consciously installs
them and they are reviewed before they go on the Firefox add-on store. I started
looking through the [add-on developer documentations][6] to find the right APIs
that I wanted. Originally, I was looking for a keyboard shortcut. But I realized
that that would be tough and that I should stick to doing a clickable element
before aiming higher.

My next plan was to add a fixed HTML element on all GitHub repository pages
which would give me a reliable method to switch from GitHub to CircleCI no
matter which computer I was on. This reliability was particularly important to
me, I wanted the element to be in the same place on all GitHub repository pages.

Turns out the way to do that is something called a [page action][7]! It looked
perfect for my use-case. It was a button near the address bar. As a cherry on
top, I could [connect a keyboard shortcut][8] to it using a `command` construct!

The Firefox add-on documentation is extremely good! They have example extensions
which use each JavaScript API that is supported, and for `pageAction` it was
[`apply-css`][9]. Going through this extension's `background.js` and
`manifest.json`, I was able to quickly come up with a dev version.

After that, I cleaned the code up some more, made sure that it had icons and the
other images that were required were present (I used Gimp for a few minutes. By
any designer's standards, [this icon][10] is probably hideous)

After pushing the add-on code to GitHub, I created the add-on bundle and
uploaded it to the Firefox store. I did that at 2019-08-24 17:00 JST (UTC+0900).
It's been 24 hours, and I have gone from spot 22/22 to 5/22 now. I don't know if
the review is taking longer because it's the weekend or what.

![queue-spot][11]

## Bonus: A Chrome extension! What?!

Most of my co-workers use Chrome and I have read a little bit about the
WebExtensions API and how it's a standard and can be used across browsers and
what not. So, I wanted to give it a quick try and see if I could make it work on
Chrome with a few tweaks. It turned out to be fairly easy! The Chrome store
forces on you several severe restrictions: 

- A 128x128 icon which has 16 transparaent pixels on both sides
    - Why must Google force the developer? Surely, they can pad the image once
    it has been uploaded and transform it to whatever size they want as long as
    the aspect ratio is 1:1 (Square)
- A 1280x800 screenshot
    - Funnily enough, they will NOT accept ANY size except 1280x800. That I find
    very hard to digest because most HD screen-shots are 1920x1020 which can be
    naturally resized to 1280x720. This 1280x800 thing is particularly strange.
    - Anyway, I opened up Gimp and used the Align tool to make an image that
    size.
    - **P.S.** I am really starting to warm up to how useful Gimp has been lately!

Once, I jumped through those hoops and had the right images, I was able to
submit my add-on and voila, there my extension was! No review process to get
things on the Chrome Extensions store. That would make me squeamish, if I was
using Chrome as my daily-driver and had a couple shady extensions.

- [Firefox Add-on][14]
- [Chrome Extension][12]
- [GitHub Repository][13]

[1]: https://www.spinnaker.io/concepts/
[2]: /public/img/github-bookmarklet-image.png
[3]: https://github.blog/2013-04-19-content-security-policy/#bookmarklets
[4]: https://bugzilla.mozilla.org/show_bug.cgi?id=866522
[5]: https://bugzilla.mozilla.org/show_bug.cgi?id=1478037
[6]: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons
[7]: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/pageAction
[8]: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/commands#Special_shortcuts
[9]: https://github.com/mdn/webextensions-examples/tree/bbacbd0c40eb41622625584355baf077ed598669/apply-css
[10]: https://raw.githubusercontent.com/icyflame/open-circleci-workflows-firefox/master/icons/open-circleci-workflows-96.png
[11]: /public/img/github-bookmarklet-store-review-queue.png
[12]: https://chrome.google.com/webstore/detail/open-circleci-workflows/fcjcanbkalgfniilkedfjgaglfgdjlcb
[13]: https://github.com/icyflame/open-circleci-workflows-firefox
[14]: https://addons.mozilla.org/en-US/firefox/addon/open-circleci-workflows/
