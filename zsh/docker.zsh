#!/usr/bin/env zsh

function docker-tidy () {
  docker rmi $(docker images -q --filter "dangling=true")
  docker rm -v $(docker ps -a -q)
  docker volume rm $(docker volume ls -qf dangling=true)
}

function img () {
  docker run --rm -it \
      --name img \
      --volume "$(pwd)":/home/user/src:ro \
      --workdir /home/user/src \
      --volume "${HOME}/.docker:/root/.docker:ro" \
      --privileged \
      r.j3ss.co/img
}

function docker-tags () {
  # https://stackoverflow.com/questions/28320134/how-to-list-all-tags-for-a-docker-image-on-a-remote-registry
  if [ $# -lt 1 ]; then
    cat << HELP
docker-tags  --  list all tags for a Docker image on a remote registry.

EXAMPLE:
    - list all tags for ubuntu:
       dockertags ubuntu

    - list all php tags containing apache:
       dockertags php apache

HELP
  fi

  image="$1"
  tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`

  if [ -n "$2" ]
  then
      tags=` echo "${tags}" | grep "$2" `
  fi

  echo "${tags}"
}
