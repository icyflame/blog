---
layout: post
comments: true
title: Oh-My-Zsh to Prezto - 4 seconds faster
categories: shell zsh prezto
---

I have heard a lot about [prezto][1]. People who work with me use it and we got
into this recent discussion about how slow a `curl` request inside your zshrc
makes your shell. Strangely enough, I hadn't noticed that it made the shell slow
at all. In fact, I was saying that it didn't make it any slower than without it.
I removed it from my `zshrc` and checked it and indeed, it didn't make my shell
any slower.

A few days went by; I was thinking about this when I was next thinking about why
I hadn't noticed this clear increase in the time. So, I looked at the time my
shell took to start up again. It was ... interesting: **6 seconds**.

YUP. 6 seconds on a machine with an SSD, 16 GB of RAM and an i7 processor. So,
what is the problem here?

## The Search

I have a [zshrc][2] that sources several other files when it loads. Going
through my main zshrc and all those zsh files, I saw that everything in there
was a definition: `export`, `alias`, `function`. Apart from this, I was sourcing
a few other things: `fzf` and `oh-my-zsh`. Testing these separately, I could see
that these were extremely fast and not the culprit.

That's when I realized that I would have to profile my `zshrc`

```sh
echo "START: `date +%s`"

st=`date +%s`
# op
endt=`date +%s`
echo "op_name: $(($endt-$st)); $st -> $endt"
```

I added a bunch of blocks like the one above to my zshrc. I sourced a few times.
I kept adding and removing these blocks. I eliminated the sourcing of the 18 or
so zsh files in my `dotfiles` -> They were all happening within the same second.
I looked at the plugin loader, the definition and sourcing of some add-ons like
`travis` and `cargo`, but they all happened very fast too.

The strange thing was: I couldn't find the culprit. Every step that I profiled
happened very fast, and YET, the whole process took nearly 6 seconds. What was
going on here?

## The Realization

I started searching for reasons and people running into this hurdle before. I
had prezto in the back of my head, so I searched for that and comparisons too.
_That_ was when I reached [this][3] amazing article. The author put it quite
succinctly:

> Zsh is an amazing shell, ... **BUT. It’s God. Damn. Slow!**

Those were my feelings too. I have used oh-my-zsh for nearly 5 years now, it has
served me very well. It has helped me get through some tough times (I am almost
certainly romanticising); But it was time.

I read [another article][4]. The steps were very simple. My configuration would
work as is. The one thing that wouldn't work would be the prompt. I would have
to find a prompt I liked; Or, if it was _un-obscure_ enough, recreate my beloved
[ys][5] on prezto. (More about why I love this prompt so much in the Postscript)

## The Switch

Having mulled over this enough, I decided to go for it. It was quite clear in my
head, the only things that could really break were my prompt and my color
scheme. Both things that couldbe reverted by cleaning everything up and making a
new install of oh-my-zsh and trying another weekend. With that re-assurance, I
copied my existing `~/.oh-my-zsh` into a backup folder, commited and pushed
everything in my `dotfiles` and began.

```sh
git checkout -b switch-to-prezto
```

The process was fairly simple. After `uninstall_oh_my_zsh` and installing prezto
using the commands on the readme, I had a running shell. My zshrc was working
well. Perhaps the thing that most surprised me was that the color scheme was
unaffected! I have dealt with fixing the color scheme before and it was
incredibly obscure, undocumented and painful. So, that is one thing I was
extremely grateful for.

