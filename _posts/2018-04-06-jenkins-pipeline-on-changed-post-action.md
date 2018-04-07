---
title: Jenkins pipeline - "on changed" post action
updated: 2018-04-06
---

Post actions in Jenkins job allows you to respond to success and failures of a build.
With _Jenkins Pipeline_, the post action is written as code, instead of your traditionally
_Post Build Action_ for a free style job. There's a bit of confusion to it since _Jenkins
Pipeline_ supports two ways of writing pipeline code: [Declarative][declarative] and [Scripted][scripted].

Even their docs can be a bit off, which throws more confusion into the mix.
As I am crafting this post, their current version __2.107.1__,
does not support __fixed__ or __regression__ conditions for __post__ actions. However, these
conditions are documented in their docs.

TLDR; you can view the working examples in my [DRYing the pipline][dry-pipeline] project.
There, you can find a pre-configure Jenkins container with the examples.

### Declarative Pipeline

```groovy
def hasChanged = false

pipeline {
    agent any
    stages {
      ... your awesome pipeline code ...
    }
    post {
        changed {
            script {
                hasChanged = true
            }
        }
        success {
            script {
                if(hasChanged){
                    currentBuild.displayName = "back to normal!"
                }
            }

        }
        failure {
            script {
                if(hasChanged){
                    currentBuild.displayName = "became broken...."
                }
            }
        }
    }
}
```

__Declarative__ is intuitive and easy to read. The __post__ directive
handles the post conditions for the pipeline. For each _conditions_, simply define
the logic you need, either by using groovy script or using the pipeline's dsl.

The "on changed" behavior is triggered by toggle of the `hasChanged` in the __changed__ condition. Other
conditions uses this flag to determine if they need to proceed.

### Scripted Pipeline

```groovy
def successful = currentBuild.getPreviousBuild().result.toString() == "SUCCESS"
def success = true

try {
    node {
      ... your awesome pipeline code ...
    }
} catch (exc) {
    success = false
    throw exc
} finally {
    def changed = successful ^ success

    if(changed && success) {
        currentBuild.displayName = "back to normal!"
    } else if(changed && !success) {
        currentBuild.displayName = "became broken...."
    }
}
```

With __Scripted__ pipeline syntax, most of the work is done in groovy.
Starting with the `try/catch/finally` block, we handle all of our fail and success conditions here
using the `success` flag. Defaulting it to `true` and setting it to `false` in the catch;
don't forget to `throw` to bubble up the exception.

The `changed` flag is set by `xor`ing the previous build's status with the current value of the `success` flag.
If they are exclusive, then the status have changed and we can delegate the work accordingly in the
`if/else if` statement.

[declarative]: https://jenkins.io/doc/book/pipeline/syntax/#declarative-pipeline
[scripted]: https://jenkins.io/doc/book/pipeline/syntax/#scripted-pipeline
[dry-pipeline]: https://github.com/wenn/dry-pipeline

