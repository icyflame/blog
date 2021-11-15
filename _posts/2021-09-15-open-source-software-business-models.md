---
layout: post
comments: true
title: Open Source Software Business Models
categories: software open-source essay
---

[A few days ago](https://www.theregister.com/2021/07/13/opensearch_10/), AWS released version 1 of OpenSearch, a fork of ElasticSearch. OpenSearch is
open-source software licensed under the [Apache License v2](https://choosealicense.com/licenses/apache-2.0/). ElasticSearch's creator, a for-profit
company called Elastic Co. has been involved in a dispute with AWS for months now. The dispute
began when AWS packaged ElasticSearch and started offering a managed service on their cloud
platform. There seems to have been no partnership between AWS and Elastic, and this lack of a
partnership has irked Elastic no end. This raises a question that others have [attempted](https://www.baldurbjarnason.com/2021/the-oss-bubble-and-the-blogging-bubble/) to answer:
What is the business model for free and open-source software? Who should fund its development? Who
should benefit from the profits made using that software?

<!--more-->

I like free and open-source software (OSS). My rationale for using it is simple: It allows me to
**choose** how I spend my time. I can decide what software packages to use, which version and for how
long. If I don't like a future version of a software, then I can stick with the version I like,
until the time that security fixes are released for the version I have. I can decide the OS version
I want to use and use it for [10 years](https://wiki.ubuntu.com/Releases)[^1] without having to [install updates](https://support.apple.com/guide/mac-help/get-macos-updates-mchlpx1065/mac) or upgrade my hardware
because a future version of the OS slows down my [computer](https://www.macbookproslow.com/after-updating-to-newer-macos/). (Or [phone](https://www.howtogeek.com/183004/why-android-phones-slow-down-over-time-and-how-to-speed-them-up/).) This "decade-long end-of-life
cycle" is important to me because I don't want to spend any time installing, updating or upgrading
operating systems[^2].

I don't have an ideological reason for using open-source software. The open-source [ideologues](https://www.gnu.org/philosophy/pragmatic.html) and
open-source software users are not one and the same. Most people in the former group are also in the
latter, while a minority of the latter is made up of ideologues. Consequently, I don't think that
open-source software is the silver bullet to solve _all_ problems. Proprietary software regularly
solves problems much better than OSS can ever aspire to: IntelliJ is a set of proprietary tools for
working with PHP that is very powerful and I use it at work when working with a large PHP
codebase. It has a good plugin ecosystem and supports every process of the software development
cycle. Photoshop and the Adobe ecosystem for editing photo and video files is another example of
proprietary software _basically_ taking over the world.

Another piece of proprietary software changed the nature of computing for billions of people:
Windows is the most widely used operating system. It's usage is widespread enough that most people
(including me) started computing on a Windows machine at home or in school. Without a powerful OS
such as Windows which was easily available on computers from major brands, fewer people would have
access to a computer and the Internet today. Windows solved the access problem **extremely well.**

Open-source software is a huge beast. There are millions of projects with wide variety in the ways
in which they are funded, maintained and the ways in which the project's backers ensure its
longevity. I will look at three models that are common.


# No Business Model

The simplest business model is to **not have** any business model. Most projects on GitHub are not
written with any aim to make money from them. Widely used tools such as ripgrep, [notmuch](https://notmuchmail.org/) and htop do
not solicit donations[^3]. The maintainers of these projects have been working on them for a long
time but they do not expect any monetary gain from their work. Philosophical reasons for this
apparently altruistic endeavor aside, this business model is popular and hassle-free.

While for-profit companies can start open-source projects with the intention of making money at some
point in the future, community-driven projects (projects that start with a single maintainer or a
few people working on it in their free time) are more common. This lack of a business model at the
inception of a project makes it hard to implant it into the project at a later stage.

One such project which tried to put in a business model at a later stage was the company behind the
[Brave browser](https://brave.com/), based on Chromium and published by for-profit Brave Software, Inc., started out
without any good business model. It has since tried to introduce "Attention tokens" and make an
[Initial Coin Offering](https://www.crunchbase.com/organization/brave-software/company_financials), which was _the_ thing to do in 2017.

A notable proprietary to "free and open-source" software transformation story is Microsoft's [Visual
Studio Code editor](https://code.visualstudio.com/). It has an interesting history. The proprietary software called VSCode was
originally released in 2015 and seems to have come out of the Microsoft Visual Studio IDE
project. In the subsequent years, Microsoft released most of the code behind VSCode, and published
that as an open-source editor under the permissive MIT license. Microsoft maintains a distribution
of the open-source editor which includes some proprietary assets but is free for private and
commercial use. The Community version of the parent product (Visual Studio IDE - Community) is
available for free download but can't be used in Enterprise settings. This Enterprise version of
VisualStudio IDE is the product that Microsoft sells to companies. (The product is similar to
IntelliJ but not as versatile or modern as it sticks with technologies that are used to develop
Windows apps, such as C# and ASP.NET.) Microsoft chose the "No Business Model" path for the
open-source Visual Studio distribution.


# For-Profit Companies Redistribute for a Fee

The original large-scale open source projects was the Linux kernel, the software that sits between
the operating system and the hardware that it is running on. Linux became very popular and people
spent large amounts of their time working on the Linux codebase. Eventually, a non-profit called the
Linux Foundation hired the maintainer. This enabled the maintainer to spend all his time on
maintaining the kernel and deciding the long-term roadmap of the project. The non-profit foundation
is supported through donor contributions.

Most large companies use Linux in some form. Large scale cloud platform providers like AWS, GCP and
Azure use Linux to deploy their datacenters and offer several services which are based on Linux and
other open source projects to their users such as Google's Compute Engines which offers virtual
machines running Linux operating systems for Compute or Google's Kubernetes Engine which is a
managed service running the open-source Kubernetes container orchestration software.

These profits (or a part of them) don't directly make their way back to the Linux maintainers, and
the maintainers are okay with that because they are getting back _enough_ compensation to work on
the project full time and keep the project going[^4].

For-profit companies like Canonical (publisher of Ubuntu) and Red Hat (publisher of CentOS) have
built open-source software on top of the Linux kernel. This software is free and open-source as
well, these for-profit companies redistribute the free software for a fee.

Another recent open-source project is Wireguard. Wireguard can be used to create a secure Virtual
Private Network (VPN) between any two devices which are on the same network (e.g. the Internet, a
router inside a house or at an office). The maintainer began working on this as a side project and
as a replacement for OpenVPN, the historical VPN standard. Wireguard also runs on donations from
companies and individuals, in the form of money and hardware, as a way to express gratitude for the
work that the maintainers are doing.

Tailscale is a for-profit company which sells a service that uses Wireguard underneath and allows
users to create a network between all the devices that they own using Single Sign-On providers like
Google and Microsoft to authenticate[^5].

Companies like Canonical, Red Hat, and Tailscale are not under any obligation to donate to the
maintenance of the software that their businesses are based on. But most such companies which are
redistributing free software for a fee, with added features, do donate back to their root
projects. This generosity is one clear business model for open-source software maintenance.

This model has some conflicts of interests in the form of a donor asking for features to be
prioritized based on their business requirements. Most open-source projects have some kind of
private mailing list or offline meetup where the most frequent contributors decide the trajectory of
the project and brainstorm about the roadmap and longevity of the project. I don't hold any grudge
against maintainers for this kind of non-public discussion, as I don't believe that the public
square is the right place to decide the road map of any open-source project.


# Maintainers Redistribute for a Fee

Now, this type of business model is at the center of the AWS-Elastic dispute. Elastic is the
for-profit company that maintains ElasticSearch, a full-text search engine that is popular in
consumer-facing applications. Most search engines are either running ElasticSearch or running
something very similar to it. This search engine product powers product search in e-commerce
applications, timeline search inside social networks and full-text search in some blogs and
text-based websites.

Amazon Web Services (AWS) is a Cloud computing platform. AWS offers several "Managed services",
services that have considerably lower maintenance costs due to their "managed" nature. These
services are preferred by small software engineering teams as it frees up their time and enables
them to focus on product development and rely on AWS for the maintenance of mission-critical
software like the relational DB at the center of their operation or the search engine that powers
their user's search queries.

The core dispute in the AWS/ElasticSearch episode seems to be the use of the "ElasticSearch" term in
the name of AWS' [managed service](https://aws.amazon.com/elasticsearch-service/). Elastic offers its own products such as [Site Search](https://www.elastic.co/site-search/) and [App Search](https://www.elastic.co/app-search/)
that use ElasticSearch under-the-hood and are sold with convenience features that make it easier to
integrate them into real-world applications real-world applications. The AWS managed service and
some of Elastic's products are competing for the same part of the consumer search market.

A similar product, [Elastic Cloud on GCP](https://blog.google/products/google-cloud/google-cloud-platform-partners-elastic-offer-managed-open-source-search-and-analytics-gcp/), is offered by Google Cloud Platform (GCP), a competitor of
AWS. The key difference between the two managed services seems to be that GCP and Elastic entered
into a partnership, while AWS struck out on its own to create the product that it wanted, without
any consultation with Elastic.

Elastic did not like what AWS did at all. In fact, it annoyed them **so much** that they decided to
_change_ the license that ElasticSearch is distributed under:

> It also protects our continued investment in developing products that we distribute for free and in
> the open by restricting cloud service providers from offering Elasticsearch and Kibana as a service
> without contributing back.
> &#x2013; <https://www.elastic.co/pricing/faq/licensing>

This business model is a dicey one and ridden with conflicts of interest. Elastic was not really
on board with free and open-source software from the get-go, especially if the software was deployed
on a large scale and could possibly poach the market share that it held through its own managed
service products.

The change in license was the right thing to do, as it clarifies their intention behind maintaining
ElasticSearch: The license should embody exactly how the maintainer wants users to treat their
software. Their decision to delay this change this long seems to be based on their false conviction
that few people will be able to _figure out_ how to run ElasticSearch at scale without Elastic's
help or that a competitor with as many existing customers as AWS will not step on their toes, due to
fear of retaliation.

AWS' decision to fork ElasticSearch to continue offering the managed service and a search engine
that is modern and innovative was also the right one. The fork, [OpenSearch](https://aws.amazon.com/blogs/opensource/introducing-opensearch/), has had a good start,
reaching version 1.0 in 3 months. (The project began at a stable ElasticSearch version anyway, so
this might not be as big a milestone as reaching 1.0 is for other projects.) As the two projects
diverge, it will be interesting to see which one outpaces the other in terms of development and new
features.

Elastic has nothing to do but work on ElasticSearch, whereas AWS is a cloud-computing company,
running one service based on this fork. I would like to see AWS succeed in maintaining the fork and
continuing the addition of interesting features long into the future. But the fact that this will
not be their only priority seems like a risk for early adopters of OpenSearch.

Another important question which the product will have to deal with down the line would be whether
they would like to maintain compatibility with ElasticSearch in the configuration and query
language. AWS (the business) would prefer maintaining this compatibility. The project maintainers
might have different opinions in the interest of the future health of the codebase.

---

**Edit 2021-09-15:** As I was editing this post, ElasticSearch [decided](https://github.com/elastic/elasticsearch-py/pull/1623) to update their Open Source
clients to stop allowing connections using their maintained clients to OpenSearch clusters. Amazon
has [forked](https://aws.amazon.com/jp/blogs/opensource/keeping-clients-of-opensearch-and-elasticsearch-compatible-with-open-source/) Elastic's search clients and plans to maintain both the search engine (OpenSearch) and
its clients in several programming languages.

> To give these users a clear path forward, the OpenSearch project will add a set of new open source
> clients that make it easy to connect applications to any OpenSearch or Elasticsearch cluster. These
> clients will be derived from the last compatible versions of corresponding Elastic-maintained
> clients before product checks were added.
> &#x2013; [Keeping clients of OpenSearch and Elasticsearch compatible with open source](https://aws.amazon.com/jp/blogs/opensource/keeping-clients-of-opensearch-and-elasticsearch-compatible-with-open-source/)

Elastic's decision to prevent connections to OpenSearch has increased Amazon's maintenance cost
manifold. I hope that this move does not deter AWS from their open-source software crusade.

---

[^1]: I am using Ubuntu 18.04.5 LTS. I installed it in 2019 when I bought my current laptop and I intend to use the same OS for the remaining 7 years until its End-of-Life.
[^2]: This is a mildly controversial point-of-view within the software engineering community where computers are often equated to Lego sets; installing new operating systems, window managers, upgrading and tweaking with the hardware of your computer is the backbone of the _[hacker mindset.](https://sul.im/blog/a-hacker-mindset/)_
[^3]: Written July 2021.
[^4]: In 2018, the maintainer of the Linux kernel, Linus Torvalds, had a compensation of $619,472 according to a [disclosure](https://projects.propublica.org/nonprofits/organizations/460503801) made by Linux Foundation.
[^5]: Wireguard's in-built mechanisms for connecting computers is technical and it is not easy to walk others through the set-up, while Tailscale relies on easy-to-understand Google and Microsoft accounts and email addresses to connect computers.
