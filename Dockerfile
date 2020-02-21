FROM certbot/certbot:latest

RUN pip install certbot-plugin-gandi
COPY ./certbot.sh /app/certbot.sh
ENTRYPOINT ["/app/certbot.sh"]
