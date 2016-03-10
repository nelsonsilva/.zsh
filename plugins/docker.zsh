docker-up() {
  docker-machine start $1 
  eval "$(docker-machine env $1)"
  echo "$1 machine ready at `docker-machine ip $1`"
}

docker-cleanup() {
  echo "Removing dead and exited containers"
  docker rm -v $(docker ps -a -q -f status=exited -f status=dead)
  echo "Removing dangling images"
  docker rmi $(docker images -q -f dangling=true)  
}
