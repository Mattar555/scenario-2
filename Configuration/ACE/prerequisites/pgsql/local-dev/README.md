# README


## Usage

### Usage - Brew

 

### Usage - Docker

Run the script titled "docker-deploy-locally.sh" to run a containerised instance locally.:

That said, by default. It appears the PG HBA script only allows connections from the localhost. Meaning, one can only connect if you exec into the process space and attempt a psql connection. You might want to add the network host in the docker/podman run command as specified [here](https://docs.docker.com/engine/network/tutorials/host/#procedure)

If you attempt to connect from the outside (ie, a local script running on the host machine), it will NOT work, unlss you add network host to the docker run command or deploy a non containerised instance of PSQL, as discussed in the next section.


### Usage - Brew

Follow the step given [here](https://www.bytebase.com/blog/how-to-install-local-postgres-on-mac-ubuntu-centos-windows/) to run a local deployment of PSQL. Note no username and passwords are enforced via this minimal deployment:

```
brew services start postgresql
psql postgres
enter_commands_here
brew services stop postgresql
```

## Useful links

1) [Postgres Docker Image - Official](https://hub.docker.com/_/postgres)
2) [Run Postgres locally](https://www.bytebase.com/blog/how-to-install-local-postgres-on-mac-ubuntu-centos-windows/#homebrew)
3) [PSQL commands](https://stackoverflow.com/questions/769683/how-to-show-tables-in-postgresql)
4) [Python to PSQL](https://stackoverflow.com/questions/26496388/how-to-connect-python-to-postgresql)
5) [PG HBA](https://www.postgresql.org/docs/14/auth-pg-hba-conf.html)

