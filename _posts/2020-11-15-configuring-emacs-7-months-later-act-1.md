---
layout: post
comments: true
title: Configuring Emacs - 7 months later - Act 1
categories: emacs editors tools configuration
---

My first commit to [icyflame/.emacs.d](https://github.com/icyflame/.emacs.d), the repository with my Emacs configuration, was in April this
year (7 months ago). Now, I have reached a point at which I have cleaned up my configuration enough
to feel okay about making it open source. In this post and the two posts after this one, I will go
over some of the most important steps in my configuration's evolution from scratch to it's current
form.


<a id="org7101517"></a>

# Context

I started my configuration from scratch with a vanilla Emacs installation. This is a personal
preference; there are several configurations out there which allow people to start from a
opinionated configuration which they can understand and tweak to their needs. (There are even Emacs
distributions like [Prelude](https://github.com/bbatsov/prelude) which have a lot of the plugins which I configured manually already
installed!)

<!--more-->

This post is not really meant as a guide for the reader to get started with Emacs or copy my
configuration and use it as is; that is not my goal anyway. My main goal here is to talk about the
things in my configuration which feel obvious to me now, but were particularly difficult to figure
out when I initially tried to figure it out. Along the way, I will also try to share some of the fun
things I discovered about Emacs Lisp, a language that is equal parts fascinating and obscure.

That said, if you plan to use parts of my configuration and are unable to figure out why something
is not working, I would love to hear your questions and help with figuring out the reason!


- [Act 1: Fundamentals](#org8b8b4a0)
  - [Package Management](#orgc8426a7)
  - [Evil mode and general.el](#orgff92eb3)
  - [Don't install Helm](#org9b39a7b)
  - [Org mode](#org9dc088c)

<a id="org8b8b4a0"></a>

# Act 1: Fundamentals

Right after installing Emacs, I wanted to figure out a stable method to install new packages from
using Emacs' package management system. I wanted to ensure that this would be done using
configuration, and not using ad-hoc commands. My motive for this requirement was mainly the ease of
migrating this configuration between my personal and my work computer (I started using Emacs on my
personal Linux machine at home; I use a Macbook Pro at work (from home)). For the 2 months between
February and April, I was using Emacs everyday without any major changes to the base empty
configuration that every installation comes with. This was not a very good experience, and I kept
switching back to Vim whenever I had to do anything that was slightly more complicated than typing
text.


<a id="orgc8426a7"></a>

## Package Management

I got the `require-package` function from [purcell/emacs.d](https://github.com/purcell/emacs.d/blob/754a3ce1871f44c0c235887c18a32ac5dc799eb7/lisp/init-elpa.el#L29-L43). Back then, I didn't fully understand what
this function was doing. But the promise of this function was that it would provide a portable way
to install packages from Emacs' package registry, [Melpa](https://melpa.org/#/).

```elisp
;;; from purcell/emacs.d
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
	  t
	(if (or (assoc package package-archive-contents) no-refresh)
		(package-install package)
	  (progn
		(package-refresh-contents)
		(require-package package min-version t)))))
```


<a id="orgff92eb3"></a>

## Evil mode and general.el

[4d083a63](https://github.com/icyflame/.emacs.d/commit/4d083a63)

```elisp
;; 12. Install general package
(require-package 'general)

;; 13. Add key mappings for common actions using general
(general-evil-setup)
(general-nmap
  "DEL" 'evil-ex-nohighlight)
```

After figuring how to install packages, the first package I installed was `evil`. This package
brings in most of Vim's keybindings. Installing this package right at the beginning is a
double-edged knife, as it simultaneously makes Emacs more familiar <span class="underline">and</span> contributes to making
configuring Emacs harder to figure out. Evil's configuration options are, <span class="underline">for the most part</span>,
exactly the same as Vim. But the parts that are different are hard to understand and I was flummoxed
by these differences for about 2 months. During this period, [noctuid/evil-guide](https://github.com/noctuid/evil-guide) was my main
reference. The Readme of this repository is comprehensive and explains everything about Evil mode. I
read this Readme several times to figure out exactly what was different, and how I could get rid of
these differences completely.

general.el was a harder choice because I was not quite sure what this package did, but it was highly
rated and everyone seemed to be using it. evil-guide talked about this package with high regard, and
claimed that it would make configuring Evil mode easier. So, I took a leap of faith and decided to
install it.


<a id="org9b39a7b"></a>

## Don't install Helm

Installing [Helm](https://github.com/emacs-helm/helm) early on was a mistake. [Helm](https://github.com/emacs-helm/helm) is an extremely powerful package, that is very hard to
use and understand. It is often referred to as a replacement for `Ctrl-P`, but in reality, it has a
lot more bells and whistles. These extra features make it very hard to understand where Helm ends
and where Emacs begins. Using Helm within an editor whose keybindings you are not yet familiar with
is hard. Personally, I think this was a big mistake and delayed my configuration efforts by about
the 2 weeks that it took me to realize what was going on and uninstall Helm.


<a id="org9dc088c"></a>

## Org mode

[22187304](https://github.com/icyflame/.emacs.d/commit/22187304)

```elisp
;; 18. Org mode settings
;;; Set the done time for a TODO item when moving it to DONE
(setq org-log-done 'time)

(setq org-todo-keywords
	  '((sequence "TODO(t)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
```

I started using Org mode around April 28 when I made a commit to introduce the TODO states that I
wanted to have in my Org file. This was right after watching the [original talk about Org-mode](https://www.youtube.com/watch?v=oJTwQvgfgMM). I am
glad that I started using this early on as I was able to understand a lot more about how Emacs works
as an editor (For e.g.: keybinding maps per mode, the global mode, minor modes, mode hooks) by
configuring Org-mode, a non-programming mode whose configuration is much easier to understand.
