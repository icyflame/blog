---
layout: post
comments: true
title: Ongoing issue with Firefox add-ons due to an expired certificate
categories: mozilla firefox add-ons certificates openssl incidents
---

**Note:** This is an ongoing issue at the time of writing (19:30 2019-05-04
        JST). The team at Mozilla is aware of this issue and is working hard to
fix it as soon as they can. You can track the bug [here][1] and on the IRC
channel `#firefox` on `irc.mozilla.org`.

## Detection

The issue started around 6 pm PST on the 4th of May when some people noticed
that their add-ons were disabled by the browser, though the add-ons were working
just fine just a few hours ago. (Some people had theirs stop working during on
        ongoing session!) This led to the opening of a [GitHub issue][2] and a
bug on Mozilla's bug tracker for Firefox, [Bugzilla][3].

I ran into this as soon as I woke up this morning and opened my work computer to
start my on-call shift. I didn't know I had a pretty interesting on-call session
in front of me. On a 12-hour on-call shift, I didn't have much to do anyway. So,
   I ran through what the issue was, how it started happening, and what people
   are saying about it.

**Sidenote:** I set up IRSSI because it felt like a lot of the discussion was
happening on IRC and _not_ on GitHub or bugzilla (mainly because the developers
        inside Mozilla locked the GitHub issues and restricted who could comment
        to keep those channels clear; as more and more people started to figure
        out that what they were running into didn't have an easy fix, these
        pages would only have started getting more polluted and the main problem
        would have become harder to find)

IRC was filled with a bunch of people who were talking about where the issue
started and why it was allowed to happen. One of the most common threads of
conversation was: "This feels like we are using a product built inside a walled
garden". Firefox devs continued to tell the world that they knew about the
problem and were working hard to fix it but what this fix was and how they were
approaching it was not clear to anyone on IRC.

As for the issue itself, one look at the title clarified what it was:

> All extensions disabled due to expiration of intermediate signing cert

Let's delve into what exactly this means!

## Mozilla Add-on signing

Mozilla has a great wiki on [how they sign add-ons][4]. The add-on submission
process goes like this:

1. Developer submits a plaintext XPI to Mozilla Addons
1. Mozilla analyzes this XPI for security vulnerabilities
1. When approved, Mozilla signs this package
    1. Mozilla has a root CA certificate that's shipped with the browser (R)
    1. Mozilla has an intermediate certificate that's used for add-on signing
       (I)
    1. Mozilla derives a new certificate from this intermediate certificate -
       the end-point entity certificate (E)
    1. Mozilla signs a file with cert E
    1. The package is shipped with this signature (from cert E), the cert E, and
       the cert I.
1. After downloading an add-on, the Browser verifies this signature:
    1. Verifies that the signature was made by cert E
    1. Verifies that the cert E has a valid chain back to the root cert
    1. Verifies that the files match what was signed (using a bunch of hashes)

Our current problem: **The intermediate certificate, cert I, has expired!**

Now, the certificate itself is available in every single add-on, and can be
inspected. So, that's exactly what I did.

### The Certificates

To get a certificate, you must get an add-on package; I chose uBlock because
that was the first thing I noticed when I was looking for one.

1. Get the XPI for any add-on
1. Unzip this xpi file using `unzip -d extension`
1. The signature is inside the file `META-INF/mozilla.rsa`
1. Use `openssl` to inspect the certificates!

```sh
$ openssl pkcs7 -in META-INF/mozilla.rsa -inform DER -print_certs -text
```

You can find the output of this for the uBlock extension [here][6].

These lines inside the intermediate certificate (second certificate in the
        certificate chain are the culprit of the present issue):

```
Data:
    Version: 3 (0x2)
    Serial Number: 1048580 (0x100004)
Signature Algorithm: sha384WithRSAEncryption
    Issuer: C=US, O=Mozilla Corporation, OU=Mozilla AMO Production Signing Service, CN=root-ca-production-amo
    Validity
        Not Before: May  4 00:09:46 2017 GMT
        Not After : May  4 00:09:46 2019 GMT
    Subject: C=US, O=Mozilla Corporation, OU=Mozilla AMO Production Signing Service, CN=signingca1.addons.mozilla.org/emailAddress=foxsec@mozilla.com
```

The validity of the intermediate certificate ended today. The actual expiry
was about 1 hour ago, but this issue has been on going for nearly 9 hours now,
    so I don't know what that is about. Hopefully, we get a post mortem from
    Mozilla once the issue is fixed and we can all find out exactly what the
    issue was!

## The Solution

I haven't worked with CA and certificate systems for quite a while now. But as
far as I can tell, this is the solution that comes to mind:

1. Issue a new intermediate certificate
1. Re-generate and re-sign all add-on packages
1. Upload these new add-on packages with the signature to AMO
1. Get everyone to download the extensions again OR release a special patch to
   the browser which downloads the add-ons again for you.

Interestingly, Mozilla was able to release a work-around for people who didn't
have their add-ons disabled. They said they did that [here][7]. One of these
users was on IRC and they shared their certificates for the `uMatrix` extension
[here][8]. These still expire at the same time. So, Mozilla was able to find
some sort of quick workaround which helped them make browsers ignore the results
of the add-on verification test.

**Edit:** I was enlightened by a user on IRC that the fix they deployed was a
Study. These can be seen inside `about:studies` and this particular hotfix is
called `hotfix-reset-xpi-verification-timestamp-1548973`! Nifty!

**P.S.** I wrote a post a few months ago about how cool `openssl` is! I was finally
able to use it in the wild with this issue! Check out the post [here][5].

[1]: https://bugzilla.mozilla.org/show_bug.cgi?id=1548973
[2]: https://github.com/mozilla/addons/issues/978
[3]: https://bugzilla.mozilla.org/show_bug.cgi?id=1548983
[4]: https://wiki.mozilla.org/Add-ons/Extension_Signing#Algorithm
[5]: https://blog.siddharthkannan.in/openssl/cryptography/command-line/2018/05/25/openssl-is-awesome/
[6]: /public/data/mozilla-add-on-issue-cert-details
[7]: https://twitter.com/mozamo/status/1124569680662777856
[8]: https://clbin.com/PgEOF
