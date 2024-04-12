# Installing and Setting Up Nginx Web Server on Linux


### Step 1: Installing Nginx

```
sudo yum update
sudo yum install nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

scrin1

check http:
```bash
curl 127.0.0.1
```
скрін


### Step 2: Configuring Nginx

View Nginx configuration files:

```bash

ls -l /etc/nginx/
sudo nano /etc/nginx/nginx.conf

```
In the nginx.conf file, specify the location of the files to be displayed:
```bash
root /usr/share/nginx/html;
```
Copy your HTML and CSS files to the /usr/share/nginx/html/ directory:
```bash
sudo cp index.html /usr/share/nginx/html/
sudo cp achivment /usr/share/nginx/html/achivment
```
Add configuration for static content (e.g., achievements) in the Nginx configuration file:
```bash
server {
    location /achievements {
        root /usr/share/nginx/html/achievement;
    }
}
```
Restart nginx
```bash
sudo systemctl restart nginx
```



