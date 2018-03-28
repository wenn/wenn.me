---
title: Git in byte size 3 - three way to squash
updated: 2018-03-06
---

{% include series/git.in.byte.size.md %}


# (1) git reset
#### When to use
The simplest. Its purpose is mainly to squash
the current working tree that you're on.

1. `git reset --soft <parent ref>`
2. `git commit`

(1) Place your HEAD of the current tree to the parent ref
and place all changes into the index.

(2) Commit a new message.

#### Caveats

1. You are modifying your current tree. If this is a shared branch
this will cause some pain for other developers.

2. You loose all commit message. Although the `-c`
option of `git commit` allows you to reuse an existing message from
a any commit. e.g. `git commit -c abc123`


# (2) git merge
#### When to use
The safest, since it does not modify your working tree.
One use is to consolidate your topic branch
when its commit messages become unwieldy.

(from the branch to merge onto)
1. `git merge --squash <topic branch>`
2. `git commit`

(1) This will place your topic branch changes in the index
of your working tree.

(2) When you commit, all previous commit messages that has
been squashed are concatenate to one commit message. You
should clean up the merge commit.

# (3) git rebase
#### When to use
The most flexible out of all the methods. When you need
surgical method to squash commits.

1. `git rebase -i <parent ref>`
2. (in prompt) change _pick_ to _squash_ or _s_.

(1) `-i` stands for interactive, using this option with rebase will
prompt you with a list of `rebase` option to perform on each commit.

(2) _squash_ or _s_ will tell rebase
to squash the commit to its parent commit.
Similar to `merge --squash`, your commit messages that have been
squashed are concatenate to one commit message. Make sure you clean
them up before creating a new commit.

#### Caveat
Similar to `reset`, `rebase` modifies the current working tree,
more specifically, it changes the history of the working tree.
