# Create the base image for build and test
FROM python:3.6-alpine as base
ENV FLASK_APP flasky.py
ENV FLASK_CONFIG production
RUN adduser -D flasky
USER flasky
WORKDIR /home/flasky
COPY requirements requirements
RUN python -m venv venv && \
    venv/bin/pip install -r requirements/docker.txt
COPY app app
COPY migrations migrations
COPY flasky.py config.py boot.sh ./

# Create an image for running tests
FROM base as test
RUN venv/bin/pip install -r requirements/common.txt && \
    venv/bin/pip install -r requirements/dev.txt
COPY tests tests
RUN venv/bin/flask test

# Create the final (minimal) image for deployment
FROM base
EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
