---
layout: post
comments: true
title: Goodbye Pi-hole. Hello CoreDNS.
categories: dns ad-blocking internet
---

I understand the economics behind advertising. Advertising can be used to subsidize
content. However, I refuse to accept that Bloomberg.com needs to show advertisements to a paying
subscriber.[^1] This comes down to personal preference: If you believe that advertisements are a
net good and support the work that you are viewing "for free", so be it. I do **not** believe that. If
I must pay for content that is ostensibly "free" by having my attention distracted by an
advertisement which I did not ask for and am not interested in, then I reserve the right to use
every tool in my arsenal to avoid seeing the advertisement. All of this is just a preamble to a
recent change I made in one of the central components that I use to browse the Internet daily: my
DNS server. I switched from Pi-hole, a popular adblocking DNS server, to CoreDNS with a plugin for
ad blocking that I wrote. This is a post about why I decided to **reinvent the wheel.**

<!--more-->


# Why Should You Run Your Own DNS Server?

![img](/public/img/dns-diagram-2022-06-12.png)

DNS (Domain Name System) is a key part of the infrastructure that makes up the backbone of the
Internet. It is also the most decentralized part of it. Most people use a DNS server which is a few
kilometers away from them. Internet Service Providers (ISP) will generally send default
configuration to their clients which will point them to DNS servers run by the ISP. This allows the
ISP to make a list of websites that their users are using and possibly use it as leverage when
negotiating with service providers [about preferential treatment](https://about.netflix.com/en/news/how-netflix-works-with-isps-around-the-globe-to-deliver-a-great-viewing-experience). However, the clients that users use
to browse the Internet, the web browser or their computer's operating system, has the ability to
override this setting and specify their own DNS server. Public DNS servers have been on the rise:
Google's `8.8.8.8` and Cloudflare's `1.1.1.1` are popular alternatives. These DNS servers have a
significant improvement: They are far more reliable compared to your local ISP's DNS
server. However, data about your Internet traffic continues to be sent to _someone._ To make the
situation worse, DNS traffic is mostly served over UDP. UDP is an insecure protocol which does not
protect information in transit. (Not "HTTPS," if you will.) So, your ISP _still_ has access to the
list of domains you are going to, if they are determined enough to get it. The solution to all of
these problems is **hosting your own DNS server on a [Raspberry Pi](https://www.raspberrypi.com/) computer** inside your home.

So, there's one advantage: **Your DNS request, which contains the domain name that you are visiting,
does not leave your home.** Your ISP has no clue where your traffic is going. (They can figure it out
using the IP address that your packet is headed for, but this is harder and ISPs have a tendency to
go for the low-hanging fruit and not spend _too_ much time trying to track their users.)

There is another advantage: **If you don't like the domain inside the DNS request, then you can stop
the request in its tracks and prevent the client from fetching what it needs to fetch.** Your browser
loads a page (for example, a news website). The news website has a script which will call an
advertising server and try to figure out what ad to place in the box in between paragraphs. If you
could identify _just_ these requests to the advertising server and block them somehow, then the
website will not be able to show you ads!

![img](/public/img/dns-blocking-diagram-2022-06-12.png)

One idea is to create a list of the IP addresses that are used by advertising servers around the
world and block any request which is bound to these servers. This is hard and not reliable enough
because IP addresses change a lot and the process for changing them can be easily automated.

Another idea is to list the domains which these servers are on and block any DNS request for these
domains! This approach is convenient and reliable: Changing domains is hard and even if domains are
changed, if you don't want anything on the domain, then you can simply add the new domain to your
blocklist. Changing domains is hard primarily because each new domain has to be registered with a
domain registrar and this requires a small fee. The fee must be paid and payment to vendors on
demand is hard to automate.

So, we have a good approach. But we are missing the key component: The list of domains which we want
to block. There are many excellent lists out there and I recommend [this one](http://hosts.oisd.nl/). It lists about 1
million domains and it seems to be updated frequently. This list is an aggregation of [other lists](https://oisd.nl/includedlists)
and works well. (I have used it along with [another list](https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts) for the past several months, and I have not
had any domain which I wanted to send traffic to blocked.[^2])

Now, we have a list of domains that we want to block and the approach that we are going to use to
block the domains (a DNS server which can look at this list and block requests which match a domain
in the blocklist.) Now, **we need to search for the software which will implement our solution.**


# Why CoreDNS?

There are many options. The most popular one is [Pi-hole](https://pi-hole.net/), I used it for a few months and realized
that I could not continue using it because I disagreed with its GUI-centric design
philosophy. CoreDNS is written in a programming language that I like and am familiar with, and don't
mind maintaining in the long term.


## Pi-hole

Pi-hole is written in the programming language C. I chose it, as I believed that it was built for
running on a Raspberry Pi. (I did not research how it was built or why it would run well on a
Raspberry Pi.) It was fairly easy to set up on a Raspberry Pi. There were some manual steps during
the setup process and it could not be fully automated. However, this was not a big problem for me
because I did not believe that I would need to repeat this setup process.

I started noticing problems with Pi-hole almost immediately after setting it up. The main problem
seemed to be with its statistics reporting module. The sane way to report statistics is to provide
an API endpoint which can be scraped periodically. This API endpoint should either take the starting
time for statistics or have a configurable time period, which can be passed as a parameter to the
request. Pi-hole had a strange 24 hour pre-configured time window. I was not sure why it was 24
hours or why it is pre-configured.

I was convinced that this was going to be a deal-breaker for me. The only thing I wanted my DNS
server to report was the number of requests that it blocked and the number of requests that it
forwarded to the upstream DNS server. This value _could_ be wrangled out of Pi-hole and I figured
out how to do it. I had to dive deep into Pi-hole's C code. There isn't that much of it and I was
able to read it all over a few hours. I had to make [2 pull requests](https://github.com/pi-hole/FTL/pulls?q=is%3Apr+author%3Aicyflame+is%3Aclosed) to use the existing
configuration variables. The values of these variables was not respected by the application code.

With these patches, I had managed to get the statistics that I wanted. Perhaps, I should have
stopped here.

However, the more I thought about **what** Pi-hole was really doing, I realized that its only reason
for existence was statistics collection. Indeed, the whole repository was a large wrapper around
Unbound, a full-featured DNS server. All Pi-hole did was maintain a few counters which it
incremented based on the requests that it received/blocked. The statistics that it collected were
supposed to be displayed on a GUI dashboard.

I **do not** like this design. A DNS server should do one thing and one thing well[^3]: Serve DNS
requests and block the ones that the user does not want to serve. To plaster a GUI onto this server
and change the code inside to fit it to the needs of the GUI is a bad idea, in my opinion. If users
want a GUI, then they should use the statistics that are reported by the DNS server and make their
own GUI. At the very least, the GUI should be an optional part of the DNS server and no code inside
the DNS server should be specific to the GUI.

Pi-hole did not follow any of these principles. Most of the code inside the repository was primarily
to make the GUI better looking. [One of the patches](https://github.com/pi-hole/FTL/pull/1312) I made ended up creating a bug for most users of
the Pi-hole GUI because it changed the way that time slots were stored. Instead of storing
statistics for the "24 hours until now" when the server starts, I proposed storing the "24 hours
from the start of the server." My approach would make sense if the server had to store the
statistics only to report it to the user as a number. If the statistics are part of a GUI, then when
the server starts, the user will see [a jarring empty graph](https://github.com/pi-hole/pi-hole/issues/4459) with the current time on the left side of
the horizontal axis, with the future 24 hours with no data.

[This bug](https://discourse.pi-hole.net/t/found-database-entries-in-the-future/55333) which my innocent PR to improve statistics reporting had caused put me over the top. I
decided to change the solution because I could not live with this C code which was not designed in a
way that I approved of and had a lot of code to satisfy GUI users, when I knew for a fact that I was
never going to use the GUI bundled with a DNS server.


## CoreDNS

[CoreDNS](https://coredns.io/explugins/) is a forwarding DNS server written in [Golang](https://go.dev/). It is not a recursive DNS resolver. Indeed, it
does not do anything related to caching or the recursive process required to resole DNS
queries. However, it does everything that is required before and after this core part of the DNS
resolution process. **Most importantly,** CoreDNS is built with plugins in mind; it provides
first-class support for preexisting plugins as well as plugins written by the user.

The [plugin API](https://coredns.io/manual/plugins/#writing-plugins) is intuitive. Every DNS request passes through a series of plugins. By controlling
the order in which these plugins operate, it is possible to change the input or the output of these
DNS requests. And any plugin can return a response to the user. All the heavy-lifting required to
keep track of plugins, integrate with each plugin and call them at the appropriate time, identify
whether the plugin is going to respond or simply fall through to the next plugin is done by CoreDNS.

Another (incidental) advantage is that I have been using Golang at work for the past 4 years. My
familiarity with the programming language is quite high and I was happy to write and maintain a
CoreDNS plugin which blocked DNS requests for domains that I did not want to access.

So, over 2 days, I wrote a [CoreDNS plugin](https://github.com/icyflame/blocker) to block domains based on a file and [Ansible configuration](https://github.com/icyflame/pihole-on-raspberrypi/compare/13ed35e71d9cd6159a148fea164f45ec70878995...851cf76e0c413180e866c8ad6f20f193ede7ab68)
to deploy this plugin alongwith the main CoreDNS application to my Raspberry Pi.


## Other Options

[AdGuardDNS](https://github.com/AdguardTeam/AdGuardDNS) is the closest alternative to what I built. The DNS server is a fork of CoreDNS and it
uses a bunch of plugins built and maintained by AdGuard. I don't have a good reason for not using
this. One of my friends uses this on their Raspberry Pi and they recommended it to me. I looked into
it and decided not to use it mostly on a whim: [AdGuard](https://adguard-dns.io/en/welcome.html) is a business that sells an AdBlocker and VPN
software.[^4] The DNS server seems to be part of their offerings and they do have a GitHub
repository and the DNS server is open source. However, there is some discussion about how future
features might not be added to their open source offering and only added to their paid offering.

[My coworker @execjosh's mydns](https://github.com/execjosh/mydns) is another homegrown blocklist-enabled DNS server. It has a lot of
logic which was not a part of my CoreDNS plugin because all the request handling was outsourced to
DNS. Also, CoreDNS has excellent built-in support for metrics collection.


# Improved Metrics Collection

So, did my monitoring problem get solved? Yes.

CoreDNS has a [metrics](https://coredns.io/plugins/metrics/) plugin. This metrics plugin reports metrics in the [Prometheus](https://prometheus.io/docs/introduction/overview/) format. Having
worked with Prometheus servers inside Kubernetes for the past few years, I am familiar with this
format and I marvel at its simplicity. Now, getting the number of blocked and forwarded requests is
_very very simply._

```sh
pi@dns-1:~ $ curl localhost:9153/metrics -s | grep dns_responses_total
# HELP coredns_dns_responses_total Counter of response status codes.
# TYPE coredns_dns_responses_total counter
coredns_dns_responses_total{plugin="",rcode="SERVFAIL",server="dns://:53",zone="."} 458
coredns_dns_responses_total{plugin="blocker",rcode="NOERROR",server="dns://:53",zone="."} 5191
coredns_dns_responses_total{plugin="forward",rcode="NOERROR",server="dns://:53",zone="."} 218955
coredns_dns_responses_total{plugin="forward",rcode="NXDOMAIN",server="dns://:53",zone="."} 2073
coredns_dns_responses_total{plugin="forward",rcode="REFUSED",server="dns://:53",zone="."} 2232
coredns_dns_responses_total{plugin="forward",rcode="SERVFAIL",server="dns://:53",zone="."} 426
```

Using the `plugin=` part of this output, I can quickly see that 5191 DNS requests were blocked by
the server. 218,955 DNS requests were forwarded to the upstream DNS server (an Unbound instance
running on the same Raspberry Pi.) Forwarded requests faced some errors like "Non-Existent Domain"
(`NXDOMAIN`) or "Server Failure" (`SERVFAIL`).

If I were to run Prometheus on the Raspberry Pi, I should be able to collect these metrics easily
and then deploy Grafana as well on the same Pi to visualize these metrics. However, I don't think
that I will be doing that. The Raspberry Pi uses flash memory and is severely limited in the disk
read/write throughput. The DNS server itself will only rarely read from disk. I am interested in
only one metric from the CoreDNS server, so I believe that I will continue to use an external
monitoring tool such as [Mackerel](https://en.mackerel.io/) or [Round Robin Database](https://oss.oetiker.ch/rrdtool/tut/rrdtutorial.en.html), which is more typical for networking
applications.

[^1]: Bloomberg subscriptions cost $35 per month.
[^2]: The only domain that came close was related to Bloomberg and its emails. This domain was included in the lists as a domain that serves ads, but it was a domain which is used for links inside newsletters sent by Bloomberg via email, and is a tracking domain indeed. It redirects to the main Bloomberg.com website.
[^3]: [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy#Do_One_Thing_and_Do_It_Well)
[^4]: The essay [Don't Use VPN Services](https://gist.github.com/joepie91/5a9909939e6ce7d09e29) accurately captures my feelings about what VPN services really offer and whether people should use services that they don't control.
