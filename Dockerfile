FROM python:alpine3.15
RUN apk add --no-cache \
      build-base curl wget make bash \
      python3 python3-dev py3-pip                                                 

## Install the mkdocs system
RUN pip install mkdocs pygments \
      && rm -rf "$HOME/.cache"

## Set working directory for mkdocs
WORKDIR /docs/src

## Output directory for mkdocs tar file
VOLUME /docs/output

## Copy our scripts and make sure they are executable
COPY mkdockerize.sh  /usr/local/bin/
RUN chmod +x /usr/local/bin/mkdockerize.sh

## Define our Entrypoint script
ENTRYPOINT ["mkdockerize.sh"]

## Expose MkDocs development server port
EXPOSE 8000

## The default command for the entrypoint script, show the help message
CMD ["help"]