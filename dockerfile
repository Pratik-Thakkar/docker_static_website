FROM python:alpine3.15
RUN apk add --no-cache python3 python3-dev py3-pip

#COPY requirements.txt .

RUN pip install mkdocs pygments && rm -rf $HOME/.cache/pip

WORKDIR /docs

COPY mkdockerize.sh  /usr/local/bin/
RUN chmod +x /usr/local/bin/mkdockerize.sh

ENTRYPOINT [ "mkdockerize.sh" ]

EXPOSE 8000

CMD [ "help" ]