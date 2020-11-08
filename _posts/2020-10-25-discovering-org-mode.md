---
layout: post
comments: true
title: Discovering Org Mode
categories: org-mode emacs editors vim markdown
---

I talked about some of the [problems with Markdown](/emacs/editors/tools/2020/07/08/vim-and-emacs/) that I was facing in my daily note-taking at work
and at home. I had been looking for a replacement for my note taking system since early this
year. Org mode seemed like a good candidate and a few people recommended it to me, so I started
using it.

Now, I have used Org mode for about 6 months at work and at home. In my personal life, I managed the
move to a new apartment and switching to a new mobile phone provider entirely using a single
sub-tree in my notes file. At work, I have used Org for a few months now as I worked on a variety of
Search and SRE tasks; a lot of them included huge files and ad-hoc Perl scripts which were written
almost entirely within Org and are still stored only inside Org. This post is about my experience
with Org mode and a list of the things that I believe are the strengths and weaknesses of this
markup language.

<!--more-->

<a id="org4edb750"></a>

# What is Org mode?

Org mode is a major mode for Emacs. A major mode is like a filetype in Vim. It has a bunch of
special formatting logic and functions that only work in that mode. Emacs is always in a major mode.

Org mode also refers to the mark-up language that can be written within this major mode. This
mark-up language is a lot like Markdown if you look at the plaintext. For example, here's a quick
sample with some common things that markup languages can do:

```text
* Title
** Subtitle

Normal, *bold* and _emphasised_ text.

- Lists
- look
- the
- same
  - even with indentation
  - and list items with embedded code are dealt with properly
	#+BEGIN_SRC php
	public function getID() {
		return $this->id;
	}
	#+END_SRC

| Tables | Look |
|--------+------|
| The    | Same |
```

As the markup is similar to Markdown, it's extremely easy to switch to Org <span class="underline">from</span> Markdown. In fact,
you don't even need to think a lot about whether you are writing Org or Markdown except for headings
where the character changes from `#` to `*`. So, there's nothing particularly special about the
markup language.

Opening this file in Emacs won't be very impressive either:

![1](/public/img/discovering-org-mode-1.png)

The file looks slightly better; this is only stylized Markdown though.

Org mode really starts differentiating itself is when you start editing it. Here's my quick, 3-part
pitch to get people intrigued and try it at least once:

1.  **Lists:** Org mode (the layer of code sitting between the plaintext and your editor) inherently
    understands your list. So, when you type `Alt + Return`, it will create a new list item.

    -   If you are in a numbered list, it will check the numbers of all your list items from the top and fix any

    discrepancies

    -   `Alt + Up arrow` will move the current list item up; once again, if you are in a

    numbered list, the numbers will automatically be adjusted for all list items at that level

    -   If the list item you are moving has child items, they will also be moved alongwith the parent
        item!
    -   **Editorial note:** I was writing this blog post in Markdown, but the nested list item that I
        was trying to create using `Alt + Right arrow`, didn't have any effect. So, I copied the text
        over to an Org file and pasted it as is. After doing that, I just had to do `Alt + Enter` to
        align the list items and start editing the text as Org mode text.
2.  **TODO list management, heading filtering:** A common notes file has a lot of heirarchy and notes
    at several levels. Some of these notes will be TODO items that need to be done, or were done in
    the past. Org mode has in-built management of these lists using plaintext markers.
    -   Like other TODO management software, there are a lot of ways to visualize the things you need to do
    -   There are even some features that allow you to schedule TODOs in the future and then look at
        your day's agenda (I have started using this feature recently)
3.  **Tables:** Tables automatically align when you press Tab. I have not seen any application except
    Emacs which can do this so well. There are several GUI applications which can do this well, and
    theoretically, you can run them in Vim mode and get the same result.


<a id="org6a94b39"></a>

# Strengths

