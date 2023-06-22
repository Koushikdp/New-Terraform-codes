#!/bin/bash


# Install Apache

sudo apt update

sudo apt install -y apache2

sudo apt install curl


# Create a backup of the original index.html file

sudo cp /var/www/html/index.html /var/www/html/index.html.bak


# Write the new code into index.html

sudo bash -c "cat << EOF > /var/www/html/index.html

<html>
<body bgcolor=\"green\">
<p>This is hosted on Ubuntu</p>
<br><br><br><br>
<marquee>Presenting the Demo</marquee>
</body>
</html>
EOF"


# Restart Apache

sudo systemctl restart apache2


DD_API_KEY=0dd550e7bbd2fe1efbf4d7276336cd37 DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"