#!/bin/bash
request="start"
echo " "
echo "                  *****************************                    "
echo "It is essential to execute 'run openrc' command for authenticating!"
echo "                  *****************************                    "
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
   echo "******************************************* The Commands Format ********************************************"
   echo "info               Project and developers information."
   echo "run openrc         Authenticate user."
   echo "list instance      Show list of instances."
   echo "delete instance    Delete an instance."
   echo "create instance    Create an instance using your intended parameters as described below:"
   echo "                   instance name | instance password | flavor | image | network | keypair | security groups."
   echo "exit               Quit the shell script."
 elif [[ "$request" == "run openrc" ]]
 then
   if [ -f "ouropenrc" ]
   then
    eval ". ouropenrc"
   else
    eval "touch ouropenrc"
    echo "Enter openrc file address..."
    read file_address
    eval "cp $file_address  ouropenrc"
    eval ". ouropenrc" 
   fi
 elif [[ "$request" == "list instance" ]]
 then
   eval "openstack server list"
 elif [[ "$request" == "delete instance" ]]
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
   echo "password: $instance_password chpasswd: { expire: False } ssh_pwauth: True" >  user_data
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
    while [[ "$choose" != "yes" ]] && [[ "$choose" != "cancel" ]]
    do
     echo "To add another security group enter 'yes' otherwise enter 'cancel'..."
     read choose
    done
    j=$((j+1))
   done
   eval "openstack server create --flavor $flavor_name --image $image_name --network $network_name --key-name $keypair_name --user-data user_data  $instance_name"
   len=${#securitygroups[@]}
   for (( i=0; i<$len; i++ ));
   do
    eval "openstack server add security group $instance_name ${securitygroups[$i]}";
   done
   echo "Server $instance_name successfully created"
 elif [[ "$request" != "exit" ]]
 then
   echo "Your entered command format is wrong..."
   echo "Enter a command from below list..."
   echo " "
   echo "info                     Project and developers information."
   echo "instance                 Show list of instances."
   echo "delete instance          Delete an instance."
   echo "create instance          Create an instance using your intended parameters as described below:"
   echo "                         instance name | instance password | flavor | image | network | keypair | securitu groups."
   echo "exit                     Quit the shell script."
 fi
done

