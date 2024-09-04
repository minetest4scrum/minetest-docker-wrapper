Adding mods and other stuff to the official minetest docker image

Usage:

- add mods or other content to this repository
- build the docker image using 'docker buildx build -t minetest4scrum/minetest-wrapper:5.9.0 --no-cache --rm .'
- push the image to 'minetest4scrum' docker hub account

please note:
- if you change the name of the docker image in docker hub, then you also have to adjust the portainer template
- to prevent caching problems, please reload the new image in portainer

Content:

| folder | description |
|--------|-------------|
| root | contains scripts which are executed at the startup of the container |
| mods | contains additional mods which will be copied by the init scripts to the games folder |
| games | contains for each predefined game a seperate folder, 'tutorial' comes from minetest ContentDB, 'minetest_game' is a git clone of a default game |

see https://github.com/just-containers/s6-overlay?tab=readme-ov-file#init-stages for init scripts

How it all fits together:

In the built container you can find the following: 
- in /etc/cont-init.d/ init scripts with
-- 40-config-env : replaces/appends configuration strings in a file and copy it to 'minetest_game'
-- 50-copy-mods : copys the mods located in /home/mods to 'minetest_game' mods folder
- /config/.minetest/games/ contains the minetest games which can be selected by command line argument '--gameid' 

Environment variables

| Variable name | default value | description |
|--------|-------------|-------------|
| SERVER_NAME | Minetest@Capgemini | Any name which you want | 
| MOTD | Welcome to the training | message of the day |
| MAX_USERS | 50 | maximum allowed users for the server, tested up to 80 |
| SERVER_DESCRIPTION |  Minetest Server für Trainings bei Capgemini Deutschland GmbH | Any description |
| PASSWORD | empty string | Password to enter the game, should be set |
| ADMIN | empty string | Name of the admin user |
| MAPGEN | empty string | configuration string for the map, e.g. v7 |
| CLI_ARGS | --gameid tutorial --port 30000 | command line arguments for the minetest server, replace 'tutorial' with the gameid, same as the folder name in /config/.minetest/games |
| GAME | tutorial | gameid, same as the folder in /config/.minetest/games |

Example docker configuration for 'tutorial': 

```
docker run -d \
  --name=minetest \
  -e SERVER_NAME="Minetest@Capgemini" \
  -e MOTD="Training 02.09.2024" \
  -e MAX_USERS=80 \
  -e PASSWORD="complexPassword" \
  -e ADMIN="TrainerName" \
  -e CLI_ARGS="--gameid tutorial --port 30000" \
  -e GAME="tutorial" \
  -p 30000:30000/udp \
  --restart unless-stopped \
  minetest4scrum/minetest-wrapper:5.9.0
  ```

Example docker configuration for 'minetest_game': 

```
docker run -d \
  --name=minetest \
  -e SERVER_NAME="Minetest@Capgemini" \
  -e MOTD="Training 02.09.2024" \
  -e MAX_USERS=80 \
  -e PASSWORD="complexPassword" \
  -e ADMIN="TrainerName" \
  -e MAPGEN="v7" \
  -e CLI_ARGS="--gameid minetest_game --port 30000" \
  -e GAME="minetest_game" \
  -p 30000:30000/udp \
  --restart unless-stopped \
  minetest4scrum/minetest-wrapper:5.9.0
  ```