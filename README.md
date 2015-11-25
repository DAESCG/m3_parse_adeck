m3_parse_adeck
==============

This repository houses all relevant content for the 3rd DAES CG meeting, held
on Thursday, 19 November 2015.

Meeting Motivation
------------------
Many large and complex datasets in the atmospheric and climate sciences are
stored and distributed in file types that aren't suited for such data. The
[A-DECK](http://www.ral.ucar.edu/hurricanes/repository) forecast aid projection system,
which is hosted by NCAR's [Research Applications Laboratory](https://ral.ucar.edu/)
(RAL), utilizes the DAT file type to store TC forecast tracks, intensity
information, and several other variables output by a variety of dynamical and
statistical models. These files can be cumbersome to use, as they often contain
large numbers of rows, varying numbers of columns per row, and lots of missing
or incomplete data, making them difficult to parse and query.

The objective of this meeting is to increase awareness and motivate the use of
more suitable technology to host and distribute large and complex datasets.

Contents
--------
1. `README.md`          - Master README file
2. `unix_guide.pdf`     - A condensed UNIX guide for navigating through the terminal window
3. `aal112015.dat`      - A generic data file containing forecast information for TC Joaquin (2015)
4. `data_format.md`     - A-DECK file format information
5. `adeck_modellist.md` - A list of models used in the A-DECK file
6. `joaquin_adeck.gif`  - A sample forecast track graphic
7. `examples`           - Contains directories of DAESCG members' code

Installation
------------
```
git clone https://github.com/DAESCG/m3_parse_adeck
```

Instructions
------------
1. Take a moment to familiarize yourself with the data contained in the A-DECK file included in this repository.
2. Load and parse the data using the program of your choice.
3. Find all operational GFS forecasts initialized at 0000 UTC, 2 October 2015. Output the data to your console. Plot the corresponding forecast track.
4. Your examples will be placed in the examples directory
