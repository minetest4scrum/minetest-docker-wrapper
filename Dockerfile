FROM linuxserver/minetest
LABEL author = "Kim Ragna Schwerdt" \
    maintainer = "minecraft-admins.de@capgemini.com"
# add local files
# check if necessary or if in base image is sufficient
COPY root /
COPY mods /home/mods

ENV SERVER_NAME "Minetest@Capgemini" 
ENV MOTD "Welcome to the training" 
ENV MAX_USERS 50 
ENV SERVER_DESCRIPTION "Minetest Server für Trainings bei Capgemini Deutschland GmbH" 
ENV PASSWORD ""
ENV ADMIN ""
ENV MAPGEN ""
ENV MODS false
