### WHY SHOULD I USE A SHELL
# A shell is a computer program that presents a command line interface which 
# allows you to control your computer using commands entered with a keyboard 
# instead of controlling graphical user interfaces (GUIs) with a mouse/keyboard 
# combination.

# 1. Many bioinformatics tools can only be used through a command line interface
# 2. Allow automation of work, making it less boring
# 3. Automation also makes your work less error-prone
# 4. Makes your work more reproducible
# 5. Operate cloud computing

## Navigating your file system

# printing working directory
pwd

# changing directory
cd /

# SHOW FILESYSTEMS ON VARIOUS OS
# MacOS: https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/mac_filesystem.png
# Windows: https://sites.google.com/site/bccollaborativecomputing/_/rsrc/1415055705292/class-7-operating-systems-ii/ntfs_fs_structure.png

# list files
ls

# Adding flags
ls -l

# manual of functions
man ls

# clearing screens
clear

### ls other directories and tab completion
ls -l home
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
### SEE IMG FILE
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/Activity2.png

### Making folders and subfolders
mkdir test_folder
mkdir -p "test_folder/test folder"

## Making text files
touch test_file.txt
ls -l 

## copying files
cp test_file.txt test_folder
ls -l test_folder

### USE MV TO MOVE FILES

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

curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR731/007/SRR7311317/SRR7311317_1.fastq.gz --output SRR7311317_1.fastq.gz
curl ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR731/007/SRR7311317/SRR7311317_2.fastq.gz --output SRR7311317_2.fastq.gz

# show GEO example
# fastq-dump: https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit

# unzip files
gunzip SRR7311317_1.fastq.gz

# preview sequencing files
head SRR7311317_1.fastq
head -n 4 SRR7311317_1.fastq
tail -n 4 SRR7311317_1.fastq

# previewing gzip files
gunzip -c SRR7311317_2.fastq.gz | head


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

# ACTIVITY 4
# Report the following to a text file
# 1. count the number of sequences in SRR7311317_1.fastq
# 2. count the number of sequences in SRR7311317_1.fastq containing illumina adapter sequences (CTGTCTCTTATACACATCT)

# zipping files
gzip SRR7311317_1.fastq


## TALK ABOUT RNASEQ
# https://raw.githubusercontent.com/fursham-h/R-datascience/master/vignettes/3_RNAseq_workflow/images/RNAseq_workflow.png

## Saving history



########## TO OPEN HTML #############
#mac
open

# windows
start

# linux
xdg-open






























