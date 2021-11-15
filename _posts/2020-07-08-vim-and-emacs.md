---
layout: post
comments: true
title: Using Emacs - A trial
categories: emacs editors tools
---

I have been used Vim for a while now. In university, my Vim usage was mostly related to the work I
did in student groups. This probably came out to about 20-25 hours a week, on average. I used it to
write my bachelors and masters thesis in LaTeX, which was probably the smoothest workflow I could
have had for writing something that was about 80 pages long. Once I started working, my usage
increased to nearly 40-45 hours a week. I was writing notes and code in Vim every weekday.

With this increased usage, the problems with Vim really started coming to the surface.

<!--more-->

## Problems

### An inability to understand codebases

I was reading a huge PHP code base at work. I resorted to IntelliJ for PHP because IntelliJ IDEA
really understands PHP code well, I couldn't see how I would move around an unfamiliar code base on
an editor that did not support it well enough. I tried ctags frontends, but they were not sufficient
because switching to the function `getUser` on the line `$transaction->getUser()` using ctags would
_not_ lead to the `Transaction` class inside `models/`, instead going to `ACL::getUser` !?! (I later
discovered that it is possible to switch between tag locations after the first jump; still not
really very syntax aware)

### An inability to do things in the background

A lot of has been said about this. Neovim is one of the popular alternatives that fixes the
problem. I switched over from Vim to Neovim in February. They are basically the same underlying
program, so I didn't notice a drastic change just from this switch.

### Poor handling of nested lists within Markdown

I was writing all my notes in Markdown. This was working well. I had a file for each month and a
heading for each day. Inside each heading, I started taking notes that were nested lists. This is a
sample block that is typical of the notes I was taking: (made up)

```markdown
- Meeting: Some topic 1
	- Feature 1: Are we doing this?
		- Pros
			- Good for cats
		- Cons
			- Bad for cat food
	- Resources
		- New redis cache
		- New microservice?
			- Seems excessive for a prototype
			- Put logic in service A?
				- Service A has too much logic
				- `internal/src/partner/logic.go` => Too much unrelated logic in this file, this has
				already caused a few incidents during release
			- Service B
				- sounds better
				- Traffic is high, no problems in the past few months
	- Technical discussion
		- Cache with TTL?
		```go
		// Write logic
		redis := newRedis()
		redis.Set(key, value, -1) // -1 => No expiry

		// Read logic
		value := redis.Get(key)
		json.Unmarshal(value, &t)
		if time.Now().Since(t.CachedAt) > 5 * time.Minute {
			resp, err := callExternalService()
			if err != nil {
				return t.Response
			}

			return resp
		}
		```
	- Resolution
		- Feature 1 in next sprint
		- Logic in service B for now, move to microservice if prototype is successful
```

After the meeting was complete, I would look through it again and edit it to fix grammar or
indentation and remove redundancies, elaborate things that weren't immediately clear, make sure I
didn't miss anything. After this editing step, I would instinctively use `gqip` to reformat
everything and make it look pretty again. This step would reformat the code block as if it was plain
text! This was clearly a problem. The editor didn't understand that this text is special and
shouldn't be touched when reformatting the text around it.

As I started getting involved in more projects and my notes started becoming more complicated and
the levels of nesting grew, this problem became worse.

## Theory

Vim doesn't understand the text that is being edited.

Think about any language that has a structure which allows identifiers to have the same name but
have different meanings when used with different objects. **Eg:** PHP, Ruby (Inheritance, dynamic
type), JavaScript (types, definitions not required), Markdown (freeform).

Editing these languages in Vim is hard because simple text processing tools are NOT enough. There
has to be a layer on top of the text processing that sits in between the text and the text processor
and tells the text processor how to deal with each line of the text. This layer has the logic that
is required to recognize that a line within a codeblock in Markdown shouldn't be touched or (the
much more involved interference) that the `getUser()` function called on a `Transaction` object is
in `transaction.php`, not in `acl.php`.

On the other hand, take an extremely well-formed language like Golang: It comes with an excellent
set of tools that sit between the text and the editor.

**Eg:**

- `gofmt` => Every time the user asks the editor to save a file, the editor sends the file to
`gofmt` and saves the output instead!
- `gopls` / `guru` => When the user taps `C-]`, the editor passes the cursor location to `gopls` and
loads the file and line, column number that `gopls` returns.

If there were such tools for PHP, I am sure that PHP editing would be just as efficient as Go.

This is not a novel theory, it has been put forth by other people, in other forms. I simply realized
it all over again from my own experience.

**P.S:** [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) is a
great project that aims to solve all these issues! I want to try PHP with it's language server in
Vim and in Emacs. (Emacs with Company in the LSP mode is actually a very powerful LSP frontend)

## Solution (trial)

Switching editors seemed like the easiest solution to this problem. I wouldn't be able to switch
editors quickly; I started looking for alternatives anyway. Emacs stood out as the overwhelmingly
popular and well-loved alternative. There were three talks that convinced me to start this trial:

- [Evil mode: How I learned to stop worry and love Emacs (5 years ago)][1]
- [Emacs Org mode - A system for notes taking and project planning (11 years ago)][3]
- [Getting started with Org mode (4 years ago)][2]

The common thread in all these talks was that the speakers had become frustrated with the tools they
were using and had decided to switch to another tool. They were not making an impassioned argument
for any one tool, they were talking about how inefficient it can be to use the wrong tool. I had
reached a similar point in my experience.

I hope to get used to Emacs enough to be able to use it as my primary editor on local computers. For
remote instances, I will stick to `vi`. My familiarity with the Vim keybindings is quite useful in
this regard.

***

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I have heard a lot about Org mode in the last few months, so I finally opened a test org file and start watching a YouTube talk in another window. it&#39;s markdown on steroids, and extremely well integrated with emacs<a href="https://t.co/bYTQWzt6tc">https://t.co/bYTQWzt6tc</a><a href="https://t.co/cSYYulJyHD">https://t.co/cSYYulJyHD</a></p>&mdash; Siddharth Kannan (@_icyflame) <a href="https://twitter.com/_icyflame/status/1253337750696157185?ref_src=twsrc%5Etfw">April 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Org mode for daily notes is pretty handy (especially if you get bigquery results into Emacs) if you want to quickly calculate percentages and sums! <a href="https://t.co/19MmJlhjp6">https://t.co/19MmJlhjp6</a></p>&mdash; Siddharth Kannan (@_icyflame) <a href="https://twitter.com/_icyflame/status/1253689496488439808?ref_src=twsrc%5Etfw">April 24, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[1]: https://www.youtube.com/watch?v=JWD1Fpdd4Pc
[2]: https://www.youtube.com/watch?v=SzA2YODtgK4
[3]: https://www.youtube.com/watch?v=oJTwQvgfgMM
