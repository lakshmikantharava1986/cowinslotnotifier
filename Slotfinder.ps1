
<#
This script is developed by lakshmikanth

usefull links
TelegramIntegration:https://www.itdroplets.com/automating-telegram-messages-with-powershell/
cowin integration:https://documenter.getpostman.com/view/9564387/TzRPip7u

#>
#params
$agetocheck=18
#districts
$blrurban=265
$blrrural=276
$bbmp=294
[pscustomobject[]]$districts=@()
$districts = [PsObject]@{ Name = "BLR Urban"; key=265}
$districts += [PsObject]@{ Name = "BLR Rural"; key=276}
$districts += [PsObject]@{ Name = "BBMP"; key=294}
$districtstosearch=@($blrurban,$blrrural,$bbmp)
#getcurrentdate
$todaydate=get-date -Format "dd-MM-yyyy"
$time_to_repeatedcheck=5
$enableMailNotification=$true
$enableTelegramNotification=$false

function Send-ToEmail([string]$email,[String] $content){

 
    $message = new-object Net.Mail.MailMessage;
    $message.From = "youremailid";
    $message.To.Add($email);
    #$message.BCC.Add("listofemailid's followed by ,"); 
    $message.Subject = "Vaccine Slots found book it on Arogyasetu App/Cowin ";
    $message.Body = "$content";

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.UseDefaultCredentials = $false;
    $smtp.Credentials = New-Object System.Net.NetworkCredential("youremailid", "password");
    $smtp.send($message);
    write-host "Mail Sent" ; 
 }


 function SendMessagetoTelegram([String] $content){
 
    $MyToken = "inputyourtoken"
    $chatID = yourchatid
    $Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($MyToken)/sendMessage?chat_id=$($chatID)&text=$($content)"
 }


#start code
do {
$timestamp=get-date -Format "dd-MM-yyyy hh:mm tt"
Write-host "**************************************************************"
Write-host "Started Search at $timestamp "
    foreach($district in $districts){

    $districtid=$district.key

    $weburl="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=$districtid&date=$todaydate"
    Write-host "-------------------------------------------------------------------------------"
    Write-host "searching for slots in  $($district.Name)"
    Write-host "-------------------------------------------------------------------------------"
    $Vaccineresult = (Invoke-RestMethod -Method get -UseDefaultCredentials  -Uri $weburl)

    #$slotobject=$Vaccineresult | ConvertTo-Json -Depth 99

    #$Vaccineresult.centers

        foreach($centre in $Vaccineresult.centers)
        {
          Write-Host " checking $($centre.center_id) -  $($centre.name)"
          if($centre.sessions -and $centre.sessions.Count -gt 1){
            foreach($session in $centre.sessions){
             if($session.min_age_limit -eq $agetocheck -and  $session.available_capacity -gt 0){
                Write-Host " $($session.date)- $($session.min_age_limit)- $($session.available_capacity)" -ForegroundColor red -BackgroundColor white
                $message=" Slot found  in $($district.Name) at $($centre.name)  on $($session.date) for  age limit $($session.min_age_limit) it has  $($session.available_capacity) available slots"
                 #send notifications
                 if($enableMailNotification){Send-ToEmail  -email "youremailid"  -content $message}
                 if($enableTelegramNotification){SendMessagetoTelegram -content $message}
                [console]::beep(2000,300)
                }
             }
          }
        }
      }
      Write-host "**************************************************************"
      Start-Sleep (60*$time_to_repeatedcheck)
  } while(1 -ne 2)
