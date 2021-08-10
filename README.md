# certbot-gandi
Extend Certbot docker image to obtain Let's Encrypt certificates using DNS Challenge with GANDI.

Notes: made for my personal use, use at your own risk. Feedbacks are welcome.

## Build docker image locally

docker build . -t certbot-gandi:latest

## Generating a certificate using DNS Challenge

Notes: you don't need the e-mail to be valid to generate the certificate. Command below will generate one certificates valid for example.com, *.example.com, and *.fwd.example.com.

IMPORTANT: certificates and let's encrypt account data will be stored in `$HOME/webdata/letsencrypt`.

The GandiV5 API key is passed as the environment variable `GANDI_API_KEY` to the container (flag `-e` below).

```
docker run --rm -v$HOME/webdata/letsencrypt:/etc/letsencrypt/ -e GANDI_API_KEY=MYSECRETAPIKEY blep/certbot-gandi:latest certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --non-interactive --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d *.example.com -d example.com -d *.fwd.example.com
```

Output:
``` 
+ echo Writing GANDI_API_KEY environment variable to /app/gandi.ini
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

if the certificate is already up to date, the output will be similar to:
```
+ echo Writing GANDI_API_KEY environment variable to /app/gandi.ini
+ chmod 600 /app/gandi.ini
+ echo Running certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --non-interactive --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d '*.example.com' -d example.com -d '*.fwd.example.com'
+ certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --non-interactive --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d '*.example.com' -d example.com -d '*.fwd.example.com'
Writing GANDI_API_KEY environment variable to /app/gandi.ini
Running certbot certonly -a certbot-plugin-gandi:dns --agree-tos -m cerbot@example.com --non-interactive --certbot-plugin-gandi:dns-credentials /app/gandi.ini -d *.example.com -d example.com -d *.fwd.example.com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator certbot-plugin-gandi:dns, Installer None
Cert not yet due for renewal
Keeping the existing certificate

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Certificate not yet due for renewal; no action taken.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

## Securing you API key

A good article on options available to secure you GANDI API key:
https://www.eff.org/deeplinks/2018/02/technical-deep-dive-securing-automation-acme-dns-challenge-validation

## Related projects

- https://github.com/obynio/certbot-plugin-gandi
- https://hub.docker.com/r/certbot/certbot/dockerfile
- https://github.com/certbot/certbot
- https://letsencrypt.org/
- https://community.letsencrypt.org/t/acme-v2-production-environment-wildcards/55578

