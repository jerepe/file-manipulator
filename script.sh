#! /bin/bash
# display a welcome message and store the user input into the variable "name":
read -p "Hi, and Welcome. What is your name ? " name
echo -e "Alright Mr.$name \U1F44D"

# read and store the first line of document changelog.md in a variable:
firstline=$(head -n1 ./source/changelog.md)

# convert the variable firstline into an array "splitfirstline":
read -a splitfirstline <<< $firstline

# store the second "block" of information (aka located at index 1) from the array splitfirstline into the variable "version":
version=${splitfirstline[1]}

# display an informational message and store the user input in a variable "continue":
read -p "This program will copy all files from the source folder, into the build folder. Please enter 1 if you wish to continue, and 0 to exit: " continue

# add conditions, and a nested loop, to either keep the program running to copy files from the source folder into the build folfer, or stop it using a goodbye message:
if [ $continue == "1" ]
then
  echo -e "\nOk. Processing files ...\n"
  for filename in source/*
  do
    if [ $filename == source/secretinfo.md ]
    then
      echo ">>> $filename is being copied"
      cp $filename build/
      sed -i'' -e 's/42/XX/g' build/secretinfo.md
    else
      echo ">>> $filename is being copied"
      cp $filename build/
    fi
  done
  echo -e "\nBuild version $version now contains the following files:\n"
  cd ~/workspace/learn-bash-scripting-project/build; ls; cd ../
elif [ $continue == "0" ]
then
  echo "Ok, come back when you are ready then. Bye"
else
  echo "Error, try again"
fi
