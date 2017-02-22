---
layout: post
comments: true
title: Day 5 - Linux, Pendrives and Encryption!
categories: 100daysofwriting writing linux encryption
---

The paranoia of having your hard drive crash on you is devastating, once it
bites you. It's the fatality and the irreversibility of it. Once a hard drive
has crashed on you, the only thing that you can do, is take the computer to some
repair place, and have the hard drive changed (or if you are sure it's the hard
drive, order a new one online and replace it yourself). Nonetheless, the data
that you had is gone. Generally, people say **Backup your data and keep it in a
safe place**.

The problem is that for most people, the hard drives that you do have just do
the job. There's never enough to have 2 copies of anything. If you had that much
space, you probably would have a hard drive that's more reliable and you would
not have to be as paranoid. Anyway, I think you see where I am heading with
this.

There are a few files on your system that are absolutely important. Files which
when lost will wreak havoc in your life for a brief period of time, and when
stolen will cause a lot more problems in a lot of other people's lives too. I
can only think of the following:

- RSA keys inside `.ssh`: Added in Github, Gitlab, the like. Also on servers
    that you might want to SSH into. If these servers host a website, well.
    There's a lot of trouble that a non-sudo user can create. (Fork Bomb)
- PGP keys inside the keyring, accessed through `gpg` Android signing keystores,
- `.jks` files. Losing these will mean that you can't
    upload APKs to your Google Playstore app
- If you use something like `mutt` or `msmtp`, then the Gmail App Passwords are
    stored in plaintext as 600 files. No one else can read them, but if they are
    stolen, that user can certainly read them!

I think the list might be a bit longer. But the above should be enough to
demonstrate my previous paragraph.

So, the simplest way to get around all of this, is to use Github / Gitlab
extensively. They provide a lot of free space, and can be used to host code,
small files, folders that have project work, etc etc. But what about the private
stuff? The private keys, the keystores?

That's where a flash drive comes in. A flash drive that has everything stored on
it. But wait a minute: creating this small device that has all these files that
you don't want to be stolen on it? you MUST encrypt it!

I had not done that till now. I was lucky enough for significantly bad things to
not happen to me because of this flash drive being stolen. (I even took it once
to a shop to print something out! Unbelievably stupidity!)

Ubuntu makes creating encrypted flash drives incredibly simple. You can use a
GUI for the most part!

The concise version:

```sh apt-fast install gparted gparted /dev/sdb # create two partitions. FAT32
in the beginning of the space, # ext4 at the end of the space ```

Now, open the Disks Utility, and format and create a LUKS + EXT4 system on the
last partition. This will prompt you for a password, and that's it! That was 2
steps! Incredibly easy.

And now, the pen drive works on Linux, as well as on Windows! (Because most of
the world uses Windows, and more often than not, you are going to have to
transfer files from Linux to Windows.)

Windows throws an ugly error when it realises that the pendrive has an Ext4
healthy partition that it can't read, and says you must "Install software that
can do that", and I think there are Ext4 partition readers for Windows. I have
no intention to install or use them. I went into Windows only to test that FAT32
works.

This part was easy. This is how it looked inside Nautilus:

![day-5-1](/blog/public/img/day-5-1.png)

It goes without saying that LUKS + EXT4 will natively work only on Linux based
systems. LUKS stands for [Linux Unified Key
Setup](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup), I don't know what
kind of encryption it uses, I intend to find out. Also,
[PBKDF2](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup), this is the
function that is used everywhere. It's used in LibreOffice documents, it's used
in LastPass, it looks simple, but reading up on it's security and any analysis
of that should be interesting!

The second project for the day that I had ambitiously decided to take up was to
create a bootable pendrive with persistent storage. Because honestly, Live CDs
without persistent storage are so useless! I am not going to have internet all
the time, and I am not going to have time to install vim, and my dotfiles, and
all that each time I login at a new computer, where I probably want to quickly
get something done!

At the surface, this seemed like a really simple thing. I would simply get a
pocket Linux distribution of my liking. Damn Small Linux, PocketLinux, Pen Drive
Linux, Slax there were a few options to choose from. I chose DSL. It didn't
work. I did go through a set of absurd and comic situations to figure that out
though.

I followed the instructions on the [DSL Wiki page for
installation](http://www.damnsmalllinux.org/wiki/installing_to_a_usb_flash_drive.html).
It was a detailed instruction set, that repeatedly told me that if I didn't use
`fdisk` correctly, I would be in a big mess. Thanks for telling me that!

Anyway, soon I found out that the USB had a GNU Partition Table, SysLinux was
the bootloader, and it apparently didn't support EFI. Because the `/efi` or
`/boot/efi` directory, one of those, was simply missing! My computer is also
GPT, has a Grub bootloader, and UEFI boot. (UEFI is like BIOS, but better. A lot
more robust, can handle more number of operating systems, and some such!)

It took me about 2 hours to realise that this was not going to work. Apart from
SysLinux, Grub was the other choice that was mentioned on the wiki, and there
were "notes" in that section saying "It doesn't work in some cases". So, clearly
that wasn't going to work for me.

Eventually, I had to dump all of this and get back to Elementary OS Freya. It's
a great distribution which I used without Persistent storage on a pendrive for
some time whenever I went out. I stopped taking my laptop everywhere, and it
made a lot of sense. Until I was fed up of installing everything again and
again, all the time.

Ironically, Ubuntu doesn't have one single reliable UEFI + FAT32 Live USB
creator for Linux. That, for some reason, is incredibly amusing to me! I finally
had to go back to Windows, and use Rufus, which worked perfectly! How weird.

My forward plan is simple: I am going to find a small Linux distribution that
supports UEFI, I am going to create a Live USB of it. I want a protected setup,
so I will either have to use a LUKS + EXT4 partition for persistent data
(because Live USBs don't have accounts or protection of that sort).

This post is somewhere between a bad tutorial on creating encrypted partitions
on pendrives and a rant about Ubuntu not having a good UEFI startup disk
creator. (The inbuilt one doesn't work, I choose the ISO and it doesn't do
anything after that. Tuxboot live creator is another program which I hoped would
work, but it doesn't work even with distributions that support UEFI, like
Elementary)
