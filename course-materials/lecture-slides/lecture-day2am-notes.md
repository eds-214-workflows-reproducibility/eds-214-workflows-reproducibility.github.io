# The Command Line and Remote Servers

This morning, you'll learn:

* Why the command line is useful
* How to issue commands on the command line
* Why remote servers offer performance benefits
* How to use the command line to interact with a remote server

## Why not a GUI?

[Column 1]
Graphical User Interface (GUI)
* Point-and-click - gentler learning curve
* Limited customization options
* Nearly impossible to automate
  
[Column 2]
Command Line Interface (CLI)
* Highly customizable
* Designed to be automated
* Text-based - steeper learning curve

Are the trade-offs worth it? For some scientists, maybe not. But for a data scientist, **DEFINITELY**.

## Terminals and shells

[Column 1]
Terminal
* The program you type commands into
* Your megaphone for shouting at the computer

[Column 2]
Shell
* A program that passes commands to the operating system
* Listens to your megaphone

You will often see Terminal and Shell used interchangeably. This can get confusing. It helps to see them in action. Let's try it out!

## Terminal and shell demo

* Open a terminal
  * MacOS: Terminal
  * Windows: GitBash (both a terminal AND a shell)

* Ask the shell where you are
  * `pwd` - print working directory
  * `ls` - list files in the current directory
  
* Customize the command with options
  * `ls -l` - long listing format
  * `ls -a` - show hidden files
  * `ls -la` - both!
  
## Onions have layers

Animate in the images in lecture-slides/images/day2/command-line
  
## Key shell commands

[Column 1]
Navigation & File System

* pwd - know where you are
* ls (with -l, -a flags) - see what's there
* cd - move around (including cd ~, cd .., cd -)
* mkdir - create directories
* rmdir - remove directories (only if empty)

[Column 2]
File Operations

* touch - create files
* cp - copy files/directories
* mv - move/rename files
* rm - delete files (no recycle bin!)
* cat - view file contents

## Key shell commands

[Column 1]
Navigation & File System

* pwd - know where you are
* ls (with -l, -a flags) - see what's there
* cd - move around (including cd ~, cd .., cd -)
* mkdir - create directories
* rmdir - remove directories (only if empty)

[Column 2]
File Operations

* touch - create files
* cp - copy files/directories
* mv - move/rename files
* rm - delete files (no recycle bin!)
* cat - view file contents

## Customizing commands

`command [options] [arguments]`
* `command` - the command you want to run (e.g., `ls`)
* `options` - flags that modify the command's behavior (e.g., `-l`, `-a`)
* `arguments` - the files or directories the command should operate on (e.g., `mydir/`)

## Shell command challenge part 1

Do the following in your terminal. Make a note of your answers in a text file.

[Column 1]

Create the following directory structure on your computer.

renewable-energy
├── capacity
│   ├── san-luis-obispo.csv
│   ├── santa-barbara.csv
│   └── ventura.csv
└── usage
    ├── san-luis-obispo.csv
    ├── santa-barbara.csv
    └── ventura.csv

[Column 2]

Now, delete the `capacity/` folder and rename `usage/` to `data/`.

Use `ls -l data` to check the contents of your directory. Answer the following questions.

* Does your directory look the way you expect it to?
* In `ls -l data`, what parts correspond to the argument, option, and command?

## Shell command challenge part 1

Do the following in your terminal. Make a note of your answers in a text file.

[Column 1]

Create the following directory structure on your computer.

renewable-energy
├── capacity
│   ├── san-luis-obispo.csv
│   ├── santa-barbara.csv
│   └── ventura.csv
└── usage
    ├── san-luis-obispo.csv
    ├── santa-barbara.csv
    └── ventura.csv

[Column 2]

Now, delete the `capacity/` folder and rename `usage/` to `data/`.

Use `ls -l data` to check the contents of your directory. Answer the following questions.

* Does your directory look the way you expect it to?
* In `ls -l data`, what parts correspond to the argument, option, and command?
  
## Shell command challenge part 2

[Column 1]

From the `renewable-energy` directory, run the following commands:

```sh
cd data
mkdir ../scripts
touch ../scripts/1_import.R
cd ..
mv scripts/1_import.R R/import.R
```

[Column 2]

Answer the following questions.

* What error message did you get?
* What do you think these commands were _supposed_ to accomplish?
* How could you fix it?
  
  