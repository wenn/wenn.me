---
layout: page
title: Projects
---

### [Battlestation][battlestation]
Setup a fresh development machine with [ansible].
Installs developer tools and manage your "dotfiles" configurations.
For example:

- installs [chrome]
- installs [tmux] and manage _.tmux.conf_
- installs [vim] and mange _.vimrc_
- manage _.bash\_profile_ and _.bashrc_


### [AWS EMR chat notifications][aws-emr-alert]
AWS Cloudwatch **->** AWS Lambda **->** Chat

Hook up AWS Cloudwatch events on your EMR cluster and send success and
failure notifications to your chat. Currently only support Cisco Spark.


### [Swing][swing]
Swing between folders using their names.

`cd ~/world/where/is/it?/hmmm`

`cd ~/world/is/it/here?/hmmm`

`cd ~/work/project/maybe/here?/hmmm`

or

`swing hmmm`

### [Penny][penny]
Visualize how you spend. ( under construction ).

### [git hooks with python scripts][py-git-hooks]
Old project, needs work. Manage and organize git hooks as python scripts in your project.

[penny]: https://github.com/wenn/penny
[py-git-hooks]: https://github.com/wenn/py-git-hooks
[aws-emr-alert]: https://github.com/wenn/aws-emr-alert
[swing]: https://github.com/wenn/swing
[battlestation]: https://github.com/wenn/battlestation

[ansible]: https://www.ansible.com/
[tmux]: https://github.com/tmux/tmux/wiki
[vim]: https://www.vim.org/
[chrome]: https://www.google.com/chrome/
