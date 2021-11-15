---
layout: post
title: CLI Apps and NodeJS, Made for each other?
comments: true
categories: programming
---

After starting to follow [@sindresorhus](https://github.com/sindresorhus) and [@kevva](http://github.com/kevva), the one thing that started filling my GitHub timeline, were repositories like [is-online], [wifi-password], [is-video], etc. These were NodeJS repositories that did something really simple, like checking if the computer was online, confirming if the file that the path points to is a video or not. 

The one other thing that was interesting was that these ran from a NodeJS script as well as the CLI. It seemded like one of the easiest method to package a CLI application. And thus, started a journey across @sindresorhus and @kevva's code. Finding the place where this code exactly was took more time than I thought. Checking through the `package.json` file, I found the slightly suspicious `bin` declartion, in the `pkg` object.

Slight googling about this led me to the `package.json` manifest, it explained a lot of other options there, which I was not using, such as the `repository`, `author` and it's subfields. I filled in all these fields in the `package.json`, and published to NPM again.

Surprisingly, I didn't feel the need to talk about that, because it was simple, like really really simple. It was almost as easy as `git push`. 

Edit the package.json file, and push the package to NPM. The package is now hosted on [NPM](https://www.npmjs.com/package/cli-cube-timer). The package itself is a Rubik's Cube timer, on the Command Line thing. Time all your solves right from the command line. It has a surprising amount of downloads, If I say so myself!

The one other thing that I have always wanted from a Rubik's Cube timer, is that it store my times forever, without any unreliability. And I believe that this module, when completed, will be able to do just that!

The module is open source, and is licensed under MIT.
