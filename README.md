# docker-tripod

Docker container with preinstalled dependencies for developing [tripod-php](https://github.com/talis/tripod-php).

## Usage

The following assumes you're running on linux or OSX, and know how to drop into a bash terminal:

0. Clone [tripod-php](https://github.com/talis/tripod-php) into a local directory, which we'll call `/path/to/host/tripod-php`;
0. Clone this repository into some other location. We assume this will be your working directory;
0. Build the docker container: 

  `docker build -t docker-tripod .`
  
0. This should create a named image, which you can run with a volume mapping to your `TRIPOD_PHP_DIR` directory:

  `docker run -it  -v /path/to/host/tripod-php:/talis/tripod-php docker-tripod`

0. This should drop you into a shell with everything installed, and your services (`mongod` and `redis-server`) started;
0. Get started with Tripod-php:

  `ant init`

0. Run the tripod-php tests:

  `ant test`

You should now be able to change the files on your host machine, and run all the tests in your Docker container, 
with dependent services running as required.

## Troubleshooting

### Bad volume mappings

Once you're in your Docker container, you should be dropped into the `/talis/tripod-php`. 
If you've correctly mapped your host `/path/to/host/tripod-php`, you should be able to view the README:

  `less README.md`
  
If you can't do this, check your volume mapping in the `docker run ...` command, above.

### Services not running

Once you're in your Docker container, you should have both `mongod` and `redis-server` running as daemon processes.
You can check this using:

  `ps ax`

where you should see both processes running.  If not, something has gone screwy. 
Try rerunning `/usr/bin/run-tripod-services.sh` from within the Docker container.

### Your tests aren't passing

If you've made changes, you're on your own...
