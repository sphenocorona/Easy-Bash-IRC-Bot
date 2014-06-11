# A "Change one letter at a time" game implementation for an IRC bot. Rules on word choices are almost entirely enforced by the bot, while rules on winning are left to the players.

wordhist="wordhist.cfg"

# Get the last word from history
lastword="$(tail -n 1 $wordhist)"


# If "INFO" is given, tell previous word
if [ "$3" = "INFO" ]
then  
  # If there is no previous word, tell the user that there is no currently running game.
  if [ "$lastword" = "" ] || [ -z "$lastword" ]
  then
    echo "PRIVMSG $2 There is no currently running game at this time. Why not make one?"
   
    # Otherwise, display the most recent word
  else
    echo "PRIVMSG $2 Current Word: $lastword"
  fi

else # If a word has been given
  
  # Check to see if the word has capital letters, and if it does...
  if [ "$(echo "$3" | grep -c [A-Z])" = "1" ]
  then
    # If the word is "END" and lastword is NOT blank say that the game has ended and what the last word is, and continue
    if [ "$3" = "END" ] && [ "$lastword" != "" ]
    then
      "" > $wordhist
      echo "PRIVMSG $2 Game Ended. Last Word: $lastword"
      continue
    fi
    # If the word is "HELP" say help stuff
    if [ "$3" = "HELP" ]
    then
      echo "PRIVMSG $2 Allowed arguments: END to end game, HELP to display this, INFO to display current word, and any lowercase four letter word to play!"
      continue
    fi
    
    # If not continuing past this section, tell the player to not use caps
    echo "PRIVMSG $2 Because bash commands are cAse-SensItIVe, please type words in lowercase only. Thanks!"
  else
    
    # If the word has not been used yet, continue checking
    if [ "$(grep -ic "$3" $wordhist)" = "0" ]
    then
      
      # Set patterns to compare new word against
      patterna="[[:alpha:]]${lastword:1:4}"
      patternb="${lastword:0:1}[[:alpha:]]${lastword:2:4}"
      patternc="${lastword:0:2}[[:alpha:]]${lastword:3:4}"
      patternd="${lastword:0:3}[[:alpha:]]"
      
      # If the word is not spelled correctly then notify the user and don't try to use the word
      if [ "$(echo "$(echo "$3" | aspell -a)" | grep -c "\*" )" != "1" ]
      then
        echo "PRIVMSG $2 $1: That word is not in my dictionary."
        continue
      fi

      # If there are no previous words then accept without pattern check
      if [ "a$lastword" = "a" ] || [ -z "$lastword" ]
      then
        echo $3 >> $wordhist
        echo "PRIVMSG $2 $1 has changed the word to $3!"
      else
        # If the word matches a pattern above it is then acceptable.
        if [[ $3 == $patterna ]] || [[ $3 == $patternb ]] || [[ $3 == $patternc ]] || [[ $3 == $patternd ]]
        then
          echo $3 >> $wordhist
          echo "PRIVMSG $2 $1 has changed the word to $3!"
        else
          echo "PRIVMSG $2 Only changing one letter at a time is allowed!"
        fi
      fi
    else
      echo "PRIVMSG $2 Word has been used previously in the current game, please choose a different one."
    fi
  fi
fi
