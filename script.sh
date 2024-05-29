#!/bin/bash

function process_action {
    echo "What would you like to do?"
    echo "Enter 'e' for enable port 80, 'd' for disable port 80, or 'r' for redirect from port 80 to 443."
    echo "Please note: Enter the option exactly as shown above."

    read action

    case $action in
        e|E)
            echo "Enabling HTTP access to the router"
            sed -i 's/#listen 80;/listen 80;/g' /etc/nginx/conf.d/gl.conf
            sed -i 's/#listen \[::\]:80;/listen \[::\]:80;/g' /etc/nginx/conf.d/gl.conf
            ;;
        d|D)
            echo "Disabling HTTP access to the router"
            sed -i 's/listen 80;/#listen 80;/g' /etc/nginx/conf.d/gl.conf
            sed -i 's/listen \[::\]:80;/#listen \[::\]:80;/g' /etc/nginx/conf.d/gl.conf
            ;;
        r|R)
            echo "WARNING: The redirect feature is untested and should be used at your own risk."
            read -p "Are you sure you want to proceed with setting up redirection from port 80 to 443? (y/n): " confirm
            if [[ $confirm =~ ^[Yy]$ ]]; then
                echo "Setting up redirection from port 80 to 443"
                if grep -q "return 301 https://\$host\$request_uri;" /etc/nginx/conf.d/gl.conf; then
                    cat <<EOF >> /etc/nginx/conf.d/gl.conf

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    return 301 https://\$host\$request_uri;
}

EOF
                else
                    echo "Redirection already set up."
                fi
            else
                echo "Redirect setup cancelled. Please choose another option."
                process_action
            fi
            ;;
        *)
            echo "Invalid option. Please enter 'e', 'd', or 'r' exactly as shown above."
            process_action
            ;;
    esac

    echo "Restarting nginx"
    /etc/init.d/nginx restart
    exit 0
}

process_action
