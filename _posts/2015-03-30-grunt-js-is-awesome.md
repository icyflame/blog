---
layout: post
title: Grunt JS is Awesome!
comments: true
categories: web-development
---

So, finally, after a long long time, during a particular project, I got the chance to get my hands dirty with the JavaScript Task Runner, [GruntJS](http://gruntjs.com).

Now, I have been using Sublime Text and the auto-indent function that is embedded with it for almost a year, or perhaps, more than that! But one thing that has been sub-par is definitely the quality of code that comes out of this engine. A lot of the tags are not indented properly. `head` are in the next level of indentation of `html` tags. And inside `body`, if a tag is closed in the same line, then the whole indentation breaks.

This was when I remembered reading about [HTMLHint](https://github.com/yaniswang/HTMLHint). Although, I didn't really know what it meant, and was pretty clueless of its utility, I believed that like me, a lot of developers out there would obsess about well-indented HTML code, and if that was the case, then definitely there would be a tool to achieve that! And sure as that, there was!

Enter, GruntJS. I had read up about this some time last semester, when I was writing front-end code at Alumni Cell, I had tried using but had ditched it, because it took way too long to understand, and I was facing some setup issues as well. Now, armed with a Ubuntu 14.04 LTS machine, I conquered this again, and voila, I succeeded!

The installation process was painless for the most part, I installed `nodejs`, followed by the `grunt-cli`. After this, I had the `grunt` command in my terminal. Further, I created the two required files for Grunt, `package.json`, a standard file that is present in **all** nodeJS applications, and a `Gruntfile.js` that declares the tasks that Grunt needs to run.

Basically, grunt has a whole set of plugins, that can be installed and once you change the corresponding JSON inside the Gruntfile appropriately, you have the task setup and that plugin will take care of the task itself. These plugins are installed through NPM, and are pretty easy to install.

So, the basic task was simply writing the Grunt tasks, themselves. They are slightly intimidating right when you start out. This is probably because I am not familiar with JSON. For someone familiar with JSON, this would be cakewalk!

A typical Grunt task to prettify HTML files looks like this:

```javascript
prettify: {
	options: {
		indent: 2,
		indent_char: ' ',
		wrap_line_length: 78,
		brace_style: 'expand',
		unformatted: ['a', 'sub', 'sup', 'b', 'i', 'u']
	},
	all: {
		expand: true,
		cwd: '.',
		ext: '.html',
		src: ['*.html'],
		dest: 'build/'
	},
},
```

In this task, I am simply declaring the options to be used for HTML prettifying, 2 space indents, wrap lines at 78 characters and leave the specified tags (such as `a`, `sub`, `sup` etc) unformatted. After this, under the `all` seciton, I give the target files. I am giving all the HTML files that are present in the root of the directory. (Alongside `Gruntfile.js`) and the destination is the `build/` folder, where these prettified files are stored with the `.html` extension.

The output of this task is **amazing!** The HTML is just so, clean <3

I love well-indented code, because it looks great, is a pleasure to read, and just tells everyone else how amazingly detail-oriented the author was!

If everyone write well-indented code, ... Well, that is the dream!