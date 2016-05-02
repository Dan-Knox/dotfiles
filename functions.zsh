function enable_docker() {
  eval `docker-machine env $@`
}
