#!/bin/bash
yum install httpd -y

systemctl start httpd
systemctl enable httpd

echo "<h1>My App</h1>" /war/www/html/index.html