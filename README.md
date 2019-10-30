# ec2_instances
Script to start, stop ec2 instances on AWS with AWS cli


# BEFORE STARTING

You must install and configure virtualenv on this folder.

Following tutorial : https://gist.github.com/frfahim/73c0fad6350332cef7a653bcd762f08d

Else, GOOGLE is your friend !

After virtualenv step, install aws cli on your virtualenv

Command : pip install --upgrade awscli

When you dit that, configure a profile.

  aws configure --profile $profile_name
  
When it's done, export profile variable
export profile="--profile profile_name"

If you want to store this variable, export them on your ~/.bashrc or your ~/.bash_profile



 

# RUN

When all requirements are done, you can execute the script : 

./status_ec2.sh





# TO DO : 

Add reboot instance
Add choice of the  user to get specific informations

