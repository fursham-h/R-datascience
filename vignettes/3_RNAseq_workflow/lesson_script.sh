# open class
## what will we be doing today 
### First workshop of this series. Intro to RNAseq
### Check if everyone have check if they have bash installed
### Lesson materials https://fursham-h.github.io/R-datascience/articles/3_RNAseq_workflow/Overview.html
## use etherpad for checkin https://etherpad.wikimedia.org/p/CDN-RNAseqIntro-online
## screen management and zoom reactions
## recording 

### WHY SHOULD I USE A SHELL
# A shell is a computer program that presents a command line interface which 
# allows you to control your computer using commands entered with a keyboard 
# instead of controlling graphical user interfaces (GUIs) with a mouse/keyboard 
# combination.

# 1. Many bioinformatics tools can ONLY be used through a command line interface
# 2. Allow automation of work, making it less boring
# 3. Automation also makes your work less error-prone
# 4. Makes your work more reproducible
# 5. Operate cloud computing

## Navigating your file system
#### Open Git Bash on windows
#### Open Terminal on Mac

## DONT WORRY IF YOU CANT CATCH UP
# PASTE SECTIONS ON ETHERPAD
# SAVE HISTORY
# PROVIDE YOU WITH THE CODE FOR TODAY

# printing working directory
pwd


# SHOW FILESYSTEMS ON VARIOUS OS
# MacOS: https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/mac_filesystem.png
# Windows: https://sites.google.com/site/bccollaborativecomputing/_/rsrc/1415055705292/class-7-operating-systems-ii/ntfs_fs_structure.png

# changing directory
cd /

# list files
ls

# UP ARROW TO RETRIEVE HISTORY

# Adding flags
ls -l

# manual of functions
# WINDOWS DO NOT HAVE LS
man ls
ls - - help

# clearing screens
clear

### ls other directories and tab completion
ls -l dev
ls -l ~
ls -l <drag directory>
ls -l d<tab>
ls -l b<tab>

# using wildcards
ls -l bin/b*

### ACTIVITY 1 (2 mins)
# Do each of the following tasks from your current directory using a single ls command for each:
# 
#     List all of the files in /usr/bin that start with the letter ‘c’.
#     List all of the files in /usr/bin that contain the letter ‘a’.
#     List all of the files in /usr/bin that end with the letter ‘o’.


### Changing directory
cd ~/Desktop
ls -l

# if directory is not present
cd Downloads

# moving up one directory
cd ..
ls -l

## Full paths vs relative paths
cd ~/Desktop
cd ~/Downloads
cd ../Desktop

# ACTIVITY 2
### Refer to the image file below
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/Activity2.png
#
## Answer the question by typing "1" on your option below
#1)
#2)
#3)
#4)

### Making folders and subfolders
mkdir test_folder
mkdir test_folder2
mkdir test_folder/subfolder
mkdir "test_folder/sub folder 2"

## Making text files
touch test_file.txt
touch test_file2.txt
touch test_file3.txt
ls -l 

## copying files
cp test_file.txt test_folder
ls -l test_folder

### USE MV TO MOVE FILES and RENAME
mv *.txt test_folder/subfolder
mv test_folder2 renamed_folder

## Edit text files directly in terminal
cd test_folder
nano test_file.txt

head test_file.txt
cat test_file.txt

## Deleting files
rm test_file.txt

## deleting folders
cd ..
rm -r test_folder

## BREAKKKK and ACTIVITY 3
# Create the following filestructure in your home folder (~)
# ~
# ↳ RNAseq_workshop
#   ↳ logs
#   ↳ metadata
#   ↳ originals
#     ↳ FASTQ
#   ↳ outputs
#   ↳ scripts

## Working with files
cd ~
mkdir -p RNAseq_workshop/originals/FASTQ
# press up arrow to see history of commands
mkdir -p RNAseq_workshop/outputs
mkdir -p RNAseq_workshop/scripts


## Downloading FASTQ file(s)
cd RNAseq_workshop/originals/FASTQ

## Sample ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA476008
which curl
which wget

curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR731/007/SRR7311317/SRR7311317_1.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR731/007/SRR7311317/SRR7311317_2.fastq.gz

# show GEO example
# fastq-dump: https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit

# unzip files
gunzip SRR7311317_1.fastq.gz

# preview sequencing files
head SRR7311317_1.fastq
head -n 4 SRR7311317_1.fastq
tail -n 4 SRR7311317_1.fastq

# count number of lines
wc - l SRR7311317_1.fastq

# previewing gzip files
gunzip -c SRR7311317_2.fastq.gz | head

# ACTIVITY 4 (2 min)
### Using one line of code, print out the number of lines in SRR7311317_2.fastq.gz


# Print out entire file content
cat SRR7311317_1.fastq
# CAN CANCEL COMMAND WITH CTRL-Z
less SRR7311317_1.fastq

# SEARCH PATTERN USING /N

# SEARCH PATTERN USING GREP
grep NN SRR7311317_1.fastq
grep NN SRR7311317_1.fastq | head
grep NN SRR7311317_1.fastq | wc -l

grep NN SRR7311317_1.fastq > Ns.txt
grep NN SRR7311317_1.fastq >> Ns.txt
grep -B1 -A2 NN SRR7311317_1.fastq | head

# ACTIVITY 5 (5 mins)
# Report the following to a text file
# 1. count the number of sequences in SRR7311317_1.fastq
# 2. count the number of sequences in SRR7311317_1.fastq containing illumina adapter sequences (CTGTCTCTTATACACATCT)

# zipping files
gzip SRR7311317_1.fastq


## TALK ABOUT RNASEQ
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/RNAseq_workflow.png

## Saving history


# Closing activity 
#1) What is the one thing you learn today?

#2) What is the one thing this workshop can improve on?


########## TO OPEN HTML #############
#mac
open

# windows
start

# linux
xdg-open






























