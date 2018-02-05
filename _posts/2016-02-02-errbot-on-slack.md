---
title: Errbot on Slack.
updated: 2016-02-02
---

# Chat Clients
**Slack** is a great chat client. 
It's incomparably better than **Skype**, **Lync**, **Spark** and **Hangouts**
for collaborative teams and developers. 
**[Hipchat](https://www.hipchat.com)** is a contender 
but lacks many great features that 
Slack offers out of the box: saving a conversation context, 
up arrow editing ( like Skype's ), better code snippets, 
completions for IRC-like commands,
 [chat posts](http://slackhq.com/post/130081834025/refreshing-posts-20), 
 pinning messages and files to a chat, etc..

There's also **[Rocket.Chat](https://demo.rocket.chat/home)**
which seems similar to Slack's features on the surface, 
but I have not had the commitment to try it out; it's also open source.

Lets do more cool things with Slack; 
adding a bot and get into **[Chatops](https://www.pagerduty.com/what-is-chatops)**.

# Bots
There are a lot of bots out there for different languages, 
but preferring python, **[Errbot](http://errbot.io/)** was the choice for me.
Errobot integrates with all sorts of things, 
and amazingly simple to integrate with Slack. 
Errbot's [Hello world!](http://errbot.io/user_guide/plugin_development/basics.html) guide is pretty 
useful if you want to use it as a reference. 

# Setting up Errbot
With all python project, set up a **[virtualenv](https://virtualenv.readthedocs.org/en/latest/)** and install these dependencies:

`pip install slackclient errbot`


# Organizing the project
Create a directory structure like so...

```
/wally
/wally/plugins
/wally/plugins/goodbye/goodbye.plug
/wally/plugins/goodbye/goodbye.py
/wally/config.py
/wally/data
/wally/logs
```

It's a bit of work, but I promise the Slack part will be a breeze. 
Now lets see what they folders do.

- **/wally** - this is our bot's top dir obviously..
- **/wally/plugins** - a folder for plugins, each plugin extension should have it's own subfolder.
- **/wally/plugins/goodbye/goodbye.plug** - the plugin's meta
- **/wally/plugins/goodbye/goodbye.py** - the plugin's code
- **/wally/config.py** - configurations for Errbot
- **/wally/data** - local data store files that Errbot uses
- **/wally/logs** - where the logs that Errbot generates will go

# goodbye.plug ( stolen and modified )

```ini 
[Core]
Name = GoodbyeEva
Module = goodbye

[Python]
Version = 2+

[Documentation]
Description = Wally saying goodbye to Eva..
```

# goodbye.py ( stolen and modified )
```python
from errbot import BotPlugin, botcmd
class GoodbyeEva(BotPlugin):
    """A farewell to Eva plugin"""

    @botcmd
    def goodbye(self, msg, args):
        """Say goodbye to this Eva.."""
        return 'Goodbye, Eva....'
```

# config.py
A template of config.py 
can be found here *[config-template.py](https://github.com/errbotio/errbot/blob/master/errbot/config-template.py)*. 
Copy the contents over.

Update these properties in the config, 
the notes in there are great 
if you're interested in the details, 
but the property's names are self-explained.

```
BOT_DATA_DIR = './data'
BOT_EXTRA_PLUGIN_DIR = './plugins'
BOT_LOG_FILE = './logs/log.txt'
BOT_LOG_LEVEL = logging.DEBUG # This will be more useful than the default
BOT_IDENTITY = {} # Comment out the defaults
```

# A Test Run
That should be it! `errbot` should be available as a binary, 
to run it in locally in a chat emulator..

`errbot --text`

Hopefully this should work smoothly 
and should put you in a chat prompt 
where you can run `!help`. 
You should see a help for __GoodbyeEva__ plugin, 
if not go through the logs in the console for warnings and errors; 
unfortunately plugin failures are silent.

# The Slack part
Finally we are here, thanks for sticking around! 
The easiest way to integrate with Slack is to create a **bot user** 
for your team. 
Head over to [Slack's bot user](https://api.slack.com/bot-users) to create a new bot user. 
Once you're done with that, you'll be on the new bot user's page. 
Here all we will need is the _API Token_ under **Integration Settings > API Token**, 
should look something like this **xoxb-1234567890-supersecretpseudorandomstring**.

Alright we got the token we need, 
now back to **config.py** and its **BOT_IDENTITY** property. 
Uncomment the token key under "Slack mode" and add your token here. 
That. is. it. To start it up simple run `errbot` or `errbot --slack`

There's one more thing we need to do, 
add the user bot to a room 
and then you can start interacting with WallyBot, just type `!help`.










