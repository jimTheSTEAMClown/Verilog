#!/bin/bash
# ============================================================================
# shell script to install the Verilog Hackathon project files
# Source: STEAM Clown - www.steamclown.org 
# GitHub: https://github.com/jimTheSTEAMClown/Verilog
# Hacker: Jim Burnham - STEAM Clown, Engineer, Maker, Propmaster & Adrenologist 
# This example code is licensed under the CC BY-NC-SA 4.0, GNU GPL and EUPL
# https://creativecommons.org/licenses/by-nc-sa/4.0/
# https://www.gnu.org/licenses/gpl-3.0.en.html
# https://eupl.eu/
# Program/Design Name:		Verilog-Hackaton-Project-Files.sh
# Description:    shell script to restore an Ubuntu Linux Class Image (with the latest Ubuntu release) after a clean Ubuntu install 
# Dependencies:   
# Revision: 
#  Revision 0.04 - Updated 06/26/2025 added VS Code command line install
#  Revision 0.03 - Updated 06/17/2025 for SVCTE Mechatronics Class, with latest apps and tools
#  Revision 0.02 - Updated 05/04/2024 for SVCTE Mechatronics Class
#  Revision 0.01 - Created 05/04/2024
# Additional Comments: 
# https://ubuntu.com/tutorials/access-remote-desktop#1-overview
# https://askubuntu.com/questions/1369973/how-to-connect-to-ubuntu-via-vnc-from-windows
# https://www.makeuseof.com/tag/how-to-establish-simple-remote-desktop-access-between-ubuntu-and-windows/
# https://patorjk.com/software/taag/#p=display&f=Bulbhead&t=Next%20Steps%0A
#
# Copy This wget
# sudo wget -O Verilog-Hackaton-Project-Files.sh https://raw.githubusercontent.com/jimTheSTEAMClown/Linux/master/Verilog-Hackaton-Project-Files.sh 
# ============================================================================
echo "----------------------------------------------------"
echo "cd to /home/$USER "
cd
pwd
if [ -d "/home/$USER/gowin" ];
      then
          echo "The Directory /home/$USER/gowin exists"
          echo "Checking for Hackathon GitClone Repository of basics-graphics-music"
          if [ -d "/home/$USER/gowin/basics-graphics-music" ];
            then
              echo "The Directory /home/$USER/gowin/basics-graphics-music exists"
              Echo "❌ - You should stop and check if you really want to run the git clone command"
          fi 

  fi    
echo " Enter y/Y or n/N or Any Other Key to Quit"
read -p " Install Latest Verilog GitHub Clone Of Hackathon Design Files in /home/$USER/gowin?: " yesGitCloneHackathon
# elif statements
if [ "$yesGitCloneHackathon" == "y" ] || [ "$yesGitCloneHackathon" == "Y" ]; then
  echo "----------------------------------------------------"
  
  echo "----------------------------------------------------"
  if [ -d "/home/$USER/gowin" ];
      then
          echo "The Directory /home/$USER/gowin exists"
          echo "Creating a Hackathon GitClone Repository"
          cd /home/$USER/gowin
          git clone https://github.com/yuri-panchul/basics-graphics-music.git

  fi  
  echo "----------------------------------------------------"
elif [ "$yesGitCloneHackathon" == "n" ] || [ "$yesGitCloneHackathon" == "N" ]
    then
    echo "Skipping This Verilog GitClone Step"
    if [ -d "/home/$USER/gowin" ];
        then
            echo "The Directory /home/$USER/gowin exists"
            echo "Exiting this shell scripts"
            exit 1
            # return
    fi
else
    echo " Any Key - Skipping This Verilog GitClone Step"
    exit 1
    # return
fi
