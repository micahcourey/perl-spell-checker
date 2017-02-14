Perl Spell Checker
==================

By Micah Courey, 02-Oct-2015

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
* Start server inside project folder:
```console
$ perl spell_checker.pl
```
* Mispell words and get spelling suggestions

License
----------
MIT License, Copyright (c) 2017 Micah Courey