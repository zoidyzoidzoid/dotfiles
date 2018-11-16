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
