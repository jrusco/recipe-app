FROM python:3.7-alpine

# Don't allow python to buffer the outputs (recommended when working with Python Docker images)
ENV PYTHONUNBUFFERED 1
# Copy the list of dependencies to the container
COPY ./requirements.txt /requirements.txt
# Install the dependencies
RUN pip install -r /requirements.txt

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
