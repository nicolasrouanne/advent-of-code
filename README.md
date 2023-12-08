# Advent of Code 2023

[![Rubocop](https://github.com/nicolasrouanne/advent-of-code/actions/workflows/lint.yml/badge.svg)](https://github.com/nicolasrouanne/advent-of-code/actions/workflows/lint.yml) [![Sorbet](https://github.com/nicolasrouanne/advent-of-code/actions/workflows/typecheck.yml/badge.svg)](https://github.com/nicolasrouanne/advent-of-code/actions/workflows/typecheck.yml)

This is my attempt at the [Advent of Code 2023](https://adventofcode.com/2023) challenge.
In each `dayXX` folder there is:

- a `README.md` file with the problem description, copy-pasted from the original website
- an `input.txt` file with the input data
- a `main.rb` file with my solution, which prints the 2 anwers to the console

## Usage

To run the solution for a given day, just run the `main.rb` file in the corresponding folder:

```bash
$ cd day1
$ ruby main.rb
```

## TypeChecking

[`Sorbet`](https://sorbet.org/) is used for typechecking. To run the typechecker, run `srb tc` in the root folder.

## Linting

[`Rubocop`](https://rubocop.org/) is used for linting. To run the linter, run `rubocop` in the root folder.
