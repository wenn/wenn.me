---
title: Git in byte size 2 - git commit
updated: 2016-02-02
---

{% include series/git.in.byte.size.md %}

`git commit`, fairly straightforward. 
There's not much going on here except for when you need to commit your staged changes. 
Most people will probably use one of these variations:
- `git commit` ( [preferred](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53))
- `git commit -m 'a quick commit'`
- `git commit -am 'a quicker commit'`.

Looking deeper into `git commit --help`, you'll find these notable options that could come in handy.

- `git commit <unix style file path>` bypass `git add`'ing a file or files.
- `git commit --patch` shorthand for `git add --patch <file/s> && git commit`
- `git commit -F <file>` allows the commit message to be constructed from a file or use `-F -` for _stdin_. This is useful if the summary and details of the fix is already documented in a Jira or ticket? A workflow for _macos_, is to copy the desire text from the ticket, then using `pbpaste | git commit -e -F -` to construct the commit.

Putting it all together. `pbpaste | git commit -e -F - ./` will: let you edit the commit in place, use what you've copied as the default message, and add tracked files in _./_ to the index for the commit.