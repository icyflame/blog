---
layout: post
title: Using Git Flow, and why it cleans up history, A LOT!
comments: true
categories: programming git
---

I am a lover of projects with clean history. They always end up being some of the best maintained and working projects. I guess I must refer to the big Dad of all Open Source repositories, Linux when I refer to this. Looking at the history in it's [GitHub Repo](https://github.com/torvalds/linux), it's full of merge commits that make sense. You can see the changes going up the ladder, and Linus Torvalds accepting them.

Git Flow does essentially that. Git has a lot of options that you can take, as a maintainer, you are just confused and you let the history decay. Git Flow ensures you don't.

The basic _funda_ behind Git Flow is that there are two branches, `develop` and `master` that are always part of a project. `develop` is the branch where all the development takes place, and gets tested in a staging environment. `master` is the branch where the latest production ready version of an application resides.

So, you branch out from `develop`, and add a feature. Once this feature is over, you can either add more features, all of which will stay on `develop`, or you can start a `release`. This branch will allow you to make some last minutes changes (bump version number in JSON files, change API keys to Environment variables, basically, remove everything that was added because you were prototyping a feature, and not building it for production.) After this, you finish the `release`, which is a major step in Git Flow, because it does a whole lot of things. It merges the release branch into master, and creates a new commit, whose message you are allowed to edit. (You can close all GitHub issues through this message). After this, it then creates a tag at the latest commit on master, you are in control of the tag message. (the name of the tag is the name of the release. There are options to not create a tag, just in case you gave a meaningful name, instead of semantic version.) And finally, the last step of the process is back-merging this tag into `develop`, to ensure that `master` and `develop` stay on the same page, immediately after a release. 

There are some other commands like `publishing` a release, which will basically push it to a server. But since, `git push` already does that, there's no reason why it should be used, if you are comfortable with `git push`!

The thing that I like the most about Git Flow is that it can be used independently by the maintainer of a project, regardless of whether the contributors are using it or not. You can simply pull their changes into a new feature branch, so that you are always in control of the names of the features, and the names of the releases. Often, with toolkits such as these, the whole team needs to migrate from existing tools to this particular tool, and that is not ideal!

[This](http://danielkummer.github.io/git-flow-cheatsheet/) is the cheat sheet that gave me the confidence to get into Git Flow, almost instantaneously!