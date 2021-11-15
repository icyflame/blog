---
layout: post
title: Ubuntu for Devices (And then back to stock Android!)
comments: true
categories: android nexus
---

And then, I decided that my beloved Nexus 7 (2012 version, the device is called "grouper" for some mysterious reason!), had remained with stock Android for too long, and that it needed to go out there and explore the world of flashing custom ROMs, and experiencing other OSs. So, I opened up the Ubuntu for Devices installation guide.

The webpage was familiar, I had been there before a lot of times, almost always, with the intention of flashing Ubuntu onto my Tablet, but always, coming up with some excuse to not do so. This time I was determined! I had backed up everything using the `adb` command line utility from my Ubuntu 12.04 laptop, and anyway, it wasn't data loss that I was worried about. Almost all my data was either on my laptop or the cloud, the Nexus 7 was just a play device, and didn't have much of any use.

After the backup, I noted the build number, the device name and one other thing, using a script that they had given. Once that was done, I had to run the `ubuntu-device-flash` command. This I believed would take time, because it was going to flash a complete operating system onto the tablet. I had selected the `stable` channel for installation, it said that the version of Ubuntu was 13.10, and that it was "stable". And well, since all developers are very stingy about moving from bleeding edge to "stable", I was pretty sure that it was the best thing that I could get for my tablet, atleast at the first iteration. So, once the command started, it started downloading some system images to flash into the device, this took some time, about 15 minutes or so. But once this was done, within 4 minutes or so, The device had been flashed, and the myseteriously the device booted into recovery, and now it was CWM recovery. I had stock recovery in the beginning, now that recovery was gone, and CWM had come in. The recovery was in some screen, and it was saying something that I didn't get and didn't think to write down either. I simply selected the "Go Back" option that was there on the screen. Once I had selected that, the device powered down, and the screen was blank.

Now, this wasn't something I had expected, I had expected some kind of protest or an Ubuntu splash screen or something of the sort that you see when you install or startup an OS for the first time!. I powered the tablet back on. I saw the Google screen with a small Unlocked symbol at the bottom of the screen, indicating that my Bootloader had been unlocked. (This was one of the easiest steps of the process. Simply run `fastboot oem unlock` with root privileges, and boom, The bootloader was unlocked. This is sunlike the bootloader unlocking procedure of all the other non-Nexus phones and tablets, which have a long and tiring process!) After this google splash screen, I got my first look at Ubuntu. The lock screen. The circular slide-type thing, which I couldn't really figure out what it did. And when I swyped from the right edge, I saw the home screen.

The first look was pretty plain. There wasn't much on the screen, the icons were not sharp, they were slightly blurred, and I don't know why. The device didn't pester me for my name and Account credentials, the OS simply started. But one thing that I noticed was that the animations, and the transisitons and almost everything was slow. They never hung up, but they were just slow.

And just when I was thinking that maybe I had cracked Ubuntu, without breaking anything, I swyped in from the left edge to go back home, and boom! The screen started flickering, this reminded me of my days playing with the desktop computer back home, which also used to flicker whenever I loaded Ubuntu on it. So, once this was here, just I had expected, the device didn't respond, so again, I switched it off and back on again. Now, I wanted to try the browser, so I switched on Wifi on it. I tried a lot to connect to a network, but I never could get it working. The Gmail app was installed, but I couldn't use it.

Almost an hour after I had installed Ubuntu, I decided that it wasn't worth it, probably because I had installed 13.10, or maybe just because I had installed Ubuntu on the tablet! ( **Note** The image that I used was for the Nexus 7 (2013) version, which has a faster processor, but nothing significantly different anywhere else, and generally, it is just found that stuff that works on 2013 works on 2012 too!)

Now, I wanted to move back to Android. But, while I was at it, I decided, that probably I should give Android L (named "Lollipop") a try. So, I downloaded the archive for Lollipop and followed all the instructions at that preview installation page, and found that I was getting an error, again and again. It was saying `system.img not found`, when actually, it was present. I didn't know how to fix it, and I decided to sleep on it.)

Day 2!

Once again, I was at the terminal, the tablet was in fastboot and the android BOT was lying on it's back, with it's stomach open! I tried it again, and then, searched the internet for answers, I got a couple of them, but none which solved the problem. So, I left it. I decided to just load KitKat and either wait for the official Lollipop release or flash it once it's images were up on the [factory images](https://developers.google.com/android/nexus/images) page. meanwhile, I was slightly worried because the tablet was not starting up anymore. It was in fastboot and then just kept going off and coming back on, never going into either Ubuntu or Android.

So, seeing all this, I was pretty worried that, as one poster put it aptly on an XDA forum, "Royally screwed up my Nexus 7". But I still had hope, and I believed that things would get solved, once I flashed the stock android back on.

So, Now again I went to the factory images page, and downloaded the factory reset image for my device "nakasi". And again, ran the flash-all.sh script present inside the extracted directory, and the process started.

In the beginning it erased all the partitions, and then it wrote the boot, recovery, system, and userdata partition.

This userdata partition went on to create trouble, As the terminal was stuck at `sending userdata (137563 KB)`. It was taking too much time, and I was sure that it had hung up, so I disconnected the device, and started it.

Much to my delight, the google splash screen was followed by the four dots of Nexus whirling and coalescing. I was pretty sure that the tablet would start up now, but then, I met a screen that asked me to enter a password to decrypt the userdata. This was unexpected because I hadn't ever entered any password, and now I didn't know what to write there. I tried a couple of passwords, but nothing seemed to work. And then I saw [this](http://forums.androidcentral.com/google-nexus-7-tablet-2012/289286-nexus-7-type-password-decrypt-storage.html), a hilarious discussion about whether or not the OP had a stolen Nexus 7 or not! People had come to the screen I had just because their tablet had incidentally switched off, so I was happy that I could atleast say that I was tweaking with it when I ended up at that screen!

This didn't give me the answer, but I was sure that doing it again would be beneficial, so I started it off again and then waited. When I came back to the `sending userdata` step, as before, the screen freezed.

Now, I found [this](http://askubuntu.com/questions/272542/stuck-on-sending-userdata-137526-kb), which indirectly told me to swtich off the device while it was connected to the computer, and then, it worked for the OP. So, I did exactly that. And then, when I restarted the tablet, Boom! I was asked for my preferred language, and basically I was on the Android, "First Setup" screen!

I set it up, and started restoring stuff from my account on the cloud, and as of this moment, the tablet is still downloading and updating all of my apps, and books and almost everything that was there on my tablet.

And just in case you are interested I have posted the whole LOG file [here](https://gist.github.com/icyflame/97d3c29f62278790be50). This is the log for the Ubuntu installation.

According to [this article on CNET](http://www.cnet.com/how-to/android-5-0-lollipop-update-list/), Lollipop will be pushed for Nexus 4, 5, 7 and 10. So, chances are that I will get Lollipop for the 2012 version, but even if I don't, I am confident enough, (now!) that, I will flash it as soon as the image is up on the factory images page!
