# FROM certbot/certbot:latest
FROM certbot/certbot:v1.18.0

RUN pip install certbot-plugin-gandi
COPY ./certbot.sh /app/certbot.sh
ENTRYPOINT ["/app/certbot.sh"]
# GandiV5 API Key to be override when running the container with -e or an env file.
ENV GANDI_API_KEY MYSECRETAPIKEY
