Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature 
Set-content -Path "c:\inetpub\wwwroot\iisstart.htm" -Value "<!DOCTYPE html>
<html>
<body bgcolor=`"magenta`">
<p>This is my website in VM2</p>
<br><br><br><br>
<marquee>Presenting the Demo</marquee>
</body>
</html>" 