---
layout: post
comments: true
title: OpenSSL is extensive and amazing
categories: openssl cryptography command-line
---

Back in August 2017, I hadn't yet dipped my feet into OpenSSL's command line
yet. That's when I ended up finding out about a set of OpenSSL commands that
have a solution for most cryptography related requirements. Secondly, it's a
great way to just explore and find out about new technologies.  So, here's a
list of commands that absolutely floored me when I first found out about them:

## 1. openssl x509

```sh
$ openssl x509 -in ~/Downloads/twittercom.crt -text | less
```

This command inspects x509 certificates from the internet. Firefox has a great
certificate inspector, but for every field, you have to go and highlight it and
then the value for that field will be shown in the bottom. This on the other
hand shows up in gorgeous less and works like a charm! I have learned so much
about TLS just reading the certificates for the top sites that I keep visiting.

For eg: [Basic Constraints][1] and [Moxie's talk about defeating SSL using
it][2].

## 2. openssl rand

```sh
$ openssl rand -hex 40
$ openssl rand -base64 40
```

How many times have you wanted to generate some random bytes quickly? OpenSSL
can do it! I don't know what the distribution of this is, or what it uses as a
seed or any of that, but it just seems to work and that's great!

## 3. openssl s_client

```sh
openssl s_client -connect duckduckgo.com:443 -tls1_2 -showcerts
```

This opens a TLS 1.2 tunnel with the destination site and then allows you to
send some data on this newly created encrypted tunnel. This command also shows
all the options explicitly and lets you inspect each handshake. This was pretty
helpful when I was writing [tls-handshake][3].

## 4. openssl enc

```sh
# the command to encrypt a file
$ openssl enc -in 404.html -out 404.html.enc -k "testing123" -aes-256-ctr
# the command to decrypt the encrypted file
$ openssl enc -in 404.html.encrypted -out 404.html.new -k "testing123" -aes-356-ctr -d
```

This command comes in pretty handy if you want to send a huge file to someone
using something like Google Drive or Dropbox (a vendor that you don't trust to
not look into your data). Put everything in a tarball, encrypt it using AES,
then send the encryption key to the recipient using another channel (such as
[Signal][4]) and the encrypted data using the cloud storage service. I haven't
really gone into it's performance aspects, but it's a pretty cool command.

Of course, you could use the same cloud storage provider to share the key if you
have the public key of the recipient. You could use something like PGP or simple
SSH RSA keys (if they are long enough).

**Bonus:** You can use the `openssl rand` function to generate a secure key
that's a few 100 bytes long and can't be brute forced for the forseeable future.

One of the drawbacks of `openssl enc` is that AEAD ciphers aren't supported in
the version of OpenSSL I have (1.0.2g 1 March 2016) (eg: `aes-256-gcm`). There
is [some][5] discussion on github about this. Also, [this PR][6] that says `enc`
will not support AEAD in the future. It says to look into the [`cms`][7] utility.

[1]: https://tools.ietf.org/html/rfc5280#section-4.2.1.9
[2]: https://www.youtube.com/watch?v=5dhSN9aEljg
[3]: https://www.siddharthkannan.in/tls-handshake/
[4]: https://signal.org/
[5]: https://github.com/openssl/openssl/issues/471
[6]: https://github.com/openssl/openssl/issues/5048
[7]: https://linux.die.net/man/1/cms
