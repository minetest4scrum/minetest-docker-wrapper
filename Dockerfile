# see https://hub.docker.com/r/linuxserver/minetest 
# for more information
FROM linuxserver/luanti:5.14.0
LABEL author="Kim Ragna Schwerdt" 
LABEL maintainer="minecraft-admins.de@capgemini.com"

# copy init script for environment variables -> minetest.conf
COPY root /
RUN chmod +x /custom-cont-init.d/* && \
    lsiown -R root:root /custom-cont-init.d
# copy all available games - currently 'tutorial' and 'minetest_game'
COPY games /config/.minetest/games
# copy additional mods 
# mod incompatibility with minetest_game : alphabet, nc_stairs, street_signs
COPY mods /config/.minetest/games/minetest_game/mods

ENV SERVER_NAME="Minetest@Capgemini" 
ENV MOTD="Welcome to the training" 
ENV MAX_USERS=50 
ENV SERVER_DESCRIPTION="Minetest Server für Trainings bei Capgemini Deutschland GmbH" 
ENV PASSWORD=""
ENV ADMIN=""
ENV MAPGEN=""
ENV GAME="tutorial"
