# cowinslotnotifier

This script is created in powershell and it is developed for my self to track vaccine slots in and around bangalore,this can be improvised.

It  can notify to telegram group and can notify by mail

Below are the resources which  i have used to developed the script


TelegramIntegration:https://www.itdroplets.com/automating-telegram-messages-with-powershell/
cowin integration:https://documenter.getpostman.com/view/9564387/TzRPip7u


**What changes to be done before running script**

**----------------------------------------------------------------------------------------------------------------------------------------------**
1.Change the emaiid and password

![image](https://user-images.githubusercontent.com/84151704/118175261-81514300-b44d-11eb-8b1e-2615a54dad91.png)

2.Change the bottoken and chatid for telegram app

![image](https://user-images.githubusercontent.com/84151704/118175418-b3fb3b80-b44d-11eb-85cc-101db694b9c3.png)

on how to get token and chatid refer  https://www.itdroplets.com/automating-telegram-messages-with-powershell/

**----------------------------------------------------------------------------------------------------------------------------------------------**

**How to run this script**

1.Clone the repo to local machine or download the repo to localmachine
2.find  Slotfinder.ps1 file ,Rightclick and run with powershell


This script once run keeps running for forever as it is running in a do while and i have given a condition not a break loop.

This keeps pooling the api for every 5 mins

It can run on any windows laptop with just powershell installed on it,no webserver or no configuration is required.


For any suggestion drop me a email at justlakshmikanth@gmail.com

**Stay Safe and Healthy**
