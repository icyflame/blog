---
layout: post
comments: true
title: Converting GNUCash's XML file to Ledger's DAT format
categories: gnucash accounting personal finance
---

*Note:* What follows is a meandering account of why I wrote a Perl script to
convert GNUCash's XML file to Ledger's plaintext format. [This script][1] was the
result of this process.

I have been using GNUCash to maintain my personal finances for about 4 years
now, and especially since I started working, I have used a single GNUCash book
for my expenses. Before that, I used to close my accounts every year or half
    year and start a new book. Apparently, this is _not_ the recommended way to
    use GNUCash.

The more I have used GNUCash, the more I have become familiar with the data
entry system. In general, I try to enter all my transactions by saving receipts
and categorizing everything appropriately. If ever I have the feeling that a
particular month or quarter I spent too much on a given category (bought too
many clothes / too much electronics shopping) I pull up the Expense barchart
report that GNUCash has in built support for. The default report is pretty good,
and gives one a good idea of how they are doing with their money.

<!--more-->

### The Ideal Flow

[Ledger][2] came across my radar when I was researching for alternative tools that
automate the entry process. In particular, the flow I had in mind was this:

1. Right after the transaction, enter the transaction in my phone into a note or
send an email to myself
1. Some cronjob takes these emails and converts them into a file that GNUCash
can parse
1. Import this file into GNUCash at the end of each week

This might have been too ambitious, because I couldn't find one easy to import
format for GNUCash. I wanted some convenience features too. The major one was
"Transaction Aliases":

`CC F L RA 500` => Lunch at Restaurant A, 500 Yen,
                => Debit from credit card, Credit to Expenses:Food:Lunch

This was definitely not part of the MVP that I was envisioning, but I wanted to
be able to build this at some point in time. I even dreamed up a fictional DML
that would support both aliased transactions _and_ new transactions. I am sad to
say though that none of this ever became reality.

### Well, what did become reality then?

A script that converts the GNUCash's XML formatted file into the file format
that Ledger accepts as input. (A text file which commonly has the extension
`.dat`)

Ledger is a very interesting project. It attempts to be a complete accounting
and finance monitoring tool (which can be used even by enterprises which have
complex transactions) that's based completely on a single text file.

- There is a DML that defines transactions
- There are no database type "IDs" that are attached to accounts or commodities
- Every time you run Ledger, the whole file is parsed
- Ledger doesn't control the data entry. That is, you can enter data however you
  wish. You can export data from GNUCash to Ledger, or from a spreadsheet to
  Ledger, or write the Ledger entries by hand (very painful) or generate it from
  other structured format using a script

All Ledger cares about is that **your DAT file should have a bunch of
transactions, and these transactions must balance**.

Now, if the DAT file has a set of transactions and they balance, then Ledger can
generate a variety of reports for you. This is where things get interesting.

(A little bit of accounting knowledge from a complete beginner) There are three
accounting reports that you will find on every single company's quarterly
earnings reports. Apparently, these reports are big deals and tell everything
one needs to know about the "financials" of a company. I don't know much about
why or how to read one and learn new information. I did want to generate these
three for my own personal finances though.

Ledger lets you do this extremely easily.

```sh
hledger -f simple.dat balancesheet
```

This prints a plaintext balancesheet. It lists all the assets that you have
(bank balances, cash, stocks) and all your liabilities (credit card outstanding,
loans). I found my balancesheet to be rather interesting. I didn't learn
anything particularly new, but it was a fun project.

### Why Perl though?

Perl has a pretty good XML parsing library. I have also read a bunch of blog
posts that say that Perl is the best language for massaging text and moving it
from one format to another format. I wanted to use Perl for a real world project
and see what advantages it had and whether I would be able to really use it on a
daily basis without having to look at `perldoc` every 10 seconds.

I did't really get too far with my actual Perl expertise, but I did learn a few
great things about Perl itself. Such as the difference between scalars, arrays,
hashes and references. And how Perl understands what context a variable is used
in (i.e an array's length is used if you compare it against 0 inside an `if`
clause)

In conclusion though, I wanted to try a new scripting language and this seemed
as good a project as any other out there.

[1]: https://github.com/icyflame/gnucash-xml-to-ledger-dat
[2]: https://www.ledger-cli.org/
