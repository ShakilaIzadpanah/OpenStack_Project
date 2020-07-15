#!/bin/bash
request="start"
while [[ "$request" != "exit" ]]
do
 echo " "
 echo "Please Enter Your Request (Enter exit to quit the shell script...)!"
 read request
 if [[ "$request" == "info" ]]
 then 
   echo  "**********************************************************************************
* A Bash Script by using the OpenStack CLI tools- Cloud Computing Course Project *
*                                                                                *
* Created By:                                                                    * 
*            Shakila Izadpanah - Email: shakila.izadpanah@gmail.com              *
*            Zahra   Purfallah - Email: zahar.purfallah@gmail.com                *
* Version 1.0                                                                    *
**********************************************************************************"
 elif [[ "$request" == "help" ]]
 then
  echo " "
  echo "**************The commands format**************" 
  echo "info              Project and developers information."
  echo "user              Show list of users."
  echo "instance          Show list of instances."
  echo "del instance      Delete an instance."
  echo "exit              quit the shell script."
 elif [[ "$request" == "user" ]]
 then
  eval "openstack user list"
 elif [[ "$request" == "instance" ]]
 then
  eval "openstack server list"
 elif [[ "$request" == "del instance" ]]
 then
  echo "These are the list of instances:"
  eval "openstack server list"
  echo "Select  your intended instance..."
  read instance_name
  eval "openstack server delete $instance_name"
  echo "Server $instance_name successfully deleted!"
 fi
done

