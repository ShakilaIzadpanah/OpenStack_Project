#!/bin/bash
request="start"
while [[ "$request" != "exit" ]]
do
 echo "  "
 echo "Please Enter Your Request (Enter exit to quit the shell script)!"
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
   echo "************** The Commands Format **************"
   echo "info               Project and developers information."
   echo "instance           Show list of instances."
   echo "del instance       Delete an instance."
   echo "exit               Quit the shell script."
 elif [[ "$request" == "instance" ]]
 then
   eval "openstack server list"
 elif [[ "$request" == "del instance" ]]
 then
   echo "These are the list of instances:"
   eval "openstack server list"
   echo " "
   echo "Select your intended instance..."
   read instance_name
   eval "openstack server delete $instance_name"
   echo "Server $instance_name successfully deleted!"
 elif [[ "$request" == "create instance" ]]
 then
   echo "Please enter your instance name..."
   read instance_name
   echo "Please enter your password..."
   read instance_password
   echo "These are the list of flavors:"
   eval "openstack flavor list"
   echo "Enter flavor name..."
   read flavor_name
   echo "These are the list of images:"
   eval "openstack image list"
   echo "Enter image name..."
   read image_name
   echo "These are the list of networks:"
   eval "openstack network list"
   echo "Enter network name..."
   read network_name
   echo "These are the list of key-pairs:"
   eval "openstack keypair list"
   echo "Enter key-pair name..."
   read keypair_name
   echo "These are the list of security groups:"
   eval "openstack security group list"
   securitygroups=()
   choose="yes"
   j=0
   while [[ "$choose" == "yes" ]]
   do
    echo "Enter security group name..."
    read security_group_name
    securitygroups[$j]="$security_group_name"
    echo "To add another security group enter 'yes' otherwise enter 'cancel'..."
    read choose
    j=$((j+1))
   done
   eval "openstack server create --flavor $flavor_name --image $image_name --network $network_name --key-name $keypair_name $instance_name"
 fi
done

