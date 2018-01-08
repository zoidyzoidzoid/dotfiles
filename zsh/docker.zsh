function docker-tidy () {
  docker rmi $(docker images -q --filter "dangling=true")
  docker rm -v $(docker ps -a -q)
  docker volume rm $(docker volume ls -qf dangling=true)
}
