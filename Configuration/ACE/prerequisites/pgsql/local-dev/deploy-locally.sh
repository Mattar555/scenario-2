#!/bin/bash


deploy() {

  local docker_command=docker
  if ! command -v $docker_command &> /dev/null
  then
    local podman_command=podman
    echo "$docker_command could not be found. Trying podman.."
    if ! command -v $podman_command  &> /dev/null
    then
      echo "docker_command and podman_command not found. Please install one of them, then rerun this script"
      exit 1
    fi
    run_command $podman_command
  else
    run_command $docker_command
  fi

}

run_command() {

  local command=$1
  local name=postgres
  $command run -d \
	--name $name \
	-e POSTGRES_PASSWORD=postgrespw \
        -e POSTGRES_HOST_AUTH_METHOD=trust \
        -p 5432:5342 \
	$name
}

deploy
