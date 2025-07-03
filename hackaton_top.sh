#!/bin/bash
# ============================================================================
# shell script to backup hackaton_top.sv, then wget latest test code
# Source: STEAM Clown - www.steamclown.org 
# GitHub: https://github.com/jimTheSTEAMClown/verilog
# Hacker: Jim Burnham - STEAM Clown, Engineer, Maker, Propmaster & Adrenologist 
# This example code is licensed under the CC BY-NC-SA 4.0, GNU GPL and EUPL
# https://creativecommons.org/licenses/by-nc-sa/4.0/
# https://www.gnu.org/licenses/gpl-3.0.en.html
# https://eupl.eu/
# Program/Design Name:		hackaton_top.sh
#
# Copy This wget
# wget -O pull_hackathon_test.sh https://raw.githubusercontent.com/jimTheSTEAMClown/Verilog/refs/heads/main/hackaton_top.sh
# ============================================================================


  echo "----------------------------------------------------"
  if [ -e hackathon_top.sv ]; then
    echo "File exists."
    BACKUP_FILE="hackathon_$(date +%Y%m%d_%H%M%S)_top.sv"
    mv hackathon_top.sv $BACKUP_FILE
  else
    echo "File does not exist."
 fi
 
wget -O hackathon_top.sv https://raw.githubusercontent.com/verilog-meetup/verilog-hackathon-education-kit-manual/refs/heads/main/SV-Examples/verilog_test.sv
echo "----------------------------------------------------"
ls -l
echo "----------------------------------------------------"
cat hackathon_top.sv
echo "----------------------------------------------------"

echo '  ____  _____  _  _  ____ '
echo ' (  _ \(  _  )( \( )( ___) '
echo '  )(_) ))(_)(  )  (  )__) '
echo ' (____/(_____)(_)\_)(____) '
echo "----------------------------------------------------"
                                                  
