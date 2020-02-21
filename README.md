# cerbot-gandi
Extend Certbot docker image to obtain Let's Encrypt certificates using DNS Challenge with GANDI.

Notes: made for my personal use, use at your own risk. Feedbacks are welcome.

## Build docker image locally

docker build . -t certbot-gandi:latest

## Generating a certificate using DNS Challenge

Notes: you don't need the e-mail to be valid to generate the certificate. Command below will generate one certificates valid for example.com, *.example.com, and *.fwd.example.com. 

IMPORTANT: certificates and let's encrypt account data will be stored in `$HOME/webdata/letsencrypt`.

You need to run this from a directory containing file `gandi.ini` with the following content:

```
# Gandi live dns v5 api key
certbot_plugin_gandi:dns_api_key=MYLIVEDNSAPIKEY
```

```
docker run --rm -v `pwd`/gandi.ini:/config/gandi.ini -v$HOME/webdata/letsencrypt:/etc/letsencrypt/ certbot-gandi:latest certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --non-interactive --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d *.example.com -d example.com -d *.fwd.example.com
```

Output:
``` 
+ echo Copying /config/gandi.ini to /app/gandi.ini
+ cp -p /config/gandi.ini /app/gandi.ini
+ echo Fixing access right of /app/gandi.ini
+ chmod 600 /app/gandi.ini
Copying /config/gandi.ini to /app/gandi.ini
Fixing access right of /app/gandi.ini
Running certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d *.example.com
+ echo Running certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d '*.example.com'
+ certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d '*.example.com'
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator certbot-plugin-gandi:dns, Installer None
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for example.com
Waiting 10 seconds for DNS changes to propagate
Waiting for verification...
Cleaning up challenges
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.com/privkey.pem
   Your cert will expire on 2020-05-21. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
``` 
