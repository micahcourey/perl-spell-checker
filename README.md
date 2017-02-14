Perl Spell Checker
==================

By Micah Courey, February 11, 2017

A program written in Perl that reads a large list of English words from /usr/share/dict/words 
on a unix system) into memory, and then reads words from stdin, and prints either 
the best spelling suggestion, or "NO SUGGESTION" if no suggestion can be found. The 
program should print ">" as a prompt before reading each word, and loops until killed.

Setup
----------
* Clone repository:
```console
$ git clone https://github.com/micahcourey/perl-spell-checker
```
* Start program inside project folder:
```console
$ perl spell_checker.pl
```
* Mispell words and get spelling suggestions

License
----------
MIT License, Copyright (c) 2017 Micah Courey