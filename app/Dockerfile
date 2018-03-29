FROM debian:9

RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils
	
RUN apt-get update \
	&& apt-get install -y dos2unix

RUN apt-get update \
	&& apt-get install -y \
		wget \
		procps \
		curl \
		git \
		python \
		build-essential \
		xvfb \
		apt-transport-https \
		unzip \
		gettext-base \
		socat \
	&& wget -qO- https://deb.nodesource.com/setup_6.x | bash \
	&& apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn 

# install LL app
ENV LL_TAG=v2.2.1
RUN git clone https://github.com/LearningLocker/learninglocker.git /opt/learninglocker \
	&& cd /opt/learninglocker \
	&& git checkout $LL_TAG \
	&& mv .env.example .env \
	&& yarn install \
	&& yarn build-all

WORKDIR /opt/learninglocker

# make a copy of the origin storage directory that will be used in entrypoint-common.sh
# to fill up a volume mounted here, if it's empty
RUN cp -r storage storage.template

# install pm2
RUN npm install pm2 -g
#RUN pm2-runtime install pm2-logrotate
#RUN pm2-runtime set pm2-logrotate:compress true

# service api exposes port 8080
# service ui exposes port 3000
# see env.template
EXPOSE 3000 8080

COPY env.template .env.template

COPY entrypoint-common.sh ./entrypoint-common.sh
COPY entrypoint-webapp.sh ./entrypoint-webapp.sh
COPY entrypoint-worker.sh ./entrypoint-worker.sh

RUN dos2unix ./entrypoint-common.sh \
	&& dos2unix ./entrypoint-webapp.sh \
	&& dos2unix ./entrypoint-worker.sh

RUN chmod +x ./entrypoint-common.sh \
	&& chmod +x ./entrypoint-webapp.sh \
	&& chmod +x ./entrypoint-worker.sh

ENTRYPOINT ["./entrypoint-common.sh"]
