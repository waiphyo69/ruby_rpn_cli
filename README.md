# Basic Command Line Rpn Calculator

## About

This is an implementation of command-Line based Reverse Polish Nation Calculator in ruby.
Floats, integers and four basic arithmetic operators are allowed to enter one at a time.
Press h for help, r for resetting stack, s for displaying stack, q or Ctrl+C to quit.
To run the calculator, cd into ruby_rpn_cli folder and install required gems first.

```
bundle install
```
Then, calculator can be run with this command.

```
ruby play.rb
```
Tests can be run with this command

```
rspec spec
```
##Technical Documentation

###Architecture

The implementation uses Object Oriented Approach by having distinct instantiable classes
serving distinct purposes.
Base Interface class represents the user-facing layer.
Cli Interface class inherits from base interface and implements command line specific input/output handling.
Calculator class holds the logic to take in operands/operators, store the stack and calculate accordingly.
Engine class incorporates both interface and calculator and implements the whole UI/calculation process in
a loop which is only broken by exit commands, and raised errors are properly displayed, rescued and recovered.
play.rb is a ruby executable file that instantiates an engine with a cli interface with blue content color and red error color, a calculator, and run it automatically.


###Trade-offs

Having a color-customizable interface resulted in ugly encoded strings, and verbose tests.
Heavily-regex based validation in calculator class calls for implementing more complicated regex
for future further input additions.
Using aruba with rspec allowed full integration test but the inability to test on the fly while
the program is running resulted in having to aggregate all the outputs and matching.
(Investigate aruba with cucumber maybe?)
Engine class essentially implements the whole input/output/calculation flow thus was only testable
with aruba/rspec in play_spec.rb, and did not have a class test for itself.

## Todo

Have calculator class also be able to accept composite RPN strings such as '1 2 3 + -'
Find a better CLI integration test flow
Implement more interfaces
