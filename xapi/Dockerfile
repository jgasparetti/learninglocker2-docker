FROM learninglocker/xapi-service:latest

RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils

RUN apt-get update \
	&& apt-get install -y \
	dos2unix \
	gettext-base

COPY env.template .env.template

COPY entrypoint.sh /entrypoint.sh

RUN dos2unix /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["yarn", "start"]