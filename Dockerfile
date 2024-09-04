# see https://hub.docker.com/r/linuxserver/minetest 
# for more information
FROM linuxserver/minetest:5.9.0
LABEL author="Kim Ragna Schwerdt" 
LABEL maintainer="minecraft-admins.de@capgemini.com"

COPY root /
RUN chmod +x /custom-cont-init.d/* && \
    lsiown -R root:root /custom-cont-init.d
COPY mods /home/mods
# copy all available games - currently 'tutorial' and 'minetest_game'
COPY games /config/.minetest/games

ENV SERVER_NAME="Minetest@Capgemini" 
ENV MOTD="Welcome to the training" 
ENV MAX_USERS=50 
ENV SERVER_DESCRIPTION="Minetest Server für Trainings bei Capgemini Deutschland GmbH" 
ENV PASSWORD=""
ENV ADMIN=""
ENV MAPGEN=""
ENV CLI_ARGS="--gameid tutorial --port 30000"
ENV GAME="tutorial"
