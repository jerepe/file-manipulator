#! /bin/bash
mkdir folder1 folder2
touch folder1/file1 folder1/file2 folder1/file3 folder1/file4
echo "secret_line secret_word" > folder1/secretfile.txt

# display a welcome message and store the user input into the variable "name":
read -p "Hi, and Welcome. What is your name ? " name
echo -e "Alright Mr.$name"

# read and store the first line of document secretfile, containig the project's version number, in a variable:
firstline=$(head -n1 ./folder1/secretfile.txt)

# convert the variable firstline into an array "splitfirstline":
read -a splitfirstline <<< $firstline

# store the second "block" of information (aka located at index 1) from the array splitfirstline into the variable "version":
version=${splitfirstline[1]}

# display an informational message and store the user input in a variable "continue":
read -p "This program will copy all files from folder1, into folder2. Please enter 1 if you wish to continue, and 0 to exit: " continue

# add conditions, and a nested loop, to either keep the program running to copy files from folder1 into folder2, or stop it using a goodbye message.
# once done, will display folder2 content:
if [ $continue == "1" ]
then
  echo -e "\nOk. Processing files ...\n"
  for file in folder1/*
  do
    if [ $file == folder1/secretfile.txt ]
    then
	echo ">>> $file is being copied"
	echo ">>> $version is being replaced by XX for sharing purposes" 
      cp $file folder2/
      sed -n 's/secret_word/XX/g' folder2/secretfile.txt
      # if you're on Mac, chances are that you need to see a new file named secretfile.txt-e, if you want to remove it, uncomment everything under this line:
      for new_file in folder2/*
      do
          if [ $new_file == folder2/secretfile-e.txt ]
	  then
	      rm -r folder2/secretfile-e.txt
	  fi
      done
    else
      echo ">>> $file is being copied"
      cp $file folder2/
    fi
  done
  
  echo -e "\nfolder2 now contains the following file(s):\n"
  ls .
  echo""
  
elif [ $continue == "0" ]
then
  echo "Please come back when you are ready. Bye"

else
  echo "Error, try again"
fi
