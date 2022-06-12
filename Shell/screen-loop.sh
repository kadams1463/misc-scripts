#!/bin/zsh

# Author: Kevin Adams (kadams1463)
# Date: 3/18/2022

# Set the date as a variable.
current_time=$(date "+%m-%d-%Y")

# Get input from the user. This is completely optional. However, if you need to,
# uncomment the lines starting with a "#". Be sure whatever variable you use is
# used in the commands.
#echo "<ASK USER A QUESTION HERE>"
#read userInputVariable

# Note: If you need to, for zsh, you can use this format to convert between
# upper and lower case for a variable:
#
# UPPER CASE
# ${(U)userInputVariable}
#
# LOWER CASE
# ${(L)userInputVariable}

# Remove any old files that we had previously if we're re-running this.
# Most of the time, I kept the scripts in the home folder.
rm ./output-$current_time
rm /home/$USER/output-$current_time
rm /home/$USER/screenlog.0

# Create the full log files for our screen output. One for screen output, one for screen's
# log (in case you have other screen sessions you need to use)
touch ./output-$current_time
touch /home/$USER/screenlog.0

# Set up a loop to run this script however many times. In this example, 1 to 3.
for i in {1..3};
do
# Create a logged, detached screen session for what we're running.
/usr/bin/screen -dmSL screen-script

# Enable realtime logging in the screen session.
/usr/bin/screen -S screen-script -X colon "logfile flush 0^M"

# Do some command here. This line I used to establish an SSH connection, but enter whatever you want.
/usr/bin/screen -S screen-script -X stuff "ssh user@server.address.com^M"
sleep 15

# Do some command that needs $i as part of the input, with $i as numbers 1-X. Wait 10 seconds after.
# Note that it will enter whatever number for $i for that iteration. Example: second iteration would be 2.
/usr/bin/screen -S screen-script -X stuff "run stuff based on $i^M"
sleep 10

# Send "enter" a few times in the screen session to wake up the device's output/login screen. Wait 10 more seconds
/usr/bin/screen -S screen-script -X stuff "^M^M"
sleep 10

# Exit the screen session.
/usr/bin/screen -S screen-script -X quit

# End of the loop.
done

# Copy all of the output from the screen sessions into the output file that will be reviewed.
cat /home/$USER/screenlog.0 >> /home/$USER/output-$current_time
