---
layout: post
comments: true
title: More about vim's formatlistpat, formatoptions and comments options
categories: vim configuration
---

I recently [changed][1] my vimrc file to set the `formatlistpat` variable
explicitly for markdown files. Before making this change, I had to dive into the
vim help pages and find out what option I really needed to change to get
un-ordered lists to start working write.

## The Problem

I like Markdown a lot. I take all my daily notes at work and at home in
Markdown. It works well for me. Also, I recently discovered the Docker image
that will help me convert from Markdown to any format effortlessly using a
simple [docker oneliner][2] and the docker image `jagregory/pandoc-docker`.

<!--more-->

One of the things that's literally a part of everything that I start writing is
a list. My over-all file is structured as a list, so I care a lot about the
indentation of list entries. Before I made the change I started this post with,
my lists looked something like this:

```md
- This is a list item
- This is a very long list item that wraps
to a second line
- This is another list item
```

See how the second item starts from the beginning of the file and _not_ from the
first alphabet in the previous line? I realized that this was strange when I
wrote this:

```md
1. Task 1
2. Task 2: Keep track of the changes you made
   in Task 1
3. Task 3: Perform in parallel with Task 2;
   Might need help from someone else
```

and indented it with vim's `gq`. I realized that Vim was capable of
understanding lists and formatting list items properly. Every time I have tried
to indent an un-ordered list in Vim with `gq`, it absolutely fails and I just
have to go around and do it myself. But this great behaviour with numbered lists
showed me that there some option I could change to fix this.

## The Deep Dive

First, I started looking for an add-on that unordered lists well. I started with
`plasticboy/vim-markdown`. It is one of the most popular markdown plugins for
vim and I have never really tested it properly. So, I started off with it.
But it didn't really solve the problem, I got the feeling that it even made it
worse somehow. I started looking online for other people who had run into this
problem and this is where I started reading about Vim options.

I reached this incredibly enlightening [vim-markdown issue][3]: `Rewrapping a bullet
point inserts new bullet points` => This was happening to me every time I tried
to write a multi-line list item and wrap it with `gq`.

This issue had a few great `vim` options which were mentioned during the
discussion around the bigger problem:

- [`comments`][4]
- [`formatlistpat`][5]
- [`formatoptions`][5]

All three options seemed to be somehow connected to lists and their automatic
formatting when writing the text, and their formatting when explicitly
formatting with `gq` over that part or the whole file.

I started looking through vim options and trying to find where this difference
between numbered and unordered lists stemmed from. The in-built `:help` command
is really good and the descriptions of most of the configuration options are
_not_ confusing at all! Some of them are confusing, admittedly. But the
descriptions for these three were at least fairly simple.

> comments: A comma separated list of strings that can start a comment line

For markdown, the only character that behaves even remotely like a comment is
the `>` character used to create a blockquote. Often when writing blockquotes
which run multiple lines, it's useful if the editor would just wrap the text and
insert the `> ` characters at the beginning of each line as blockquotes tend to
be a single paragraph and a quick `gqip` fixing that is very useful. So, this
was the first option I changed. I changed it to be just `b:>`. I don't really
undersatnd what the `b:` is, but this immediately fixed the formatting of
numbered lists whenever I tried to do that! Unordered lists were still not
working well.

**Sidenote:** Running `:put=&comments` puts the value of the `comments`
configuration into the current buffer! I found this extremely useful when trying
to inspect the configuration value of a regex without having to stare at the
bottom line where the values are generally displayed.

> formatlistpat:  A pattern that is used to recognize a list header.  This is
> used for the "n" flag in 'formatoptions'.
> default: "^\s*\d\+[\]:.)}\t ]\s*"

Aha! `formatlistpat` and `formatoptions` are related! And the default regex is
pretty easy to understand: it matches things of the form `1.` or `1)`; i.e.
numbered lists only! WHAT! I checked the value of `formatlistpat` for the
markdown buffer I was writing my notes through this dive in:

```
^\s*\d+\.\s+|^[-*+]\s+|^[^\ze[^\]]+]:
```

I didn't really understand this regex. I could see that it was trying to read
numbered and unordered lists, but the third section in this regex with the `\ze`
eluded me. In any case, I figured that if I could simplify this regex and write
one myself which solved only the case that I cared about (unordered lists
starting with a `-`), then I could change it later as I saw fit. So, I replaced
it with just the middle part of the regex: `^\s*[-*+]\s`. I inserted the
unlimited number of optional whitespaces at the beginning of the line because
nested lists are definitely part of my note-taking style.

Now, as I tried wrapping list items, I saw that it worked as I expected!

```md
- This is a list item
- This is a very long list item that wraps
  to a second line
- This is another list item
```

I still didn't quite understand the `formatoption` configuration though.

> formatoptions: This is a sequence of letters which describes how automatic
> formatting is to be done.  See |fo-table|

The `formatoptions` value in my editor was: `tcqln`. Looking at the `fo-table`,
I saw that it did most of the things that I was taking for granted:

- Auto-wrap at textwidth
- Auto-wrap comments at textwidth but insert the comments character
- Allow formatting with `gq`
- Leave long lines as is when entering Insert mode
- When formatting texts recognizes lists using `formatlistpat` regex

The meaning of the `n` option was particulary interesting to me. The help text
clearly specifies that although the option is called `n` for "numbered list
formatting", lists are identified using `formatlistpat` which can identify any
kind of list that you might come up with. (If you start your list items with
letters, instead of hyphens or numbers, just set up `formatlistpat`!)

At this point, I had two more things that I wanted to do:

1. Improve the regex to recognize numbered lists
1. Improve the regex to recognize lists of TODO items in markdown
    ```sh
    - [ ] Todo Item 1
    - [ ] Todo Item 2: This is a long
          todo item
    ```

I am still working on the second part of this. For the point about numbered
lists, I have really started re-evaluating if I even need numbered lists. I
don't ever write numbered lists if I can help it. (The ordering of lists is
quite clear from the fact that we read text vertically downwards and it wouldn't
make sense for the third list entry to be the first point when writing the same
list in an un-ordered format)

---

Another on-going problem that has been slighlty more annoying has been vim's
strange formatting whenever the content inside a parentheses goes beyond a
single line or I end the previous line with a `,` (comma). I am not yet sure
which option is causing this particular problem, but whatever that option is, I
am going to find it and I am going to change it.

[1]: https://github.com/icyflame/dotfiles/commit/8b55363828e7794aa33166363c9ebdd51a46ebda#diff-2152fa38b4d8bb10c75d6339a959650dR344
[2]: https://github.com/icyflame/oneliners/commit/0301348531dbc712815115a88f2767196858caf0#diff-04c6e90faac2675aa89e2176d2eec7d8R188-R191
[3]: https://github.com/plasticboy/vim-markdown/issues/232
[4]: https://github.com/plasticboy/vim-markdown/issues/232#issuecomment-392265461
[5]: https://github.com/plasticboy/vim-markdown/issues/232#issuecomment-246173676
