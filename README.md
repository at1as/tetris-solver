# Tetris Solver

Will solve a static tetris board given the board dimensions and [tetromino pieces](https://en.wikipedia.org/wiki/Tetromino).


### Motivation

Solving those [sigil puzzles in the Talos Principle](https://steamcommunity.com/sharedfiles/filedetails/?id=354590899) is a pain.

While looking up the solutions is clearly cheating, investing 10x the time it would take to solve them manually to automate the solution is part of the playbook of all developers.

In order to be useful, this must be able to find solution to 8x7 grids in a reasonable amount of time (see `spec/talos_principle_puzzles.rb` for problems).


### Status

All Talos Principle Sigil puzzles can be solved, however runtime is often ~30 minutes for the more complex problems. This needs to come down at least an order of magnitude


### TODO

While solutions are computed quickly for small boards, the runtime becomes hilariously slow with solutions of moderate difficulty:

#### Example
##### 4 x 10 Board on 2016 MacBook Pro 
```
solution depth:   9
total iterations: 8,744,888

["z", "l", "l", "l"]
["z", "z", "t", "l"]
["i", "z", "t", "t"]
["i", "i", "t", "s"]
["i", "i", "s", "s"]
["i", "i", "s", "t"]
["l", "i", "t", "t"]
["l", "l", "l", "t"]
["o", "o", "o", "o"]
["o", "o", "o", "o"]

Finished in 39 minutes 42 seconds
```

#### Example
##### 5 x 8 Board on 2016 MacBook Pro

```
solution depth:   9
total iterations: 76,694,549

["l", "l", "z", "z", "s"]
["l", "z", "z", "s", "s"]
["l", "z", "z", "s", "j"]
["z", "z", "j", "j", "j"]
["s", "s", "t", "t", "t"]
["t", "s", "s", "t", "t"]
["t", "t", "t", "t", "t"]
["t", "t", "t", "t", "t"]
.

Finished in 425 minutes 36 seconds
```

There are some optimizations that can be made:
* Stop deepcloning/creating new objects: use an Array instead of a Board for computations, and return list of piece placements arrays, only merging them into the board upon returning the final solution
* When calculating all locations of pieces on the board, omit any invalid placements (in which 1 or 2 squares become trapped in a corner)
* Consider using separate subprocesses
* Optimizations around repeated pieces (when calculating piece conflicts, reuse matrix for repeated pieces)
* The `$solution` global variable to break out of the recursive loop is far from ideal

### Running Tests

```
$ gem install rspec
$ rspec spec/
```

### Notes

Built & Tested on Ruby 2.5.0

