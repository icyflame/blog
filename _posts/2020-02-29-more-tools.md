---
layout: post
comments: true
title: More tools!
categories: tools bash vim vim-plugin perl
---

Here's a list of some of the repositories I created on Github recently:

**Vim plugins**                  |
MarkdownLinks.vim                | 2020-02-02T03:54:14Z
PersistentScratch.vim            | 2020-01-02T09:56:07Z
**Scripts in bash / perl / etc** |
gospec                           | 2020-01-25T12:08:24Z
json-where                       | 2019-09-23T07:45:08Z
gnucash-xml-to-ledger-dat        | 2020-02-11T11:35:33Z
launchdarkly-prereq-graph-gen    | 2019-06-01T08:02:52Z
**Firefox add-ons**              |
wealias-firefox-add-on           | 2019-02-05T13:49:12Z
open-circleci-workflows-firefox  | 2019-08-24T07:13:19Z
**Misc**                         |
stern                            | 2019-03-21T14:47:12Z

I realized that I have been building a lot of tools lately. In particular, I
have gotten into writing Vim plugins and forking and editing the tools I use
often so that they have the options I want, but will probably never be merged
into the tool's repository itself.

<!--more-->

I generated this list by making a request to the Github API:

```sh
$ curl -s -G --data-urlencode "sort=newest" \
        "https://api.github.com/users/icyflame/repos" |\
        jq -r '.[] | [ .name, .created_at ] | @tsv' |\
        tsv-pretty
```

If you have been working on a lot of open source stuff lately, but can't figure
out what exactly it is you spend most of your time doing, I definitely recommend
looking through Github's API!

## Vim Plugins

I have been a Vim user for a few years now and I have written extensively about
it! The one thing I hadn't done before was write plugins. So, I started looking
into writing a plugin with the specific goal of writing a plugin that would
store the currently open buffer in a file somewhere on my file-system. Where the
file was stored wasn't really important, it didn't even matter what the name of
the file was, all the mattered was that it was on my persistent storage
somewhere. If I knew that the file was stored, it would allow me to get text
(like deployment pipelines), store them on my file-system and go ahead and edit
them directly without having to think about where I should store it or what I
should name them.

It turns out that Vim's plugin API is extremely easy to use. There are two
particular things about it that I like a lot:

1. **Standardized file-structure**

```sh
$ tree --charset ascii
.
|-- autoload
|   `-- persistent_scratch.vim
|-- LICENSE
|-- plugin
|   `-- persistent_scratch.vim
`-- README.md

2 directories, 4 files
```

Most Vim plugins are _very_ similar:

- An `autoload/plugin.vim` file with all the keybindings and calls out to the
  functions which implement the plugin's functionality
- A `plugin/plugin.vim` file with the plugin's functionality and some exposed
  functions which can be called by the keybindings / commands defined in the
  autoload file

This simple file structure makes it very simple to write a new plugin by looking
at an existing plugin and trying to do the same things but for your use-case. My
plugin reference was [mtth/scratch.vim][1]. My plugin was very similar to that
plugin except for the part where the file is being stored on persistent storage.


2. **Easy to test**

VimScript is an interpreted language (I think?) and one can test plugins by
simply symlinking the plugin's development directory to a directory inside
`~/.vim/bundle`. After doing that, you only have to open Vim and start testing
your commands / keybindings.

---

After PersistentScratch, I migrated MarkdownLinks out from my Vimrc out to it's
own plugin. MarkdownLinks is a plugin which adds a hyperlink to the word that
your cursor is on or the highlighted text and adds the template `[` around the
word and the declaration of the link at the end of the file. I was surprised
that something like this doesn't already exist. I wonder how other Markdown
writers deal with this.

**Note:** I actually started using Neovim instead of Vim recently. More on this
in another blog post. _Hint:_ The reasons were mostly because of my
disillusionment with the [BDFL][2] model of governance in open source projects.


## Bash functions + Utilities

json-where is something that I have been working on for a while now. It has been
extremely useful to me whenever I am reading Kubernetes manifests. (Kubernetes
manifests are notorious for containing extremely nested keys with vital
information) It tells you the key given a location inside a JSON buffer. This
works perfectly from inside Vim, where you can simply run a keybinding and get
the path to the key your cursor is on.

gospec is the other thing that I have recently spent some time on. It's a
prettifier for the output produced by the `go test` command. I have been using
it daily at work and it has reduced the time I spend using cumbersome tools
(like `ag` + `sort -r`) when debugging tests for new code. It doesn't do
anything very complicated and the function itself fits within 100 lines of bash.


## Misc

I have been writing some Perl recently. Perl is a surprising language as it has
been around for a long time and it has remained mostly unchanged. The text
handling capacities of bash are limited, and I use Gawk whenever I have to
change streams of text, but sometimes even Gawk is not upto the task, especially
when JSON is in the mix. One recent example was when I wanted to list all the
Kubernetes pods and output the namespaces which had a particular environment
variable set to a given value. I ended up writing a NodeJS script for this, but
I definitely wished for something faster in the moment and I have been wondering
if Perl could have been that language.

Perl's is able to deal with HTTP requests, XML (some APIs are still XML), and
JSON effortlessly. I want to start including it more in my daily scripting
tasks. Something that I started using just yesterday:

```sh
echo -n "https://vendor.com" | perl -MURI::Escape -e "print uri_escape(<>)"
```

The 2 times I had to URL escape some text, I loaded up JSBin.com and entered
it into the console. It took me a couple minutes to find the JS function which
escapes text. So, yeah, this approach is _way_ faster.

[1]: https://github.com/mtth/scratch.vim
[2]: https://en.wikipedia.org/wiki/Benevolent_dictator_for_life
