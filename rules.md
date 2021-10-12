AirRobe Scrabble

Objective:

Build a simplified version of the scrabble game using command-line as the user-interface.

Details:

The game pack consists of:
  * A game Board with 15x15 square.
  * 100 tiles in a bag
  * 2 racks (1 for each player) to keep the tiles
  * English Word Dictionary (use this: https://github.com/dwyl/english-words)

How to play:
  * There are 2 player.
  * Each player takes turn to form words in the board using the tiles on their rack.
  * The player gets points equal to the number of letters in the word they form.
  * When the game ends, whoever gets the highest total points wins.

Rules:
 * The board has 15x15 squares and each tile contain a letter. There is no point value on the tile.
 * There is also no modifiers on the squares of the board (they are all the same).
 * Words can be of size 1 or more letters.
 * The words can be formed either by combining with existing letters or on their own.
    Example:
      If the state of a row in the board looks like this:  ____at_______
      You can form another word like this:    ____cat______
      And you get 3 points.

 * The word must exist disconnected from other letters that are not part of the word (ie. the whole contiguous run are considered for the word)
    Example:

      ____sput_______ => not valid word because sput is not a word and there is 's' connected to put
      ____s_put______ => valid for put
      Note: letters connected to the word in other direction(vertically) of the word direction does not matter.

 * Words can be made horizontally as well as vertically.
    Example: vertically placed word 'star'
  ```  
     1 _______________
     2 ______s________
     3 ______t________
     4 ______a________
     5 ______r________
     6 _______________
     7 _______________
     8 _______________
     9 _______________
    10 _______________
    11 _______________
    12 _______________
    13 _______________
    14 _______________
    15 _______________
```
  * However, the direction of word can be only forwards and downwards (not reverse or upwards)

Example of play:
 There are 2 players. Each player get 7 tiles from the bag that they put on the rack.
 Player 1 starts the game by forming a word on the board.

 The word must be a valid dictionary word. Dictionary available at https://github.com/dwyl/english-words
 After the player has placed the tiles, they can get  more tile from the bag to make it up to 7 again.
 The player gets points equal to the number of letters in the word.

 Then it is the next player's turn. They do the same thing.

 The game continues until one of the players cannot form any more words. The player then has to pass.
 The next player then gets 1 more chance to form a word and get points.
 After that, the game ends.
 The winner is determined based on the highest total score.


Example of Command-line UI:

On each turn of a player, show the state of the board like this (does not have to match exactly):

```
     1   2   3   4   5   6   7   8   9  10  11  12  13  14   15
     _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
1  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
2  | _ | C | A | T | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
3  | _ | _ | _ | A | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
4  | _ | _ | _ | I | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
5  | _ | _ | _ | L | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
6  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
7  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
8  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
9  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
10 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
11 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
12 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
13 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
14 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
14 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
15 | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
```
