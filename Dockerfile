FROM linuxserver/minetest:5.8.0
LABEL author = "Kim Ragna Schwerdt" 
LABEL maintainer = "minecraft-admins.de@capgemini.com"
# add local files
# check if necessary or if in base image is sufficient
COPY mods /config/.minetest/mods
COPY games /config/.minetest/games

ENV SERVER_NAME "Minetest@Capgemini" 
ENV MOTD "Welcome to the training" 
ENV MAX_USERS 50 
ENV SERVER_DESCRIPTION "Minetest Server für Trainings bei Capgemini Deutschland GmbH" 
ENV PASSWORD ""
ENV ADMIN ""
ENV MAPGEN ""
ENV CLI_ARGS "--gameid minetest --port 30000"
ENV MODS false
