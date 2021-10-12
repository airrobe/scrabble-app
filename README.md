# Scrabble

This is an skeleton implementation of a simplified version of the game Scrabble, following the rules [here](rules.md).

## Running

### Running with Docker

A Dockerfile has been provided so you don't have to install this application before running it. Simply run:

```
docker build -t scrabble .
docker run -it scrabble
```

### Running locally

Using your favorite ruby installer, install the correct ruby version (indicated by the .ruby-version file provided). I use `ruby-install`:

```
ruby-install ruby-2.6.5
```

Make sure you're using the correct ruby version before proceeding:

```
ruby -v
```
Using a ruby switcher helps, I use [chruby](https://github.com/postmodern/chruby).

Once you make sure you're on the right ruby version, install bundler:

```
gem install bundler
```

And then install scrabble:

```
bundle install
```

The application can then be run by running:

```
bin/scrabble
```

## Playing the game

The available commands when playing are:

- `pass` to pass your turn
- `row,column word direction` to place word at coordinates row,column in direction. Examples:
  - `1,3 cat horizontal`
  - `6,6 dog v`
- `exit` to stop playing the game

## Running tests

You can run all the tests by running:

```
bundle exec rspec
```

## Assumptions

The 100 tiles in the bag obey the distribution from the Hasbro [official rules](https://scrabble.hasbro.com/en-us/faq). The original rules include 2 blank tiles which we won't be using, so an extra 'A' and 'O' tiles are added, since they were among the most common letters already, in order to get the 100 required by the problem description. 

Assume that the first player can start placing their initial word anywhere on the board, instead of on the center of the board as in the official Hasbro rules.

## About this implementation

### Specifying a move

The way a player specifies a move in this game deserves some explaining. Let's assume the current state of the board is:

```
     1   2   3   4   5   6   7   8   9  10  11  12  13  14   15
     _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
1  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
2  | _ | C | A | T | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
3  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
4  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
5  | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ | _ |
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

And that player one has the following tiles in his rack: `['A', 'I', 'L', 'E', 'D', 'C', 'O']`. The player wishes to form the word "tail", vertically from the end of the word "cat" that is already on the board. They specify that move like this:

```
1,3 tail vertical
```
The player specifies the whole word that they want to place, including letters that are already on the board, and the coordinates on the board where to start the word from.
We chose this approach as a less time consuming way than having the player specify a coordinate for each letter that they want to place; instead, they specify just the starting position. Only those letters that are not yet on the board should be taken from the player's rack when they play a word like this.

Note that the direction can be abbreviated, so the same command could've been issued as:

```
1,3 tail v
```
