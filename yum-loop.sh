#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F:%H:%M:%S)
LOGDIR=/tmp
SCRIPT=$0
LOGFILE=$LOGDIR/$SCRIPT-$DATE.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo "Yo should be a root user to execute this command"
    exit1
fi

VALIDATE(){
    
    if [ $1 -ne 0 ]
    then
        echo -e "$R Installing $N ... $2 .... $R is FALIURE $N"
        exit1
    else
        echo -e "$G Installing $N ... $2 .... $G is SUCCESS $N"
    fi

}

SKIP(){
	echo -e "$1 Exist... $Y SKIPPING $N"
}


for i in $@
do
    yum list installed $i &>>$LOGFILE
    if [ $1 -ne 0 ]
    then 
        echo -e "$i $G is not installed, hence installing it $N"
        yum install $i -y &>>$LOGFILE
        VALIDATE $? "$i"
    else
        SKIP "$Y $i already installed, hence skipping it $N"
    fi