*** This README describes some extra features of the game "The Chrysalids" that are not initially or explicitly mentioned to the player, along with how the overall game was implemented. Note that this may contain information that you as a player may not wish to know prior to playing the game. If this is the case, PLEASE STOP READING IMMEDIATELY. ***



Dear Player,

As a disclaimer, I would like to express that a full description of the entire implementation is not feasible, given the amount of code and significant scale of this game. What follows is meant to provide a general idea of what this game has to offer. The entire implementation can be accessed and studied from the source code, though I will assume that you do not have either the right of the time to do so.

The main way in you as the player interact with this game is through the transitions between dialogue mode and action mode. The commands that you as a player type in action mode will determine your fate between advancing forward and reaching a GAME OVER.

You, as the main character of this game, somehow continues to experience a series of deaths and revivals, as you restart from the same time over and over again. However, with the right moves (commands), you may notice some changes in the range of options of commands you can type as you progress forward. It is this addition of options that may eventually lead you to the completion of this game. Keep in mind that this game is designed to be hard enough for you to wonder at times what possible combination of actions will lead you to the next step, given that you do not consult a complete walk-through.

Some of the many notable features of this game include the key commands used throughout the game. "go to" allows you to move to an adjacent location, provided that you are allowed to go to that specific location. "look", when typed without an argument", shows you a number of objects and locations that you can look at from the place you're currently at. When typed with an argument (that corresponds to a listed object or location), "look" describes the thing that you specify as the argument. The "item" command represents an inventory system, in which you can see a list of items you currently possess. From this list, you can choose an item to "use", in which case you are either prompted with a description of the item or entitled to use the item for a specific purpose.

At the beginning of the game, you are prompted to create the name of your main character. (This name can in fact be changed upon "restart"ing the game after reaching either a GAME OVER or a completion of the game.) Reaching a GAME OVER allows you to "retry", "restart", or "quit" the game. "retry" allows you to jump back into the game with some progress saved, while "restart" erases all progress in terms of your advancement through the main plot of the game. Finally, "quit" simply quits the game. Completing the game only enables you to either "restart" or "quit".

Some features that are not mentioned at the beginning of the game include newly discovered objects and places, a timer in one of the action modes, a special mode with a small side plot that can be enabled upon choosing a particular name after beating the game, and an Achievements Unlocked feature. In particular, the Achievements Unlocked feature can be seen by typing a specific command, which you as the player are made aware of after looking at a specific object within the game.

All of these features and functionalities are implemented by the use of a number of mutually recursive functions, boolean and integer variables and flags, while/for loops, and case analysis of command line input (especially in action mode). In particular, the use of variables and flags not only allows you as the player to access different parts of the plot after making some progress even within the same place, but it also sometimes enables you to see different descriptions of objects or actions even with the same commands that you type. For instance, if you talk with the Salmon God in Fresh Grocer, you will be able to notice a reference to the Salmon God towards the end of the game. (If all of these do not make much sense, that is more the reason for you to play the game.)

To reiterate, I am going to deliberately leave out some details for you to figure out, since a significant part of the fun and surprise in this game lies in your own discoveries. Though some parts of the game may seem challenging, and you may feel stuck at certain points within the game, your will to continue and not give up will ultimately open the door for you to the end of the game.

With that being said...

Good luck!



(The "adventure-game-plan" file was used as a worksheet for me to organize my thoughts and figure out the various elements of the game plot and how to implement the entire game. The "adventure-game-functions" file lists all the functions that are used in the implementation of this game. Note that both of these files contain spoilers that you may not wish to see prior to playing the game.)







==================================================

This game, "The Chrysalids", is written completely in Bash, and it is an original work by Jae Joon (JJ) Lee, an undergraduate in the University of Pennsylvania (sophomore in academic year 2014-2015). It is open to improvement or modification at my discretion. Currently, the game is in Version 1.

If you have any questions, inquiries, or even requests, feel free to contact me at jjlee@seas.upenn.edu.

Thank you.