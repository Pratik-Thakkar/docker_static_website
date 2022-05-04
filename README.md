## MkDocs in a docker

MkDocs is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration file.

------
### Author
+ Pratik Thakkar

------
### Usage

##### Build docker image
```
$ docker build . -t pthakkar/mkdocs
```

##### Run as a development server in background. Should allow you to view the site on http://localhost:8000
```
$ docker run -d -v /path/to/src:/docs/src pthakkar/mkdocs serve
```

##### Build the MkDocs documentation and generate a tar file
```
$ docker run -t --rm -v /path/to/src:/docs/src -v /path/to/output:/docs/output pthakkar/mkdocs produce
```

------
### Automated Validation using Jenkins pipeline and Goss

We’ll be using [Goss](https://github.com/aelsabbahy/goss) as the testing tool of choice. The installation is simple and only takes a few seconds.

```
curl -fsSL https://goss.rocks/install | sh
```

###### What is Goss?

Goss is a YAML based serverspec alternative tool for validating a server’s configuration. It eases the process of writing tests by allowing the user to generate tests from the current system state. Once the test suite is written they can be executed, waited-on, or served as a health endpoint.

**Note:** For testing docker containers see the [dgoss](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss) wrapper.

**Note:** Once installtion is completed create an environment variable [GOSS_FILES_PATH](https://github.com/aelsabbahy/goss/tree/master/extras/dgoss#goss_files_path) specifying goss.yaml path.

------