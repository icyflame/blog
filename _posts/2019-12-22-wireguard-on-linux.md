---
layout: post
comments: true
title: Setting up Wireguard - Experience
categories: wireguard linux vpn
---

[![twitter-screenshot](/public/img/2019-12-14-twitter.png)](https://twitter.com/_icyflame/status/1205691360755372033)

**Note:** There are [several][1] [guides][2] [out][3] [there][4] which have a
set of steps and the commands to set-up Wireguard on a Linux computer. This post
is written along those lines but takes a different approach - it focuses more on
what one can learn about basic Linux networking by doing this setup themselves.

## Premise

I started out with a fairly clear goal: Setup a VPN server inside a Digital
Ocean droplet to forward all local traffic through, using wireguard.

I wanted to use Wireguard mainly because it was inside the kernel which had this
subconscious implication that it would be blazing fast. Also, I have seen the
video on Wireguard's website which has Alice and Bob side by side and in about
7 commands the video shows how `Bob: ping Alice` starts working! This was fairly
revoutionary to me because until now I had used two kinds of VPNs:

<!--more-->

1. The free apps: This includes SurfEasy, which is how I used to use Spotify in
India before they offered their service here, CloudFlare's new app which is
pretty easy to use but works only on my phone for the time being.

2. The enterprise kind: This is for work, and it is extremely painfree. It's
also fast enough that I haven't noticed a big slow down that often. I don't
really know how it is all set-up inside, but like every company, there are some
professional IT engineers who have set this up so that no one wastes any time
trying to figure this out.

My current goal was to get something up and running which was easy to set-up,
fast when I was using it and worked seemlessly on a Linux desktop. Wireguard
seemed like the only choice.

### Sidenote: What about Streisand?

If you are into self-setup VPN servers, you might have heard of [Streisand][5].
It's a huge Ansible playbook which will take some input from the user and then
setup a VPN server on the provider of your choice. The server that it sets up
can be used as a Tor bridge, an OpenVPN server, a Wireguard server, an HTTP
proxy server, SOCKS proxy or as an IPSec server. Overwhelmed?

If you aren't overwhelmed yet, then let me tell you how the setup works: You run
the setup script, you enter your provider of choice, what you want (automatic
setup of all the provided components is encouraged, although you can choose to
install only the components you want, if you are so inclined), and then Ansible
starts it's job. It will start running these playbooks on the VPS server.

Everything is pretty good until this point and at this point, the last time I
was setting this up, I decided to leave my computer be and get some food. When I
came back, I saw an error message that was waiting for me. I didn't really get
it, so I googled it found the problem, fixed it and ran the setup script again.
Guess what? It started setting everything up from scratch. Yes. After seeing
that, I gave up on Streisand.

### Sidenote: What about a simple HTTP proxy?

The [Squid HTTP Proxy][6] is great. It has a simple configuration file format
and it's possible to run it using docker on any computer anywhere.

```sh
# Prepare the configuration file
docker run --rm sameersbn/squid \
    cat /etc/squid/squid.conf > squid.conf
# Edit the configuration file
# Start the proxy server using this configuration
docker run --name squid -d --restart=always \
    --publish 3128:3128 \
    -v "$PWD/squid.conf":/etc/squid/squid.conf \
    sameersbn/squid
```

If your goal is to only forward all your traffic, you can probably settle with
just this proxy. External websites will see the IP address of your droplet or
GCE instance or EC2 instance. This is extremely fast because the overhead is
extremely small and it is very cross platform because everything supports an
HTTP proxy.

Only, the only thing is, I had a nagging doubt about whether my HTTPS website
headers were put in the HTTP Connect request that was made to the proxy server.
I don't know much beyond what I studied in my Networks course and what I learnt
from the TLS RFC, but I had a feeling that the `Host` header was being passed
through and that meant the HTTP request between the proxy server and my computer
exposed the Host header (??). I wasn't really sure about this. I didn't ever
set-up Wireshark and properly look at what was going on the network. All in all,
this nagging in the back of my head ended up being the nail in the
use-HTTP-proxy-for-everything coffin.

## Enter, Wireguard

> WireGuard is an extremely simple yet fast and modern VPN that utilizes
> state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more
> useful than IPsec, while avoiding the massive headache. It intends to be
> considerably more performant than OpenVPN. WireGuard is designed as a general
> purpose VPN for running on embedded interfaces and super computers alike, fit
> for many different circumstances. Initially released for the Linux kernel, it
> is now cross-platform (Windows, macOS, BSD, iOS, Android) and widely
> deployable. It is currently under heavy development, but already **it might be
> regarded as the most secure, easiest to use, and simplest VPN solution in the
> industry**.
-- wireguard.com

This sounds _simple_, deceptively _simple_. I had tried to set-up Wireguard once
before and I had failed miserably at it. I had run some commands on my personal
computer which ended with the computer not being able to access the internet at
all. I panicked for a short while as I found the opposite of every single
command I ran to at least get internet back. After this experience, I had
realized that Wireguard operated at a layer which below the application layer
where things can get messy really fast and it's hard to get out a problem you
created with a command you don't completely understand.

This time around, I had two advantages, I think. First, I had learnt about the
value of taking notes and writing down every command I was running through the
operations-type work I had done at work. And second, my personal computer was a
Thinkpad with the latest Ubuntu and I was not worried about running into any
hardware specific issues.

### Step 1: Establishing the tunnel

Wireguard has a [quickstart video][7]. It is a side-by-side of two peers which
starts from scratch and ends with a tunnel that connets the two computers. The
two peers get their own IPs on the tunnel and they can ping each other. Now, I
didn't know how this would help me achieve my final goal of forwarding all my
traffic through another peer, but it seemed like the first step in understanding
wireguard and actually figuring out how to set it up properly.

I got a Digital Ocean droplet and I started running the two commands
side-by-side. I was noting down the commands I was running and the output of
each command as I went through the steps. I was also thinking about the
resources I was adding to my personal computer and the commands that I would
have to run to remove them. When I installed wireguard, I was asked to configure
secure boot and restart the computer and enter the secure boot password. This
was probably because wireguard is installed as a kernel module and secure boot
doesn't like additions to the kernel outside of the boot process? This is all
complete conjecture.

Anyway, after restarting once to set-up secure boot and once so that the network
interface device type `wireguard` becomes available to `ip link`. After this, I
continued to run the commands just as they are run on the side-by-side video.

At the end of that process, I had a tunnel between my computer and the droplet.
`ping 10.0.0.1` started working as it should. At this point, I checked the
output of `ip route` and realized that all the traffic to `10.0.0.0/8` was being
sent through the wg0 network interface. I realized that I could do `ssh
10.0.0.1` to SSH into the droplet! This was my *first moment of epiphany*; I
suddenly realized that the droplet might well be next to me in my house. My
computer and the droplet were on a network and knew about each other as 10.0.0.1
and 10.0.0.2. They could do things like move files across this network and it
will all go through Wireguard's crypto and will not be visible to anyone else on
the network, not Digital Ocean, anyone in between or my home internet provider!

I hadn't configured forwarding all my traffic yet, but I at least had a skeleton
around which I could work. Also, I had learnt a lot more about `ip link`, `ip
addr` and `iptables`, although I didn't understand exactly how they all worked
together with Wireguard.

_Sidenote:_ I installed docker and squid-proxy on the droplet and forwarded all
my traffic through 10.0.0.1:3128! This worked as I expected it to and changed my
public IP.

### Step 2: Watching the Wireguard talk

<iframe width="1266" height="712" src="https://www.youtube.com/embed/CejbCQ5wS7Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

It is incredibly rare that you learn more about a piece of software after
setting up one part of it. Wireguard is one of those rare pieces of software
that claims to achieve something so simple that you have to actually listen to
someone explaining it to believe it.

In this talk, [Jason (@zx2c4)][8] explains what Wireguard does and how it
achieves the goal it was built for: establishing a tunnel between any two
computers, as a kernel module. In particular, this diagram clarified a lot for
me:

![img](/public/img/wireguard_block_diagram.png)

In particular:

1. I had read in a couple of places now that when adding the server as a peer on
the client computer, setting `allowed-ips = 0.0.0.0/0` will forward all of your
computer's traffic through to the server. Now, I realized that when the packet
reaches the wireguard interface wg0, the packet's destination IP will be matched
with the allowed-ips list to find the peer. If I wanted all traffic to go to the
same peer, I would simply add a single peer and set allowed-ips = everything.
1. On the way back, the packet would be headed to the client computer and the
server configuration has the appropriate configuration already to route the
packet properly. So, no changes were required on the server side.
1. "Linux kernel: Ordinary routing table -> wg0": I had not done anything for
this to be the case yet. I found [this guide][9] on the wireguard website which
showed me how to set up my routes so that everything would go through to the wg0
interface. I chose to go with the second approach of adding two rules that
forward all traffic to wg0 and then forward everything from there to the server.
1. The server gets all these packets on the wg0 interface which it has to then
send outside through the eth0 interface. This is achieved using some iptables
rules. I don't fully understand these rules, they somehow work without
specifying the name of the source and the destination interface.

### Step 3: Forwarding traffic without name resolution

After watching the talk, I removed my existing peer and re-added the peer with
`allowed-ips = 0.0.0.0/0`. Then, I added the appropriate ip routes using the
NetNS guide on wireguard.com. The final piece in this puzzle was the changes on
the server side to move traffic from wg0 to eth0.

After trying commands from several tutorials, I finally found the set of three
rules that worked for me on a GitHub readme written by someone who was talking
about a very specific use-case for wireguard!

```sh
iptables -A FORWARD -i %i -j ACCEPT
iptables -A FORWARD -o %i -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

Now, finally, `curl <IP-for-icanhazip.com>` returned the IP address of the
droplet and not my local computer. There was no DNS server that my computer
could use just yet, so there it was not able to convert the domain's name into
the IP address.

### Step 4: DNS

Most of the wireguard setup guides recommend using Unbound DNS server installed
on the VPN server. The configuration for Unbound looked long and I wanted to get
something up and running before figuring more stuff out, so I decided to use
Google's DNS server. I got this command from the [`wg-quick` utility][11] that
is packaged with wireguard-tools.

```sh
$ printf 'nameserver %s\n' "8.8.8.8" | resolvconf -a "tun.wg0" -m 0 -x
```

_Sidenote:_ There are several other useful commands in the code for this
utility. I have been reading it in my spare time to figure out what other things
I could do to improve my setup.

After setting the DNS server up, `curl icanhazip.com` started working. Other
websites also started working properly.

### Evaluation

Checking speeds on fast.com showed me that using the VPN caused a slowdown of
about 20 times - down from 21 MBPS to 1 MBPS. This is pretty good. Also, as
literally all my traffic was going through wireguard now (except for DNS), I was
able to use all other application without any special configuration. For eg,
`ssh` started showing the droplet's IP as the source IP in `who -a`, `git push`
wanted to add a new origin because the push for my SSH key was coming from a new
computer now. In general, everything seemed to work without anything breaking
catastrophically.

## Conclusion

At long last, I had a fast, working VPN solution for a Linux desktop computer.
Wireguard is revolutionary. It creates a point-to-point tunnel between two
computers (networked devices). What this tunnel is used for, is left to the
user's discretion. Wireguard simple creates the tunnel and gets out of the way.
The only caveat is that one has to understand quite a bit about networking on
Linux computers to use it properly. As the creator of Wireguard says in his talk
above, "There's no way to misconfigure wireguard and still have it work. If you
don't configure it right, it simply doesn't work"

## Next steps

For me, these are the things I want to do from here:

- Install Unbound and start using it as a DNS server
- Set-up Wireguard on my phone
- Set-up wireguard on an OpenWRT router which moves the layer one step away from
  the computer and makes it easier for phones to connect and use wireguard
- Read the [Wireguard whitepaper][11]

[1]: https://www.ckn.io/blog/2017/11/14/wireguard-vpn-typical-setup/
[2]: https://www.stavros.io/posts/how-to-configure-wireguard/
[3]: https://mikkel.hoegh.org/2019/11/01/home-vpn-server-wireguard
[4]: https://hbh7.com/2018/09/30/setting-up-a-wireguard-site-to-site-vpn-between-2-edgerouters/
[5]: https://github.com/StreisandEffect/streisand
[6]: http://www.squid-cache.org/
[7]: https://www.wireguard.com/quickstart/
[8]: https://www.zx2c4.com/
[9]: https://www.wireguard.com/netns/#routing-all-your-traffic
[10]: https://github.com/notasausage/pi-hole-unbound-wireguard#configure-wireguard-server
[11]: https://git.zx2c4.com/WireGuard/tree/src/tools/wg-quick/linux.bash?id=372152122766ad2ce8d9510cd5b6b0369a85dd75#n153
[12]: https://www.wireguard.com/papers/wireguard.pdf
