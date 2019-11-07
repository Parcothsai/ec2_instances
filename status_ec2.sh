#!/bin/bash
 #######################################################################################
# MAINTENER : Parco Thsai								#
# DATE : 30/10/2019									#
#											#
#											#
# REQUIREMENT :										#
# AWS account ( WITH ACCESS AND PRIVATE KEY )						#
# AWS permissions on EC2, CLI								#
# Virtualenv : https://gist.github.com/frfahim/73c0fad6350332cef7a653bcd762f08d		#
# Permission on actual directory : chmod +x status_ec2.sh				#
# Install jq | sudo apt-get install -y jq 										#
#											#
# TO CREATE A PROFILE : aws configure --profile  your_profile				#
# WHEN PROFILE CREATED, CHANGE VARIABLE PROFILE : profile="--profile your_profile	#
#											#
# TESTED ON : Debian 10									#
#											#
# READ README.md for more informations							#
 #######################################################################################
function start () {
	aws ec2 start-instances  --instance-ids $1  $profile
}

function stop () {
	aws ec2 stop-instances --instance-ids $1 $profile
}
function showinformation () {
	aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Instance:InstanceId,InstanceState:State,Name:Tags,IP:PublicDnsName,Key:KeyName}' $profile | jq
}

function rebootid () {
	aws ec2 reboot-instances --instance-ids $1 $profile
}

read -p "Do you want to see information about all ec2 in the region Yy/Nn? " show
case $show in 
  [Yy]*) echo "Showing information:" && showinformation ;;
  [Nn]*) echo "ok" ;;
esac
#instance=$1
#info=`aws ec2 describe-instances --filters "Name=tag:Name,Values=$1"`


#echo $id

declare -A tab
declare -A tabb
instances=`aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Instance:InstanceId,InstanceState:State,Name:Tags}' | grep "Value" | cut -d: -f2 | cut -d\" -f2`
echo $instances > instances
nb=`awk '{print NF}' instances`

for i in $(eval echo "{1..$nb}")
do
	name=`cut -d' ' -f$i instances`
	grepid=`aws ec2 describe-instances --filters "Name=tag:Name,Values=$name" | grep "InstanceId"`
	id=`echo $grepid | cut -d: -f2 | cut -d\" -f2`
	echo "$i ) $name "
        tab[$i]=$name
        tabb[$i]=$id

done
#echo "tableau ${tab[1]}"
read  -p "Which instance do you want to change?" choix
echo $choix
#choix=`echo "$(($choix + 0))"`
choix=`echo "${tabb[$choix]}"`

read  -p "Do you want to START (1) STOP (2) instances or EXIT SCRIPT (0) ?" doit
case $doit in 
  1) start $choix ;;
  2) stop $choix ;;
  0) echo "Do nothing, exit" && exit 0 ;;
#  3) echo "reboot" && rebootid $choix ;;
  *) echo "bad choice, exit"; exit 1
esac




