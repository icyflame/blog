---
layout: post
comments: true
title: Building and running GnuCash in Docker
categories: gnucash accounting docker linux build
---

## Introduction

I have written about [GnuCash][1] a few times before. I have been using GnuCash version 2.6 for
nearly 2 years now. A lot of the features that were added after this version weren't really useful
for my use-case, so I never upgraded. Also, the binary that is distributed through the Ubuntu App
store / apt-get repositories is v2.6. Versions after that were not published to the aptitude
repositories, for some reason. (A lot of software packages do this)

Recently, I ran into a very strange [bug][2]. I wanted to report this bug to the GnuCash team and
get their feedback on if this was something that they had seen before. To avoid reporting a bug on
an old version which was no longer being supported actively, I got the latest version of the GnuCash
code and started a long, uphill battle to build it locally! This post is a summary of that
experience.

For those who are looking to run the latest version of GnuCash inside Docker, you can get this
[Dockerfile][3] and build the Docker image. The command to run it on an Ubuntu 18.04 LTS host is
given at the top of the Dockerfile.

<!--more-->

## Tools

GnuCash has some documentation about building on Linux. It starts with [this page][4] called
`Building On Linux`. Going from this page, I kept jumping to several subsequent pages which felt
strange and I was soon confused about what I was looking for in the first place.

This is the short summary of what I learnt:

1. GnuCash is written in C
2. Building the software has two distinct steps:
 1. Configuring the build: For this, we use Cmake
 2. Build (for real): For this, we use Make
3. The build directory must be completely separate from the source directory

	```sh
	$ tree -n -A -L 1
	.
	├── gnucash-4.1
	├── gnucash-build
	```

	This is the structure that I used. We will be running all of the commands inside the build
    directory. In this example, `gnucash-build/`

## Required packages

It took me quite some time to figure out exactly where all the files should go and what came first,
etc. Once I had figured out the purposes of Cmake and Make, things got a little bit easier.

I started with this command:

``` shell
(gnucash-build) $ cmake ../gnucash-4.1
```

This command will most probably fail, unless you have all the dependencies installed. If this
command does not fail, then you can switch to the next step: `Build`.

For me, this command failed several times. Each time it failed, it output either an error with the
name of a package that was missing or a warning with a particular part of GnuCash that it couldn't
configure properly because of missing dependencies.

### Warnings

I had to remove two parts of GnuCash to get past the warnings: [AQBanking][5] and SQL support. After
seeing the warnings, I wasn't quite sure how to disable them. A quick look at the `CMakeLists.txt`
file helped me figure that out. I don't know how to read CMake files, so I just winged this part. I
found a few mentions to the actual option and found these lines:

``` shell
option (WITH_SQL "Build this project with SQL (libdbi) support" ON)
option (WITH_AQBANKING "Build this project with aqbanking (online banking) support" ON)
```

After finding this option, I discovered that cmake takes configuration options using `-D`

``` shell
-D <var>[:<type>]=<value>    = Create a cmake cache entry.
```

`-D`'s description is confusing, but it's the option we want to use.

With this, I reached the command:

``` shell
(gnucash-build) $ cmake -DWITH_AQBANKING=false -DWITH_SQL=false ../gnucash-4.1
```

Running this on my Ubuntu 18.04 installation gave me an error mentioning the name of a missing
library. I went ahead and installed the library and ran `cmake` again. I repeated this step several
times.

### Errors

Cmake configures the build by ensuring that each library that is required is available on the host
and is in a location that can be found by Make (or it will tell Make to find it wherever Cmake found
the library). As I saw each warning, the name of the library I needed to install was either clear to
me from the error or I had to run a search on [packages.ubuntu.com][6].

I had 22 required packages missing. The complete list of packages can be found in the final
Dockerfile's `apt-get install` command [here][7]. This step took the most time at about 90
minutes. After 4-5 steps, the process was pretty clear to me. A couple of things that I learnt
during this process:

1. For building software, almost always the `-dev` versions of packages are required. For example, I
   had the package `libxslt1.1` installed. This wasn't enough though. Cmake kept telling me that the
   `xsltproc` could not be found. This was because I didn't have `libxslt1-dev` package. After
   installing the `-dev` version of this package, I was able to go to the next missing package.
2. You can check what packages are already installed using `dpkg -l`. Using a tool like `grep`
   allows you to quickly check whether a package is missing or if there's some sort of version
   conflict: `dpkg -l | grep xslt`
3. For most packages, I was able to install them fairly easily. For 2 packages (`libglib2.0-dev` and
   `libxslt`), I was not able to install the required package for a few minutes. After moving around
   searches, installing and removing packages, checking `dpkg -l` output, and reading the error
   message several times, I was able to install the required package.

## Build

The actual build part of this process is extremely easy. Cmake ensures that everything that was
required has been installed and can be found in their usual locations. If not, Cmake will tell make
where to find them using the Makefiles that cmake generates when the configuration process is
complete.

``` shell
(gnucash-build) $ make
```

This command will run for a considerable amount of time. On my laptop with an i7 8th gen processor
and 16 GB of RAM, `make` ran for about 20-30 minutes (I didn't track this closely; I was relieved to
have reached this stage and I didn't really care even if this command took a few hours as I was
probably not going to run this command again EVER)

When `make` is done, your `gnucash` binary should be inside `gnucash-build/bin`. There will be some
more binary files.

``` shell
(gnucash-build) $ ls bin
gnc-fq-check  gnc-fq-helper  gnucash      gnucash-valgrind
gnc-fq-dump   gnc-fq-update  gnucash-cli  jenny

(gnucash-build) $ ./bin/gnucash --version
GnuCash 4.1
Build ID: 4.1+(2020-07-25)
```
## Conclusion

I have built most of the small utilities that I use on a daily basis (like my recent favorite,
[git-fzf][8]). GnuCash was one of the major parts of my computer usage and I am glad that I can
actually build the software which is able to parse the huge `.xml.gz` file which contains all my
accounting information!

[1]: https://blog.siddharthkannan.in/tag/#gnucash
[2]: https://bugs.gnucash.org/show_bug.cgi?id=797926
[3]: https://github.com/icyflame/dockerfiles/blob/master/gnucash/Dockerfile#L1-L9

[4]: https://wiki.gnucash.org/wiki/Building_On_Linux#Setting_up_to_Build_GnuCash_on_Linux

[5]: https://wiki.gnucash.org/wiki/AqBanking

[6]: https://packages.ubuntu.com

[7]: https://github.com/icyflame/dockerfiles/blob/53820e4377779bd4c5364b864a760828484db3cd/gnucash/Dockerfile#L16-L38

[8]: https://github.com/at-ishikawa/git-fzf
