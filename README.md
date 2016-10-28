# AWS ECS Rippled

A dockerized implementation of the deployment of rippled to the AWS ECS service.


## Configuration

Initialize the scripts submodule, copy the `env.sh.example` script, then edit to match your AWS settings.

Download the latest [example `rippled.cfg`](https://github.com/ripple/rippled/blob/develop/doc/rippled-example.cfg) from the [rippled project](https://github.com/ripple/rippled).


## Execution

Before executing the scripts, edit the `env.sh` file and run the following:

```bash
source env.sh
```


### Build a docker image

```bash
./scripts/docker_build.sh
```

### Run the docker image locally
```bash
./scripts/docker_run.sh
asdf...hjkl
docker run -ti asdf...hjkl
```

### Deploy to your AWS ECS environment

Assuming you have your ECS cluster, task definition, and service configured, run the following:

```bash
./scripts/docker_deploy.sh
```


## Contributing

Feel free to fork and issue a pull request.  You may also submit an issue if you need support or have an idea for feature enhancement.


## Author

[Bobby Larson](http://bobby.social)


```bash
exit 0
```
