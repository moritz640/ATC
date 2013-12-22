#################################################################
# !/bin/bash							
# Auto-Trading-Client - Configurator				
# v0.2-alpha - 20.12.2013					
# Created by Moritz Wenzel (moritz.wenzel@secure-mail.biz)	
#################################################################

echo "What do you want to do?"
echo "1 -> Change setpoint for sale"
echo "2 -> Change setpoint for purchase."
echo "3 -> Exit"
read -p "Please make input(1-3): " in1

case $in1 in
  1)clear
    read -p "Please enter the new setpoint for the sale (XX,XX): " in2
    echo ${in2:0:2}${in2:3:2} > sollwerte/vkwert.cfg
    echo "Value change is executed successfully"
    ;;
  2)clear
    read -p "Please enter the new setpoint for the purchase (XX,XX): " in3
    echo ${in3:0:2}${in3:3:2} > sollwerte/ekwert.cfg
    echo "Value change is executed successfully"
    ;;
  3)exit
    ;;
  *)echo "Unknown value"
esac
  
