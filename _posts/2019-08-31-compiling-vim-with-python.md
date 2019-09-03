---
layout: post
comments: true
title: Compiling vim with python3 support!
categories: vim
---

**TL;DR**

```sh
sudo apt-get install -y python3-distutils python3-dev
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=/usr/local \
     --enable-python3interp \
     --with-python3-config-dir=/usr/lib/python3.6/config-*
make
sudo make install
```

## The Longer Version

**Note:** I put the commands at the top of the post because I hate it when
people start with the story and the `TL;DR` comes at the end of the blog post. I
_strongly_ believe that the `TL;DR` of all blog posts and long text-filled posts
should be at the top of the piece.

<!--more-->

I started compiling `vim` from source a few months ago. See, I needed to get an
extension called [vim-search-me][1]. This extension was calling a function
called `trim()` but only newer versions of vim had this function. I opened a
[PR][2] on the original repository to ensure that the call wasn't made if the
function didn't exist, but I also wanted a version of vim which actually had
this function so I could use the extension.

Digging into the `vim` issues, pull requests and source code a little bit, I
realized that the function was introduced in [a recent commit][3]. I wanted to
build a version of vim which was newer or equal to this and would allow me to
actually use this function.

Surprisingly, the first time around, building `vim` was extremely easy. I
downloaded the source code using `git clone`, switched to the appropriate
release tag, configured the build with a prefix of `/usr/local` (`./configure
--prefix=/usr/local`), `make` and `sudo make install`! Voila, I had a custom
built version of vim! The part I probably "dig"-ed the most was that the `vim
--version` output actualy printed the name of the computer and the date/time
when I compiled it! This was pretty interesting and I realized that now I could
get patches that were made on the original vim code base whenever I wanted.
There was no need to depend on the `vim` that comes packaged inside the
`apt-get` repositories or inside `macOS`.

### Requiring Python support

At work, I write a lot of Go code and almost all the code has to have tests.
The code coverage threshold is around 80%. So, adding any new function
immediately necessitates the addition of a test for that function. Now, there's
a way that tests are written for Go functions and I was beginning to realize
which pattern I liked and it turns out I was re-writing a lot of the templating
code to set-up the test, every single time I started writing a new test.

[UltiSnips][4] is a vim extension that lets you store Language specific snippets
which can be inserted into a file when the filetype matches the snippet you have
stored. I heard good things about the extension from my co-workers and found it
in some of their dotfiles repositories! I installed the extesnion and tried to
start `vim` and it said that it needed `python` support! I hadn't compiled `vim`
with python support, so I had to find out how!

```sh
$ vim --version | ag "python"
+cmdline_hist      +langmap           -python            +visual
+cmdline_info      +libcall           -python3           +visualextra
```

### Finding the correct `./configure` flags

The configuration script output prints all the flags, their values, and the
output when the checks required to enable their inclusion in the build were
performed. The python related flags were `--enable-pythoninterp` and
`--enable-python3interp`. System python on both my work computer and my home
computer was python 3.6, but I didn't want to take a chance. So, I explicitly
specified python3 and ran the configuration script.

On my work computer (a Macbook Pro from last year), supplying just the
`--enable-python3interp` to my configuration script made everything work fine. I
didn't actually realize that something else might be necessary because it worked
fine. `make` and `sudo make install` and I had Python support in vim!

On my home computer (a Thinkpad) with Ubuntu 18.04, things were slightly more
involved.

The first error I saw with just the `--enable-python3interp` flag was the
configuration script's inability to `import distutils.sysconfig` inside Python3.
A couple StackOverflow answers later I realized that the `python3-distutils`
package installed that python3 module.

```sh
$ dpkg -l | ag "python3-distutils"
$ sudo apt-get install -y python3-distutils
$ python -c "import distutils.sysconfig"
```

This error being fixed now, I ran into my second error. This was a slightly
weirder one. It said that it couldn't find the configuration directory for my
Python installation. [This][5] StackOverflow answer pointed me to a
configuration script flag which allowed me to explicitly specify the path to my
Python configuration directory.

The third error I ran into was stranger:

> Unable to find the Python.h file inside the python configuration directory 

And it was showing an `#include <Python.h>` line from some file containing C
code. The above answer also had a line about having to install the `python2-dev`
package using `apt-get` because it isn't pre-packaged inside the Ubuntu
installation.

> On Ubuntu 10.04 you have to install 'python2.6-dev'

So, I installed the `python3-dev` package.

```sh
$ dpkg -l | ag "python3-dev"
$ sudo apt-get install -y python3-dev
```

After this, the `configure` command worked and succeeded! The python related
lines were succinct, and didn't _really_ indicate success. But they didn't
indicate failure either. So, I ran `make`. `make` creates the binary inside the
`vim/src` folder. Running the binary from there will immediately tell you if the
feature is installed or not.

```sh
$ ./src/vim --version | ag "python"
+cmdline_hist      +langmap           -python            +visual
+cmdline_info      +libcall           +python3           +visualextra
```

I had built `vim` with `python3` support! Now, the lines at the top of `vim
--version` which tell you when `vim` was last built and who built it:

```sh
$ vim --version | head -n4
VIM - Vi IMproved 8.1 (2018 May 18, compiled Aug 31 2019 11:32:55)
Included patches: 1-1949
Compiled by siddharth@home-thinkpad
Huge version without GUI.  Features included (+) or not (-):
```

[1]: https://github.com/voldikss/vim-search-me
[2]: https://github.com/voldikss/vim-search-me/pull/8
[3]: https://github.com/vim/vim/commit/295ac5ab5e840af6051bed5ec9d9acc3c73445de
[4]: https://github.com/sirver/UltiSnips
[5]: https://stackoverflow.com/a/5293524
