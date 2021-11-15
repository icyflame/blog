---
layout: post
comments: true
title: Samsung SM-B313E/D - Flashing software and getting out of a fix
categories: phones samsung software experience
---

It all started with this tweet:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">I forgot
my Samsung B313 lock password. I am still in disbelief. 😥😥 getting thehone
to work again is going to be a PITA. 😢 <a
href="https://t.co/o8IwxnQdDA">pic.twitter.com/o8IwxnQdDA</a></p>&mdash;
Siddharth Kannan (@_icyflame) <a
href="https://twitter.com/_icyflame/status/910770407925415936">September 21,
2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

That's a Samsung SM-B313E/D. I forgot the password and it was actually really
disturbing because I couldn't depend on myself to remember the several other
passwords when I forgot a 4-digit password for an old phone.

That aside, I needed a way to fix this. There are _several_ tutorials to do this
on the Internet. A selection:

[Tutorial 1](https://www.youtube.com/watch?v=6ty7NtFmreo)

[Tutorial 2](https://www.youtube.com/watch?v=ZKGAi67MVMg)

[Tutorial 3](https://www.youtube.com/watch?v=pZelWOJTa6M)

[Tutorial 4](https://www.youtube.com/watch?v=aX50jYZXJwc)

There was something peculiar about each of these ones. The phone that I am
talking about is a really cheap phone (~ Rs. 2000 or USD 40) and thus there were
no "high quality" tutorials for this, as one might expect for a smart phone like
the Sony Xperia L or a Nexus.

All the tutorials showed more or less the same tutorial, but I was still not
completely sure that I would be able to recover my phone using the tutorial.
Also, being pretty paranoid myself, I saw no reason why they would not just ask
you to run some EXE file on your Windows computer with administrator privileges
and hide a virus inside that.

I decided to take the plunge, mainly because I had run out of options. Samsung
Service Centers are not the best places to go to in the world if you want quick
resolution.

The process was simple.

1. Install the Spreadtrum Driver Package
2. Download a `.pac` file which has the software packet for this phone
3. Use a software to flash this PAC file onto the phone (I found an
   [XDA](https://forum.xda-developers.com/showthread.php?t=2624918) thread about
   this)

The verdict is that I was able to get the phone working once again! It works
fine now, and there was really nothing off about the tutorial. I used Tutorial
number 4 from the videos listed above. But for some reason the ResearchDownload
tool linked in that video didn't work for me. So I went to [their
website](http://spdflashtool.com/) and downloaded the latest one.

Another weird thing was that the PAC File that I recieved said that the software
was for `SC6530_SAMSUNG: b310e`, but it worked for B313E/D. This was one thing
that I was most fearful about: that the wrong software would fry the phone. It
didn't! I guess the software packages are close enough replicas of each other to
not make much of a difference.

There's certainly a difference in the software packages. In the earlier software
that was there on the phone, I could select multiple message and mark them as
read. Now I can't, I can only delete them. So, the software has definitely
changed.

This was a success story. My heart _was_ racing when the SPD Flash Tool was
doing it's thing, but it worked out fine!

Some notes:

1. Tutorial 4 from above
2. SPD Flash Tool's website: http://spdflashtool.com/ (I think this is the
   official one, but I can't really  be sure. There are several mirrors of this
   software out there)
3. The PAC file and the drivers from Tutorial 4 above worked for me.

I used a Windows 8 computer.

I realized that I should probably put a disclaimer here, just to be safe.

_Note:_ A typical disclaimer. I am copying text from the [MIT
License](https://opensource.org/licenses/MIT) that absolves me of any
responsibility in case of loss incurred from doing something that I state worked
for me above.

```
THE TUTORIAL IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE TUTORIAL OR THE USE OR OTHER DEALINGS IN THE TUTORIAL.
```
