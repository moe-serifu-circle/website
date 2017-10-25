---
title: "Website Is Live"
date: 2017-10-25T07:22:58-05:00
authors: ["Rebecca C Nelson"]
tags: ["static-sites", "hugo", "development", "golang"]
categories: ["news"]
---
As of today, the Moe Serifu Agent project website has gone live! We are now up
and running at the oh-so-cute .moe TLD, and with our new URL we now have a place
to slap on project promotions. We're now going be jumping right in to that as
we launch our first promotion campaigns. Just in time, too; we have our first
recruitment presentation tomorrow!<!--more-->

Development on the website really started on July 4th of this year, but between
college graduations, relocating for work, and just plain life happenings, it's
been hard to dedicate the time needed to create the site. If we had had the time
to sit down and plug away at it all at once, it would have only taken 2 weeks;
at least, that's the total of all logged hours on website implementation.

At first glance, even 2 weeks feels like a long time to build a website. The
reason it took so long is because we decided to build it as a static site using
the [Hugo](https://gohugo.io/) engine, and it took time to build up the
experience for that. It's not a difficult engine, but I personally found it took
some time to get used to its opinionations, especially coming from a background
of ASP.NET with MVC. Hugo is just similar enough to Razor that I kept reaching
for the old familiar paradigms, when really I had to take a step back and see
how Hugo does it.

That said, the documentation for using Hugo is still a bit on the sparse side;
it's very simple to get up and running with a site that follows the formats they
show off in the initial tutorials, but I found it hard to really delve deep into
why things were working the way they did.

I should also point out that I was also a newcomer to
[golang](https://golang.org), which Hugo depends on. As I understand it, Hugo's
templating system basically just differs to golang's
[html/template](https://golang.org/pkg/html/template/) module, and it's a bit
tricky to get used to reverse polish notation in a site's templates! Once I did
get used to it though, writing long function chains felt very natural. Though of
course, I try very hard to avoid long chains in templates whenever possible.

It's also worth noting that since it's not Hugo that defines the templating
syntax, much of the 'missing' documentation on the syntax itself can be found on
the golang documentation pages, which the Hugo pages mention.
