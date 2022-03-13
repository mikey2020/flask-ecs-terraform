# syntax=docker/dockerfile:1
ARG FLASK_ENV
FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .
ARG FLASK_ENV
ENV FLASK_ENV=$FLASK_ENV

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
