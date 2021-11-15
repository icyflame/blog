---
layout: post
comments: true
title: Why I include Bootstrap in every project
categories: bootstrap frontend html
---

Here's some unsolicited advice: **Always start any project with the inclusion of
Bootstrap**. There are a few reasons I insist on this. I will go into them in
this blog post. There are [many][1] [such][2] [blog posts][3] on the Interweb. I
figured that adding my own point of view on this matter will not hurt anyone.

### Before we begin

I had a really hard time understanding what Bootstrap really was. I had some
questions in mind: Is it a library? Is it a set of CSS classes? Is it jQuery,
but better? Why is jQuery required if it is only a set of CSS classes? I have
figured out a very simple way to explain what Bootstrap is:

```
Bootstrap is a set of 2 components. 

Bootstrap CSS is a set of CSS classes that
can be used in any application. It does some great things by default (like using
a good font, using margins and paddings on the `body` tag). It has 2 major
features which are worth using in any app that aims for a simplistic polished
look: the grid system and the classes that make forms render better

Bootstrap JS is a library built on top of jQuery that provides some more
functionality. 2 of the best features of Bootstrap JS are: tooltips and
modals.
```

One more thing. Bootstrap has really [good documentation][4]. The documentation
is really really good. It was good already. And then they added the search
feature with Bootstrap v4's release. It became GREAT.

### Reasons

These are in decreasing order of significance, as I have experienced in my
frontend development.

1. Bootstrap makes your website responsive. i.e. your app will look better on
   every screen no matter it's size and shape. Of course, you should use it
   properly. But it is extremely hard to use bootstrap badly enough that it will
   look bad somehow.

1. Bootstrap's Grid System. This is one of the most useful things that I have
   EVER learnt in frontend development. Every line of HTML I write now is
   written in the context of `col-md-*`s and so on. Learn this grid system and
   you will forever lose your fear of center aligning text in HTML.

1. Bootstrap makes your site look better. The new font, the sane defaults for
   margins around various elements. These things have become standards across
   the web and including a CSS library which will take care of this is a huge
   load off your shoulder.

1. Bootstrap makes your forms easier to understand and fill. The rounded
   corners, the highlighting when a particular text field is selected, the
   amazing UI bump that it gives to `select` lists. All of these things can't be
   done with custom CSS. **Stand on the shoulders of giants**

1. Bootstrap's `table`s will finally make tables better on the web. 3 classes
   that I always use with a table are the default `table`, `table-hover` and
   `table-striped`. These three classes make the table resemble an Excel sheet
   to some extent and actually make the app easier to comprehend. Tables are a
   very powerful way to show information, perhaps second only to bar charts.
   Bootstrap makes it easier for developers to make more legible tables for
   their users.

1. Bootstrap's buttons convey information. Almost everything in Bootstrap comes
   in a set of colors, depending on the "alert" level. This color is extremely
   useful when developing dashboard type applications. It's also pretty useful
   when developing normal applications that tend to have destructive actions
   (like deleting your account or deleting a cutout). I used this in a former
   intern where I was upgrading a dashboard application written using an Angular
   library and the buttons were so small that it was only the colors that any
   user even looked at. That's how helpful this is!

1. Bootstrap makes your `blockquote` look better. Blockquote tags are again
   great ways to convey information especially when writing blog posts or some
   sort of a reference. Goodreads doesn't use bootstrap and their blockqotes
   look really bad. Blockquotes look like text that has been indented, instead
   of looking like quoted text.

1. **Bonus** Bootstrap gives you the ability to add a navbar quickly. The
   Bootstrap navbar is extremely toned down. I don't like it in all settings,
   but for some apps where you can't do away with the navbar, Bootstrap is the
   way to go. The navbar has a set of options that enable you to do anything
   with it: stick it to the bottom of the page, show only one option on mobile
   screens, anything you want really.

1. **Bonus** Bootstrap Modals! I mean, this is something everyone loves. I don't
   like modals because they are very hard to use on mobile and I tend to stay
   away from them as much as I can. I would rather enable the user to scroll
   through the page rather than have to struggle to get to the small X button at
   the top of a modal. But if you are developing an application that's used only
   on desktop computers (like a Sales Dashboard), modals are extremely powerful
   tools to retain context and let the user edit information at the same time.

[1]: https://www.bootstrapbay.com/blog/reasons-to-use-bootstrap/
[2]: https://www.devsaran.com/blog/10-best-reasons-use-bootstrap-amazing-web-designs
[3]: https://www.sitepoint.com/11-reasons-to-use-twitter-bootstrap/
[4]: https://getbootstrap.com/docs/4.1/getting-started/introduction
