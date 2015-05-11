---
layout: post
title: Falling in love with GruntJS
comments: true
categories: web-development
---

So, after that marathon of two posts on the same day (which had a slight issue in formatting the first time I published it), this is my post about GruntJS, again!

I posted about GruntJS once [before](http://icyflame.github.io/blog/web-development/2015/03/30/grunt-js-is-awesome/). That was the basic configuration that I had got going on the first time around. It didn't do much. Just the basic plugins: prettifying the HTML, minifying the CSS and JavaScript and the Watch plugin, for automatic plugins.

Soon after that, I realised that my builds were just taking too long, which was when a little bit of research led me to [this article](http://www.html5rocks.com/en/tutorials/tooling/supercharging-your-gruntfile/). That article was awesome!

Reading the article, I was convinced that I just had to use the plugins mentioned here. I ended up using: 

- load grunt tasks
- grunt concurrent
- time-grunt
- grunt newer

So, these plugins were just the tip of the iceberg, but they reduced the buildtimes that I currently had (about 30 seconds per build) to a mere 10 seconds for slight changes in the HTML files. 10 seconds still feels a lot longer when sitting in front of a i5 4th Generation machine, but nonetheless, it works well with my workflow. In the time that it takes for either Grunt to run the tasks or for Git to push everything to the cloud, I can easily check my work emails, and Slack for any new messages, and revert back to them, if they need my attention. (It also works well, when I don't really like the song that's playing and want to change it!)

So, let's go through these plugins one-by-one.

1. load grunt tasks

This plugin loads all the plugins directly from the `package.json` file, this ensures that I don't have to write the `loadNpmTasks` line in the GruntFile. (with more than 10 lines, that part of the file is really just a waste of SLOC). I integrated this plugin pretty fast, and it worked pretty well too, but as I already had the Gruntfile with the `loadNpmTasks` file, there was no significant change in the build time. Starting a new project, of course, this plugin will affect stuff a lot more.

2. grunt concurrent

This is the one plugin that improved built times a helluva lot. Using this plugin, you can basically run the tasks that are independent of each other concurrently. The prettifying, and the minification step of all the HTML, CSS, JS files are independent of each other and thus, these three can be done concurrently. The minification step is dependent on the concatenation of the files, and this meant that I had to run the concat step in the first cycle, and the minification in the second cycle. This cut my build time by a good 3-4 seconds.

3. time-grunt

This is a frontend plugin that is helping me make all the above comments about the time that the complete build and each part of the build takes. This was the first plugin that I included in the project, so I could see the improvement in the build-times. It puts out a good picture that the time that every part of a task took. The output looks something like this:

![Imgur](http://i.imgur.com/wTA6efq.png)

4. grunt newer

Once the above plugins are included in the project, the build time does improve, but even then, the above plugins run the same task again and again. For even a slight change (like a change in the background color), the whole build runs again. And this is a colossal waste of time. And this plugin takes care of that. It runs only the tasks that correspond to files that have been changed. With this, for slight changes like, adding an image tag, in one HTML file, I can get build times that are as low as 7 seconds.

So, the above list of plugins is probably the list of plugins that I will be using in every frontend project that I take on from here on out. 

Apart from this, there's this other integration that can be done in Sublime Text: Creating a build system!

I created a build system for Grunt, and that was super easy. (Create build system -> enter the command as `grunt` and you are done!)

So, now, I don't have to leave my editor to run the build. This works great when making small changes, you can build the project from there and switch to the browser (which I love keeping in another workspace), and check the output, and if that works well, commit and push the changes!


