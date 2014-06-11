echo "PRIVMSG $2 :$1: The available modules I have are:"
output=$(ls -x modules/)
echo "PRIVMSG $2 :$output"
echo "PRIVMSG $2 :For help with using modules type /PRIVMSG $nick ~syntax"
