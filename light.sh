#!/bin/bash

echo "Do you want to enable or disable port 80?"
echo "Enter 'enable' to enable port 80 or 'disable' to disable port 80."
read action

if [ "$action" == "enable" ]; then
    echo "Enabling HTTP access to the router"
    sed -i 's/#listen 80;/listen 80;/g' /etc/nginx/conf.d/gl.conf
    sed -i 's/#listen \[::\]:80;/listen \[::\]:80;/g' /etc/nginx/conf.d/gl.conf
elif [ "$action" == "disable" ]; then
    echo "Disabling HTTP access to the router"
    sed -i 's/listen 80;/#listen 80;/g' /etc/nginx/conf.d/gl.conf
    sed -i 's/listen \[::\]:80;/#listen \[::\]:80;/g' /etc/nginx/conf.d/gl.conf
else
    echo "Invalid option. Please enter 'enable' or 'disable'."
    exit 1
fi

echo "Restarting nginx"
/etc/init.d/nginx restart
