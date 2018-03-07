---
title: Git in byte size 1 - git add
updated: 2016-02-02
---

{% include series/git.in.byte.size.md %}

Everyone knows `git add .` and `git add -A`. But it's often that I have to add only a selection of files, add a partial of a file, or have unwanted untrack files in my working space. So knowing the different options of `git add` helps with efficiency in managing the files. Here are a list of comamnds that I use most often.

- `git add -u` only stage tracked files, does not touch untrack files. 

- `git add <glob>` stage both untrack and updated files to your index using glob syntax. A few examples:
  - `git add stuff/*` add all of _stuff_ to your index.
  - `git add stuff/*.md` add only `.md` files in _stuff_ to your index.

- `git add -p` __p__ for patch, prompts you with a hunk (a section of code) selector to slice and dice what needs to be staged in a file. When prompted you can type `?` for the help. 

- `get add -e` __e__ for edit, a quicker way than `patching`, a straight edit on the diff so you can apply what you want to staged and what you don't. You can also make changes to the changes.

- `git add -i` __i__ for interactive, a full menu of things you want to do from all the commands above and more. This option is great when you want to be very selective. It also provides a prompt selection for both tracked and untracked files. You'll need to play around with the prompts a bit to get the feel for it. This is the most versatile option for `git add`, since it's mostly everything you'd want to do with `git add`.