I thought about what I wanted to put here for a while. I finally decided to put the features of Org
that I use daily. Org can do a lot of other crazy things but I have found that I don't use them as
much. (**For eg:** Org tables have a spreadsheet like feature which allows you to write formulas, but
LibreOffice's Calc blows this out of the water. So, I did not use that feature as much within org)


<a id="org08d0609"></a>

## Lists, Tables, TODOs

Like I said above in my quick pitch, Org mode understands Lists and Tables. By understand, I mean
that it understands Lists as computers understand arrays. For eg, it knows that the top element
can't be moved above it's current position because it's already at index 0! For sublists, it has
(probably) something like a pointer inside it which lets it know that when the parent pointer is
moved up, the sublist should also move.

This understanding of lists allows it to do things like change the leading character of a list to
anything that you want with a simple keybinding (`Shift + Left/Right arrow`). A program like Vim is
working with Lists using regular expressions. These expressions are bound to run into corner cases
which will be fixed with a more granular Regex &#x2026; <span class="underline">ad infinitum</span>. My most common use-cases for
lists:

-   List of PRs for a given feature (the order in which they need to be merged, etc)
-   Release plans (say: to be shared for review)

**Note:** Org mode is pretty good list numbering tool. If you have a list of lines with content that
you would like to number for some reason, you can do this by prepending the whole list with `1.` and
then using Org's "Fix list" bindings (`Shift + Right/Left`) to number the list properly!

With tables, this behavior is pushed even further as Org behaves with tables almost like any
Spreadsheet software. It is better than them, in my opinion, because of it's ability to quickly
change the width of all columns based on the content. With spreadsheet software, one would have to
use the mouse and extend the column manually. All of this done with the `TAB` key: Type `| CONTENT |
CONTENT | <TAB>` and a table is started and each column is the width of the column with the longest
content.

With Vim keybindings, adding a column is done by simply highlighting the table and using block
editing (`Ctrl-V`) to append or prepend a `|`. My most common use-cases for tables:

-   Pros/Cons list when comparing options / designs / implementations
-   Use-cases for a given feature
-   Comparing various external libraries/services

I have also often converted between lists and tables:

**From:** `<CONTENT>: <VALUE>`
**To:** `| <CONTENT> | <VALUE> |`

This is fairly easy if the list is not nested. As tables look better, there's a constant temptation
to express information properly as tables, rather than lists.


<a id="org5a03ed1"></a>

## Embedding code

```text
#+BEGIN_SRC php
$ docker run -it --name=php php:latest php -a
Interactive shell

php > $password = "t";
php > $h = password_hash($password, PASSWORD_DEFAULT);
php > echo $h;
$2y$10$F6exUnYVDd.W4DSs0I8fdOssGPdj57L3pvmjef5oHEg8qdoahTONS
php > var_dump(password_verify($password, $h));
bool(true)
php >
#+END_SRC
```

The markup for embedding code is verbose in Org. It consists of `#+BEGIN_SRC` and `#+END_SRC` along
with the language of the code that is embedded. I am still trying to figure out if there is some way
to embed using Markdown's `` ``` ``. Looking past the markup, this code renders with the proper syntax
highlighting for the embedded language. So, within an Org file, you can have code from any language
and it will all be highlighted according to <span class="underline">that</span> language's highlighting rules.

When exporting to PDF or Markdown, the embedded code is also exported as expected. I have had some
issues with several embedded code blocks that follow one another though.


<a id="org32b2109"></a>

## Exporting to Plaintext / Markdown / ODT / Docx

I work in a company with a few different platforms for sharing information. We use Slack,
Confluence, Jira and Google Docs. There is no underlying reason for the tool that will be used in
any given meeting or project and it often varies depending on the people that I work with.

This gives rise to the need for a documentation tool that will export to all of those formats. Here,
Org mode blows Markdown out of the water. Exporting out to another format is a first-class feature
in Org mode. There are some really good exporters that are included by default. Of these, I have
found Plaintext and Docx to be the most portable!

**Note:** Docx files can be created using Org's ODT export function. ODT is used as an intermediate
format. The `.docx` file can be imported into Drive and opened using Google Docs. Google Docs now
has a dedicated "Docx"-supported mode which allows you to collaborate and edit a Docx file!

Org's lists and Tables can be copied as is and pasted into Slack or Confluence in their code blocks
section. They look good on any screen that's not a phone screen! This allows you to export without
any other tool, by simply copying the markup.

For more involved exporting (like text with Embedded code), I use the Plaintext export to get a
UTF-8 buffer which I can copy and paste into Confluence / Jira / Slack's text snippet or embedded
code markup object! The plaintext that comes out of the Embedded code is particularly good
looking. Embedded code is wrapped on the left with a box made of `-` and `|` characters!

**Testimonial:** When I shared my notes from an important internal HR meeting widely as a plaintext
snippet on Slack, one coworker sent this message to the channel:

> Your notes are beautiful.

I have shared notes written in Markdown several times before this, but I have never gotten this kind
of a message! Clearly, the plaintext export is generating very good looking files. ([This](/public/data/discovering-org-mode-example.txt) is the
file generated when I exported to UTF-8 plaintext from [this example Org file](/public/data/discovering-org-mode-example.org.txt).)


<a id="orgf55df97"></a>

# Weaknesses


<a id="org02abef9"></a>

## Single notes file

I have been using Org mode for about 6 months now and perhaps the most annoying weakness for me is
that I have put all my notes in a single file. Now, due to Org's intuitive hierarchical structure,
it will be extremely easy to move the notes to separate files by project. But I have not yet figured
out how to get Org mode to search across several Org files. For now, as all of my notes are in a
single file, I have to be extremely careful about destructive actions that I take within this
file.

I have a script which commits to Git every 15 minutes. I started doing this after I lost about 20%
of my notes file during a bad edit in which I deleted a `...` block. When I deleted it, I had no
clue that this ellipsis represented a block of Org and was not just something that Org added to my
underlying text file. I am still trying to control my instinct to delete lines that have only an
ellipsis.


<a id="orgc079228"></a>

## Strange export behavior

There are some "properties" which can be set on every title / heading. These including some useful
ones like `EXPORT_TITLE` and `EXPORT_AUTHOR`. Unfortunately, I haven't really gotten them to work
properly until now. Often, when I am trying to export a single title, it will not use the
`EXPORT_TITLE` that is provided in the heading and instead use the title from the file's properties!

These Export properties are probably being used by the actual driver which handles the export from
Org mode to the appropriate format. So, some drivers do handle this properly, whereas some don't!
(__For e.g.:__ `EXPORT_OPTIONS` is a common property which can be used to turn off
subscript/superscript support (useful when writing notes with variable names) and turn off the Table
of contents (useful when exporting to Plaintext); this property doesn't work with the Plaintext
exporter)