Having ensured that the shell itself worked without any of the stuff on top of
it, I started looking at the list of plugins (prezto calls them [modules][6])
that I wanted. I ensured that I was getting `fish`-like auto-suggestions before
I even contemplated this move because that is one of the most useful things
EVER! (It's so incredibly fast; compared to even `fzf`)

I included the ones that I absolutely needed and auto-suggestions and
syntax-highlighting started working! It was surprisingly easy and in fact,
easier than oh-my-zsh which is so popular because it is easy and versatile. I
had quite a bit of trouble setting up the right colors in oh-my-zsh with
auto-suggestions because the color has to be dimmer than the color you are
typing in but at the same time, it has to have enough contrast with the terminal
background to ensure that you can see the suggestion without straining your
eyes. I had hit the right balance with this with a slight change on top of
solarized-dark.256 and I didn't want to go through setting this up again.
Thankfully, prezto worked fine the first time!

At this point, I had a working shell with all my aliases and functions; `vim` mode
in the shell was working fine too. The experience till now had been good. The
one thing left to configure: The Prompt.

## The Prompt

**TL; DR** I couldn't find the prezto equivalent for `ys`, so I wrote a prompt
that looks exactly like `ys`.

I like `ys` because it doesn't have any crazy characters. The green "o" looks
just as gratifying as the green tick mark. The red "x" is almost
indistinguishable from the red UTF8 "x" mark. One of the main reasons I chose
`ys` was because it has only ASCII characters. That ensures that it looks good
everywhere: Ubuntu, Mac OS, even Windows would have worked fine (if I had ever
tried to make it work there). There was no `ys` clone for prezto, which was
quite surprising; I was confident I would be able to get away copying some text
around without having to understand how prompts are written. Hard luck there!

So, I started writing this prompt. I copied `ys`'s [code][7] over to a file
which I thought would make it work. It was actually surprisingly close to what I
wanted. The colors were off because it seems there's a slight difference in how
colors are formatted in oh-my-zsh prompts and prezto prompts: 

- oh-my-zsh: `${$bg[white]on git:%}`
- prezto:    `${\%F{white}on git}`

- oh-my-zsh: `%{$reset_color%}`
- prezto:    `\%f`

After changing this around, things started looking very similar! In fact, the
only thing left was the git-related info in the prompt.

At this point, I realized that I would have to go deeper into the prompt world
or figure out the correct piece of code to copy from an existing prompt module.
I couldn't make the latter option work, so I decided to delve deeper into
the prompt world.

- [prompts on prezto][8]
- prezto's `vcs_info`
- [git module][10]
- [prompt theme minimal][11]
- [prompt theme sorin][12]

Reading all of those READMEs and looking at some of the existing prompt files, I
figured out how the flow of prompt files works. And ended up creating the exact
same thing that I had on oh-my-zsh! And I'm mighty proud of that! 

## The Result

At long last, I had reached the point where my prompt looked and worked as I
wanted it to. It was time for the test:

```sh
$ date +%s; source ~/.zshrc; date +%s
```

For some reason, the above command wouldn't print the time after loading the
shell. So, I measured the time to start a shell by opening a tmux pane or an
iTerm2 tab: **2 seconds**!

That's 4 seconds saved every time I decide to open a new pane in tmux!

My fork of `prezto` is [here][13]. My fork of `ys` on `prezto` is [here][14].

This is a completely new shell and I am
surprised at how similar it feels to oh-my-zsh and I don't feel like I have to
make any more changes, already. I might make some minor changes though, because
using the `git` module brings in a bunch of git-related aliases that I don't
particularly like having around. (Eg: `gcR` removes the top commit from your
branch. It's a soft reset and is probably useful, so I might keep that
one around. But there are a bunch of others listed [here][10] that I
don't like having around)

### Postscript

This has been the third project that I have done something real on which will
not get merged into the main project but will only be used by me. I am sort of
having a re-realization about how powerful open-source software is. These are
all fairly small projects. Being able to make these small changes in them to
make your workflow a lot faster and also give you the satisfaction of
understanding the tools you use on a daily basis is pretty empowering. All you
really need to be able to do this kind of thing is a some know-how about the
language that the tool is written in, the time to do it and the motivation to.

Doing this on a small scale, also kind of makes me wonder about the power of
being able to do this at a much larger scale: an embedded software engineer's
ability to make changes in the `http` library or a Linux kernel developer's
ability to tweak things to be _just so_.

[1]: https://github.com/sorin-ionescu/prezto
[2]: https://github.com/icyflame/dotfiles/blob/ce3e858e37eb2b7ea9efddefa9323ef3d0d70d62/zsh/zshrc.symlink
[3]: http://jeromedalbert.com/migrate-from-oh-my-zsh-to-prezto/
[4]: https://linhmtran168.github.io/blog/2013/12/15/ditching-oh-my-zsh-for-prezto/
[5]: https://github.com/robbyrussell/oh-my-zsh/wiki/themes#ys
[6]: https://github.com/sorin-ionescu/prezto/blob/1f4601e44c989b90dc7314b151891fa60a101251/modules/README.md#modules
[7]: http://blog.ysmood.org/my-ys-terminal-theme/
[8]: https://github.com/sorin-ionescu/prezto/tree/1f4601e44c989b90dc7314b151891fa60a101251/modules/prompt#prompt
[9]:
[10]: https://github.com/sorin-ionescu/prezto/blob/1f4601e44c989b90dc7314b151891fa60a101251/modules/git/README.md
[11]: https://github.com/sorin-ionescu/prezto/blob/1f4601e44c989b90dc7314b151891fa60a101251/modules/prompt/functions/prompt_minimal_setup
[12]: https://github.com/sorin-ionescu/prezto/blob/1f4601e44c989b90dc7314b151891fa60a101251/modules/prompt/functions/prompt_sorin_setup
[13]: https://github.com/icyflame/prezto
[14]: https://github.com/icyflame/prezto/blob/master/modules/prompt/functions/prompt_ys_setup
