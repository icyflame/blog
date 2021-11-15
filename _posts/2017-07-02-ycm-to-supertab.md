---
layout: post
comments: true
title: Switching to SuperTab; A new Crichton thriller, WHAT?!
categories: books vim editor plugins
---

Ever since I started using Vim as my primary browser, I have been using
[YouCompleteMe](vimawesome.com/plugin/YouCompleteMe) as the completion plugin.
It works _fine_, it is annoying because it tries to autocomplete **everything**
and sometimes that gets in the way of navigation using the arrow keys. In any
case, I was fairly happy with the plugin's performance because it never really
slowed down my editing experience. Until a couple of weeks ago.

That was when I saw that the editor just hung for some amount of time, and it
was really trying to find suggestions for the word I was typing. This was really
hampering the time it took for me to actually write code. And thus, I set out on
my search for a better plugin.

One thing about YCM that is slightly irritating is that it has a compiled
component. This compiled component doesn't build on computers that have less
than 1 GB of RAM (Looking at you, $5 a month Digital Ocean droplets.)

I tested [neocomplete.vim](vimawesome.com/plugin/neocomplete-vim). It doesn't
have a compiled component and has some really extensive configuration options.
That include using `<CR>` as the key to confirm suggestions. That was rather
pleasant, perhaps when I have a computer with more RAM and a better processor,
neocomplete would be the option. (It is most certainly better than YCM, simply
the lack of compiled component ensures that!)

Coming back to my own quandary, I found this new set of completion plugins that
show you suggestions but work on pressing the `TAB` button. It's pretty
interesting, and I started using
[SuperTab](https://github.com/ervandew/supertab). I am still reserved about how
_useful_ it is, perhaps I will report again after a few weeks of use.

I have also just started reading [Dragon Teeth - Michael
Crichton](https://www.goodreads.com/book/show/31287693-dragon-teeth). It's
really surprising that a new Crichton book was released less than a month ago,
seeing as Crichton himself died in 2008. I haven't read up on the history but I
guess this manuscript was _discovered_. I am about 50% through the book (one 5
hour train journey ensured that!) and it's been riveting till now. The strange
antiquated habit of journaling really takes on a life of it's own throughout the
book (as most of the narration is either the experience itself or what one of
the characters recorded in their journal).
