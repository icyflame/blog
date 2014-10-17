---
layout: post
comments: true
title: (Ruby) Gems are powerful!
categories: web-development rails
---

So, after my last post, I came back to campus, this Monday! And once I came back to the campus, I was behind a proxy again. This ensures that there is no easy way (as for now, I don't know any way at all) to SSH with servers outside. So, Git SSH, Heroku SSH everything's gone!

So, I am pretty convinced that I made the most of my 6 days at home, where there were no proxies, just pure internet access!

At home, I had also, configured three basic Ruby Gems, which I am determined to use in all my successive projects and one Gem which was a failure.

So, starting with the three that worked perfectly well, they were [Bootstrap SASS](https://github.com/twbs/bootstrap-sass#bootstrap-for-sass---), [Devise](https://github.com/plataformatec/devise) and [ActiveAdmin](http://activeadmin.info/).

Bootstrap SASS is simply the SASS port for Bootstrap, and since bootstrap is the way to go (<3 @mdo), for all things front end, It has to be there. Although, SASS rails is included by default in the Gemfile of a new Ruby app when you create it, I would also like these three to be added and the first run of the bundle install to take place as soon as I create the app. I am trying to automate this process, by a simple Bash script which will append the three required lines to the Gemfile, and then run `bundle install` and then do some other configuration stuff. I am documenting all the steps in creating a new RoR app, in this [Gist](https://gist.github.com/icyflame/29c4a04515e8f9063bb7).

The second gem does stuff that just any real world project can't do without. **Devise : Authentication** First and foremost, I just wanna say this, Devise has one of the best README's ever written. The README is great, for the beginner in Devise, and also, for a beginner of Rails. It is amazingly well written, and contains almost everything that one requires right when one starts to use Devise. How to create new devise models, how to integrate devise with old ones. Probably the one thing that I would really love to see on the devise README is how to permit extra parameters in a Devise Sign Up. This is probably one of the very few things that I had to google and could not get on their README, when I first started using Devise. I will of course, be adding this piece of Information to my own Gist, as I believe that if someone is being authenticated, then there is a lot of metadata, except just the email and the password that I would probably wanna store in the database.

And the third and final Gem which was the one Gem which I didn't get right the first time was ActiveAdmin. I started using RailsAdmin, and that was a huge mistake, because for some reason, RailsAdmin does not show all the fields that are there in a particular table. It almost always ignores the Password field, and sometimes, some other fields like email ID's etc. It was one of the Gems that was shown right at the top of the [Ruby Toolbox Page for Administration](https://www.ruby-toolbox.com/categories/rails_admin_interfaces). Which was probably the reason I picked it out, but it didn't work out well.

Enter, ActiveAdmin. And yeah, I knew I had found the one I wanted to use! ActiveAdmin was clean, and it was actually perfect. Just a couple of hours ago, I ran into a brickwall, trying to create a record using ActiveAdmin's create interface, but then, I have not read the complete documentation. I am pretty sure I saw how to do this, and I will be catching up on it soon. One of the peculiar things that happenned after I installed ActiveAdmin was that it's CSS and JS was being included everywhere. This was a stupid mistake. The `require_tree` in both the application.css and the application.js files, was placed in the last lines of the comments, and just when I was beginning to wonder what they did, I found out. (Thanks to [stack overflow](http://stackoverflow.com/a/10321125/2080089) of course.)

So, having found the power of Ruby Gems, I am totally addicted (in some sense of the word!) to Ruby on Rails!

Psst psst, The [getting started with RoR](http://guides.rubyonrails.org/getting_started.html) guide is amazing. It's the best place to start. Have I mentioned that in one of my initial posts already? :D