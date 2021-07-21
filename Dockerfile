FROM python:3.7-alpine

# Don't allow python to buffer the outputs (recommended when working with Python Docker images)
ENV PYTHONUNBUFFERED 1
# Copy the list of dependencies to the container
COPY ./requirements.txt /requirements.txt
# Use the package manager from Alpine to install the pg client
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
# Install the dependencies
RUN pip install -r /requirements.txt
# delete temp reqs
RUN apk del .tmp-build-deps

# Create a folder
RUN mkdir /app
# set it up as the working directory
WORKDIR /app
# copy the contents of the project into the container's working directory
COPY ./app /app

# Create the user that'll run the application in the container
RUN adduser -D user
# switch to the newly created user, so Docker runs the app using this and not "root", which is not recommended.
USER user
