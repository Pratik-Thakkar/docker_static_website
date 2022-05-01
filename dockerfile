FROM python:alpine3.15
RUN apk add --no-cache python3 python3-dev py3-pip

COPY requirements.txt .

RUN pip install -r requirements.txt && rm -rf $HOME/.cache/pip

WORKDIR /mkdocs

EXPOSE 8000

CMD [ "mkdocs", "serve", "--dev-addr", "0.0.0.0:8000" ]