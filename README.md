# Chess

<p align = 'center'>
  <img src="assets/gifs/demo.gif" width="830">
</p>

##### <p align ='center'>A demonstration of the shortest stalemate<br>(https://www.chess.com/forum/view/game-showcase/the-shortest-stalemate)</p>

---

## Description

This is a game of chess that can be played on the terminal by two human players.

The project's development incorporates a large portion of the concepts that I have encountered while studying object-oriented design with Ruby, along with some additional tricks that I have picked up since the beginning of this undertaking.

---

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Tests](#tests)
- [Reflections](#reflections)

---

## Installation

There are a couple of ways to run the software:

1. The first one is to visit the [online live preview](https://replit.com/@royojeda/chess). Once there, simply click the `Play` icon or the `Run` button.

2. The other option is to clone the repository to your computer by running the following command in the command line (you must have **Git** and **Ruby** installed):

   ```bash
   git clone git@github.com:royojeda/chess.git
   ```

   and then run:

   ```bash
   cd chess
   ```

   to enter the project directory, and finally, run:

   ```
   ruby lib/main.rb
   ```

   to get the application running.

The live preview method is easier, but the local clone method has better performance (i.e., less stuttering).

---

## Usage

### Loading a save file

As you run the application, there will be a prompt to decide whether or not to load a saved game.

<img src="assets/images/load.png" width="830">

A sample save file is included in the repository, but you can also save your game at the start of every turn for later continuation.

If unsure, simply enter `n` to start a new game.<br><br>

### Turns

As with any standard game of chess, White moves first.

The current player is now asked for the location of the piece that they want to move.

<img src="assets/images/piece_prompt.png" width="830">

The possible move(s) for that piece are highlighted, and a second prompt asks for a location to which the player wants to move the selected piece.

<img src="assets/images/moves_highlight.png" width="830">

Finally, the move is executed, and the other player begins their turn.

<img src="assets/images/move_execution.png" width="830">

The locations are expected to be entered in [Algebraic Notation](<https://en.wikipedia.org/wiki/Algebraic_notation_(chess)>).<br><br>

### Saving the game

Instead of selecting a piece, the player can also enter `save` at the start of every turn to save the current game conditions to a file that can be loaded in later.

---

## Features

Aside from those shown above, here are some other things that the application can handle:

- [Castling](https://en.wikipedia.org/wiki/Castling).
- [En passant](https://en.wikipedia.org/wiki/En_passant).
- [Promotion](<https://en.wikipedia.org/wiki/Promotion_(chess)>).
- User error

  1.  Player input is not in a valid format.
  1.  A player tries to move an empty square.
  1.  A player tries to move an opponent's piece.
  1.  A player tries to move a piece to an invalid destination.

      1. The piece's characteristic moves don't include the destination.

      1. The destination contains an allied piece and/or, for pawns, an enemy piece.

      1. Except for knights, the way to the destination is blocked by another piece.

      1. For pawns, a normal diagonal capture move doesn't capture an enemy piece.

      1. For en passant, the required conditions are not met.

      1. For castling, the required conditions are not met.

      1. Moving to the destination leaves the player's king in check.

- [Checkmate](https://en.wikipedia.org/wiki/Checkmate)
- [Stalemate](https://en.wikipedia.org/wiki/Stalemate)
- Highlighting the opponent's previous move

## Tests

The application is not developed in a test-first manner. Nevertheless, I wrote several automated tests afterward, and I can recall at least a couple of instances where a bug was discovered immediately because of these tests.

Run the tests by executing

```bash
rspec
```

in the command line.

<img src="assets/images/tests.png">

---

## Reflections

This has been one of the most complex pieces of software that I've made. At the time of writing, this is probably my best work yet, although I do know that it's not perfect.

I've decided that any further improvement would not be worthwhile to me at this time. The project specifications are met, along with several additional features that I added just because I think they are essential to my interpretation of a usable chess game. Where or not it's good is subjective, but for now, it's good enough.
