---
layout: post
comments: true
title: Configuring Emacs - 7 months later - Act 2
categories: emacs editors tools configuration
series_id: configuring-emacs
---

_Note:_ This is the second in a series of 3 posts about my experience configuring Emacs over 7
months, starting from scratch.

- [Post 1: Fundamentals][1]
- [Post 2: Keybindings and Package Integration][2]
- [Post 3: Writing Emacs Lisp Functions][3]

[1]: /emacs/editors/tools/configuration/2020/11/15/configuring-emacs-7-months-later-act-1
[2]: /emacs/editors/tools/configuration/2020/11/21/configuring-emacs-7-months-later-act-2
[3]: /emacs/editors/tools/configuration/2020/12/01/configuring-emacs-7-months-later-act-3


<a id="orgec4b729"></a>

After figuring out how to install packages, as you start to use the editor more, you run into cases
where the keybindings are inconvenient or don't exist at all. During this phase, the 3 months
between June and August, I added a lot of keybindings. Most of them were to mimic the functionality
that I had configured with Vim over some time. A lot of them were new keybindings which made sense
only in the Emacs world.

<!--more-->

At this point, I was using Emacs everyday for non-code related editing. Towards the end of this
period, I installed some major modes which allowed me to program in Go within Emacs, but my first
attempt at the installation of these modes was terrible and I had a very bad experience. After
giving up for a short period of time, I returned to the problem once again and figured it out the
second time around. This story is longer and I want to keep it for another blog post.

- [Act 2: Keybindings and Package Integration](#orgec4b729)
  - [Navigation using `Ctrl + H/J/K/L`](#org54cf0c5)
  - [Keybindings to comment code](#orgc1a4811)
  - [Hooks](#org05e0dfd)
  - [Mode maps for Keybindings](#orge17068c)

<a id="org54cf0c5"></a>

## Navigation using `Ctrl + H/J/K/L`

[c458cc48](https://github.com/icyflame/.emacs.d/commit/c458cc48)

```elisp
(general-nmap
  "DEL" 'evil-ex-nohighlight
  "C-h" 'evil-window-left
  "C-j" 'evil-window-down
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right
  )
```

Navigation between various splits using `Ctrl` and the Home row keys was another one of the base
requirements for me when I started using this editor. After installing `general.el` and reading
evil-guide 10-20 times, I was able to figure out how to add the appropriate bindings for moving
around splits using general.

The most confusing part of this were the quotation marks. Emacs allows functions to be specified
with `#'` or with a simple single quote. There does not seem to be any difference and you can use
either of those forms.


<a id="orgc1a4811"></a>

## Keybindings to comment code

[99683e0f](https://github.com/icyflame/.emacs.d/commit/99683e0f)

```elisp
;; 24. Keybindings that use the leader key functionality in normal and visual mode
(general-create-definer leader-def-visual-mode
  :states '(visual)
  :prefix ","
  )
(leader-def-visual-mode "c SPC" 'comment-or-uncomment-region)

(general-create-definer leader-def-normal-mode
  :states '(normal)
  :prefix ","
  )
(leader-def-normal-mode "c SPC" 'comment-line)
```

This was the first section of the configuration which was more than just using a built-in function
directly. I was starting to understand what these functions were doing and I was able to get the
leader key behavior that I have always liked for commenting and un-commenting code in Vim. The
`comment-or-uncomment-region` function is a Emacs-only feature which inherently understands the
comment pattern for the language that is being edited.


<a id="org05e0dfd"></a>

## Hooks

[eae9cc91](https://github.com/icyflame/.emacs.d/commit/eae9cc91)

```elisp
;; 26. Remove trailing whitespace characters from all files
(add-hook 'before-save-hook 'delete-trailing-whitespace)
```

Hooks are a major part of Emacs. Until now, I have found that they are the main pathway for
connecting modes with each other (e.g.: Run the spell-checking mode when the file type is Org). They
are also very useful for doing things like the above configuration block, which deletes trailing
white spaces from all file types before saving the file to disk.


<a id="orge17068c"></a>

## Mode maps for Keybindings

[71c9a782](https://github.com/icyflame/.emacs.d/commit/71c9a782)

```diff
-  ;; TODO: This should be active only in the org mode key map
   (ctrl-keybindings
+	:keymaps '(org-mode-map)
	"C-c l c" 'org-cycle-list-bullet
+   "C-c e" 'org-table-edit-formulas
	)

+  ;; 23. SQL format highlighted region
+  (general-evil-define-key 'visual sql-mode-map
+	"gq" 'run-sqlbeautify
+	)
```

This is another Emacs-only concept which was hard to understand for me when I tried to map it back
to the knowledge I had about editor configuration already. After a few months of getting used to
this, I am much more confident about adding new keybindings. For e.g., when I started testing
[elfeed](https://github.com/skeeto/elfeed) today, I added several keybindings within the first few hours of using it:

[1c672f7a](https://github.com/icyflame/.emacs.d/commit/1c672f7a)

```elisp
;; Elfeed Search's default mappings work are for Insert mode only
(general-evil-define-key '(normal visual) elfeed-search-mode-map
  "RET" 'elfeed-search-show-entry
  "u" 'elfeed-search-tag-all-unread
  "r" 'elfeed-search-untag-all-unread)
```

This evolution from not understanding what a mode map means or does, to understanding and being able
to use it properly was satisfying for me. This process takes time, and if you are switching to
something new and are having trouble not understanding things that everyone else treats as <span class="underline">basic</span>,
I would tell you to simply stick with it for a few more months and see if you understand it better
then. ([Johnny Harris](https://www.youtube.com/channel/UCmGSJVG3mCRXVOP4yZrU1Dw) has [a great video](https://www.youtube.com/watch?v=zKDe094o-Q8) about how he figured out how to photograph far-away galaxies
that runs along the same lines.)
