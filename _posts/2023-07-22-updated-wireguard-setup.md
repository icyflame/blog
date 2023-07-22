---
layout: post
comments: true
title: New Wireguard Peer in 10 Minutes
categories: wireguard vpn technology
---

I have been using Wireguard for about [4 years now](/2019/12/22/wireguard-on-linux). I started with the basic Wireguard setup, where I
did everything manually and used the `ip link` and `ip addr` commands to create new links and assign
addresses to them. The `wg-quick` utility is open-source and has built-in SystemD support. So, I
switched to using the configuration file that `wg-quick` requires. With an ad-blocking DNS server, I
was able to use the setup for a long time without having to change anything at all. The client
support was excellent on Linux, Android and (even) iOS. I never really noticed whether I had my VPN
enabled. I kept it enabled at all times except when I needed to access some geofenced
service. However, I was still writing the wg-quick configuration files manually and most of them
were very similar. This caused me to put off adding new peers to my network as soon as I needed to.
Recently, I wrote [a Golang CLI tool](https://github.com/icyflame/wireguard-configuration-generator/) which generates `wg-quick` compatible configurations for
Wireguard peers, based on a simple JSON input file. Using this tool, I was able to add a new
Wireguard peer and create a new network in less than 10 minutes. The path to that CLI tool is what
this post is about.

<!--more-->

Wireguard is **very** simple.[^1] Literally and conceptually. Literally, it is less than 4000 lines of
code. The [original patch](https://lkml.org/lkml/2019/11/27/266) that added the VPN to the Linux kernel is very small and I have always
wanted to read it, although I have never been able to because knowledge about the Linux kernel
networking stack is a prerequisite. Conceptually, it can be explained with a single slide. A
rudimentary understanding of Linux syscalls is sufficient to understand this slide.

![img](/public/img/wireguard-concept-slide.png)

**Source:** [Wireguard Presentation - October 21, 2016 - Codeblue, Tokyo, Japan](https://www.wireguard.com/presentations/#october-21-2016-codeblue-tokyo-japan)

Given all of this simplicity, the wg-quick configuration to establish a traditional VPN is also very
simple: It is about 10 lines of code that needs to be on every machine that is part of the VPN, and
the 2 main differences between configuration files were the ASCII keypairs that are used to identify
peers inside a network, and whether it is on the server (the peer which will forward all the traffic
towards the Internet) or the client (the set of peers which will send traffic to the server asking
it to forward it to the Internet). The configuration is so small that no tool is distributed to
generate it.

![img](/public/img/Wireguard-Configuration-Generator-Schematic.png)

I have 2 main devices: a computer and a phone. I was able to connect them to 2 VPN servers with a
total of 6 configuration files. The key pairs for each pair among the 3 servers for 2 different
networks was different (intentionally); so when I was originally setting this up, I made some
mistakes while copying the keys and pasting them around, and it took me a couple tries to get the
setup right. Once I got the setup right, I did not bother to change it for 2 years. After that, I
had some new requirements which this manual setup did not meet: I wanted to add new clients and new
servers quickly, because I expected the number of clients to grow and I did not want to manage the
keys manually anymore. As each peer had a single private key inside each network, and the public key
could be derived from the private key, this only meant that I needed some sort of persistent map
between 2 keys: network and client name and 1 string value: the Wireguard private key. JSON or YAML
files are perfect for this and building a system which reads the file and writes configuration files
to disk would be ideal and easy.

Some more advantages of this setup was that, all of these configurations were just files. There is
no need to introduce a new tool to manage them. If your hard drive is already encrypted, you can
just keep the files as-is on disk, and as long as you are able to boot your computer, the file will
always be available. If you want to keep the file on some sort of cloud storage but encrypt it
end-to-end, then you could easily use [GNU Tomb](https://dyne.org/software/tomb/) to create an image file, that is internally a
LUKS-container, with an ext4 filesystem, and upload this image file to the cloud storage
system. Most cloud storage systems have good integration with the Gnome Files or Nautilus
applications, so syncing the files is not manual and the status of syncing can be checked easily.

I did not get around to implementing all of this until last month, when I realized that one of my
new devices did not have a VPN setup and I had been avoiding any use of the device that required a
VPN. I did not want this pattern to continue.  I wanted to be able to introduce new clients and
servers easily and without having to think too much, so I got around to writing a single-file Go
program which would use a JSON file as input and generate configuration files on demand.

The result of it is [icyflame/wireguard-configuration-generator](https://github.com/icyflame/wireguard-configuration-generator). It is not a single file application
anymore, and I ended up adding some convenience features. My favorite one is the input file
validator. The JSON file itself is quite small and you can probably read the whole thing in one
glance, however, when adding a new peer, you have to ensure that the IP address that you assign it
is unique. So, the tool will automatically read the whole file and ensure that it makes sense: That
each peer inside a given network has a unique IP address and that the names of the peers inside a
network are unique so that the files can be properly named.

[^1]: There are many great talks about Wireguard by the author, zx2c4. I recommend this one: [WireGuard: Next Generation Secure Network Tunnel - YouTube](https://www.youtube.com/watch?v=88GyLoZbDNw)
