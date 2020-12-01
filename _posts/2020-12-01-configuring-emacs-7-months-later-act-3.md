---
layout: post
comments: true
title: Configuring Emacs - 7 months later - Act 3
categories: emacs editors tools configuration
---

_Note:_ This is the final post in a series of 3 posts about my experience configuring Emacs over 7
months, starting from scratch.

- [Post 1: Fundamentals][1]
- [Post 2: Keybindings and Package Integration][2]
- [Post 3: Writing Emacs Lisp Functions][3]

[1]: /emacs/editors/tools/configuration/2020/11/15/configuring-emacs-7-months-later-act-1
[2]: /emacs/editors/tools/configuration/2020/11/21/configuring-emacs-7-months-later-act-2
[3]: /emacs/editors/tools/configuration/2020/11/21/configuring-emacs-7-months-later-act-3

<a id="org8af0131"></a>

Emacs Lisp is the language that is used to configure Emacs. It is a functional programming language
and looks very similar to the prefix notation that is used when doing simple arithmetic:

```elisp
(/ 2000 (+ 34 4.5))
51.94805194805195

;; Insert the current time string at point in the active buffer
(insert-string (current-time-string))
```
<!--more-->

- [Act 3: Writing Emacs Lisp Functions](#org8af0131)
  - [Delete all comments from a buffer](#orgfff7e2f)
  - [Copy the contents of the current buffer](#orgcfe5ed0)


<a id="orgfff7e2f"></a>

## Delete all comments from a buffer

[e501bb0a](https://github.com/icyflame/.emacs.d/commit/e501bb0a)

My goal at this point was to write an Emacs function that would delete all the comments from a
file. This goal was a fairly simple one (I thought) because I was using a Regular expression in Vim
to do this: `:g/^#/norm dd`. I used the `#` because I deleted all comments only from shell files
which were copies of the commands that I had run (My PS1 starts with a hash to ensure that when I
ran this command, personal information like my host name or the path will be stripped).

In late October, 6 months and 9 days after I made my initial commit, I was able to write a function
which actually deleted all comments from a buffer.

I faced some interesting challenges when I was writing this function. My original goal seemed
extremely simple: Delete a line if it is a comment; run this for the whole buffer. Thinking like an
editor, I decided to do this on a line-by-line basis.

One of the interesting challenges was figuring out when I was at the end of a buffer. Emacs does not
seem to have any function to get the last line. There are functions to get the last byte position,
but none to get the last line, that I was able to find. So, I had to manually keep track of whether
I was deleting a line. This lead to a function which would call another function and depending on
whether the line was deleted, subtract one from the original `last-line-number` value.

This process was full of other challenges that were related to my inability to find the name of the
function that I wanted to use quickly. Emacs functions are not all named using some common pattern,
which would make them easier to find. For e.g.:

-   `line-number-at-pos` returns the line number at the current position
-   `(beginning-of-buffer)` moves the cursor to the beginning of the buffer, `(forward-line)` moves
    one line ahead
-   `(kill-whole-line)` deletes the current line.

As you can probably see, there's no common convention here. All functions that deal with lines
don't <span class="underline">start</span> with `line-`, they simply <span class="underline">have</span> the `line` word in them!


<a id="orgcfe5ed0"></a>

## Copy the contents of the current buffer

The goal for my second function was to copy the contents of the current buffer to the system
clipboard. Writing this function took far less time, and I was able to find the functions I needed
to use fairly easily. It was also much smaller; in fact, it had only 5 lines:

```elisp
(defun copy-buffer ()
  "Copy the complete buffer to the system clipboard"
  (interactive)
  (kill-new (filter-buffer-substring (point-min) (point-max)))
  nil)
```

My main problem here was the terminology. The Emacs terminology for everything is <span class="underline">different</span>:

-   `yank` – paste
-   `kill` – cut, that is, delete and copy to the kill ring

What I wanted to do was <span class="underline">copy</span>, I could find anything close to this in the [Emacs glossary](https://www.emacswiki.org/emacs/Glossary). After
reading some more, I realized that the `kill-ring` was similar to the clipboard and pushing things
onto that ring is the same as copying something. And that is how I reached this function
`kill-new`. This function pushes it's first argument to the ring => essentially copying that string.
