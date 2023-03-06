# AMM-converter-docker

Dockerized Ammconverter from ammconverter.eu for the ammc-amb executable.
Only fit for the linux64 build right now.

Accepts the TZ environment variable to set the timezone of the container.
If the '-w' argument is used to expose a websocket connection, don't forget to expose the docker port.
Specify the 'args' argument while creating the container to pass arguments to the ammc-amb executable:

```
docker run
  -d
  --name='ammconverter'
  --net='bridge'
  -e TZ="America/Los_Angeles"
  -e 'ARGS'='
  --db postgresql://username:password@DB:5432/postgres
  -t
  -w 8000 192.168.1.5 '
  -p '8000:8000/tcp'
  -p '8000:8000/udp'
  'gilliangoud/ammconverter'
```