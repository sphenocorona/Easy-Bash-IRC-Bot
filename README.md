easy-bash-irc-bot
============

A simple, modular IRC bot written in bash, based off
[https://github.com/Newbrict/bash-irc-bot.git](https://github.com/Newbrict/bash-irc-bot.git)

Put "modules" into /modules/module-name/module-name.sh
and they will be loaded up during runtime. They can also be edited while the bot runs
without the need to restart the whole bot.

Syntax: ~modulename [arguments]

Also comes with a fun multiplayer word game module 4word,
a game where you change one letter of a four letter word at a time.
The 4word module requires aspell to be installed in order to work.
