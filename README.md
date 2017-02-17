Perl Spell Checker
==================

By Micah Courey, February 11, 2017

A program written in Perl that reads a large list of English words from /usr/share/dict/words 
on a unix system into memory, and then reads words from stdin, and prints either 
the best spelling suggestion, or "NO SUGGESTION" if no suggestion can be found. The 
program prints ">" as a prompt before reading each word, and loops until killed.

The program corrects the following types of spelling mistakes as well as any combination of these mistakes:
```console
Case (upper/lower) errors: "inSIDE" => "inside"
Repeated letters: "jjoobbb" => "job"
Incorrect vowels: "weke" => “wake"
```

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
* Misspell a word, press Enter and receive a spelling suggestion

License
----------
MIT License, Copyright (c) 2017 Micah Courey