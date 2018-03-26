---
layout: page
title: Projects
---

### [Battlestation][battlestation]
Setup a fresh development machine with [ansible].
Installs developer tools and manage your "dotfiles" configurations.

Examples:
- installs [chrome]
- installs [tmux] and manage _.tmux.conf_
- installs [vim] and manage _.vimrc_
- manage *.bash_profile* and _.bashrc_


### [AWS EMR chat notifications][aws-emr-alert]
AWS EMR Cluster status notifications to your chat.

Works with AWS Cloudwatch, AWS Lambda and AWS EMR to send success and
failure notifications to your chat. Currently only support Cisco Spark.

AWS Cloudwatch **->** AWS Lambda **->** \*Chat

### [DRYing Jenkins Pipeline][dry-pipeline]
Jenkins playground with examples of Pipeline's shared library and how to configure them.

```groovy
@Library('wen') _
import org.wen.LibraryClassWithStep

node {
    /** (src) Library class usages */
    LibraryClassWithStep.goodbye(this)

    /** (vars) Global variables usage */
    onError {
      sh "ls dir_does_not_exists"
    }

}
```

### [Swing][swing]
Swing between folders using their names.

`cd ~/world/where/is/it?/awesome_project`

`cd ~/world/is/it/here?/awesome_project`

`cd ~/work/project/maybe/here?/awesome_project`

or simply:

`swing awesome_project`

### [git hooks with python scripts][py-git-hooks]
Old project, needs work. Manage and organize git hooks as python scripts in your project.

[penny]: https://github.com/wenn/penny
[py-git-hooks]: https://github.com/wenn/py-git-hooks
[aws-emr-alert]: https://github.com/wenn/aws-emr-alert
[swing]: https://github.com/wenn/swing
[battlestation]: https://github.com/wenn/battlestation
[dry-pipeline]: https://github.com/wenn/dry-pipeline

[ansible]: https://www.ansible.com/
[tmux]: https://github.com/tmux/tmux/wiki
[vim]: https://www.vim.org/
[chrome]: https://www.google.com/chrome/
