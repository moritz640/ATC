#################################################################
# !/bin/bash						  	                                    #
# Auto-Trading-Client                                           #
# v0.2-alpha - 20.12.2013                                       #
# Created by Moritz Wenzel (moritz.wenzel@secure-mail.biz)	    #
#################################################################

# File that contains the set value for the purchase
while read ek
  do 
    typeset -i ek1
    ek1=$ek 
  done < sollwerte/ekwert.cfg
  
while read vk
  do 
    typeset -i vk1
    vk1=$vk 
  done < sollwerte/vkwert.cfg

log1=log/trading.log

if [ -w $log1 ]
  then
    rm $log1
fi
echo "Auto-Trading-Client - Version 0.2-alpha" >> $log1
date >> $log1
  
while true
  do
    sl1=1
      # Loop is executed as long as was made ​​to purchase
      while [ $sl1 == 1 ]
	do
	  # Reading the file with the current value
	  while read wert
	    do 
	      typeset -i wert1
	      wert1=$wert 
	    done < realwerte/current_ekwert.txt
	  typeset -i sl2
	  sl2=1
	  ek2=$ek1
	  # Check whether the actual value coincides with the predetermined desired value.
	 while [ $sl2 -lt 11 ]
	  do
	    clear
	    echo "Current value: "${wert1:0:2}","${wert1:2:2}"$" 
	    echo "Minimum purchase: "${ek1:0:2}","${ek1:2:2}"$" 
	    echo "Round: " $sl2 "of 10"
	    if [ $wert1 -ge $ek1 ]
	      then
		sleep 1
		break
	    fi
	    while [ $wert1 -lt $ek2 ]
	      do
		ek2=$wert1
		sl2=1
		clear
		echo "Current value: "${wert1:0:2}","${wert1:2:2}"$"
		echo "Minimum purchase: "${ek1:0:2}","${ek1:2:2}"$" 
		echo "Round: " $sl2 "of 10"
		sleep 15
		# Reading the file again to register changes
		while read wert
		  do 
		    typeset -i wert1
		    wert1=$wert 
		  done < realwerte/current_ekwert.txt
	      done
	    sleep 15
	    while read wert
	      do 
		typeset -i wert1
		wert1=$wert 
	      done < realwerte/current_ekwert.txt
	    sl2=$sl2+1  
	  done
	  while [ $wert1 -le $ek2 ]
	    do
	      while read wert
		do 
		  typeset -i wert1
		  wert1=$wert 
		done < realwerte/current_ekwert.txt
	      clear
	      echo "Current value: "${wert1:0:2}","${wert1:2:2}"$" 
	      echo "Ideally purchase: "${ek2:0:2}","${ek2:2:2}"$"
	      sleep 8
	    done
	  # Ideal value reaches -> unit / s bought
	  if [ $wert1 -lt $ek1 ]
	    then
	      echo "Purchased for: " ${wert1:0:2}","${wert1:2:2}"$"
	      echo "Purchased for: " ${wert1:0:2}","${wert1:2:2}"$" >> $log1
	      ./tone.sh
	      sl1=0
	    else
	      sl1=1
	  fi
	done
	
      sl3=1
      # Loop is executed until sale is made
      while [ $sl3 == 1 ]
	do
	  # Reading the file with the current value
	    do 
	      typeset -i wert3
	      wert3=$wert2
	    done < realwerte/current_vkwert.txt
	  typeset -i sl4
	  sl4=1
	  vk2=$vk1
	  # Check whether the actual value coincides with the predetermined desired value
	  while [ $sl4 -lt 11 ]
	    do
	      clear
	      echo "Current value: "${wert3:0:2}","${wert3:2:2}"$" 
	      echo "Minimum sale: "${vk1:0:2}","${vk1:2:2}"$" 
	      echo "Round: " $sl4 "of 10"
	      if [ $wert3 -le $vk1 ]
		then
		  sleep 1
		  break
	      fi
	      while [ $wert3 -gt $vk2 ]
		do
		  vk2=$wert3
		  sl2=1

		  clear
		  echo "Current value: "${wert3:0:2}","${wert3:2:2}"$"
		  echo "Minimum sale: "${vk1:0:2}","${vk1:2:2}"$" 
		  echo "Round: " $sl4 "of 10"
		  sleep 15
		  # Reading the file again to register changes
		  while read wert2
		    do 
		      typeset -i wert3
		      wert3=$wert2 
		    done < realwerte/current_vkwert.txt
		done
	      sleep 15
	      while read wert2
		do 
		  typeset -i wert3
		  wert3=$wert2
		done < realwerte/current_vkwert.txt
	      sl4=$sl4+1  
	    done
	  while [ $wert3 -ge $vk2 ]
	    do
	      while read wert2
		do 
		  typeset -i wert3
		  wert3=$wert2 
		done < realwerte/current_vkwert.txt
	      clear
	      echo "Current value:: "${wert3:0:2}","${wert3:2:2}"$" 
	      echo "Ideally sale: "${vk2:0:2}","${vk2:2:2}"$"
	      sleep 8
	    done
	  # Ideal reaches for sale -> unit / s
	  if [ $wert3 -gt $vk1 ]
	    then
	      echo "Sold for " ${wert3:0:2}","${wert3:2:2}"$"
	      echo "Sold for " ${wert3:0:2}","${wert3:2:2}"$" >> $log1
	      ./tone.sh
	      sl3=0
	    else
	      sl3=1
	  fi
	done
  done
