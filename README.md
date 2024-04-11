Adding mods and other stuff to the official minetest docker image

Usage:

- add mods or other content to this repository
- build the docker image using 'docker build -t minetest4scrum/minetest-wrapper .'
- push the image to 'minetest4scrum' docker hub account

please note:
- if you change the name of the docker image in docker hub, then you also have to adjust the portainer template
- to prevent caching problems, please reload the new image in portainer