# Use the official Python 3.9 Alpine image as the base image.
# Alpine Linux is a lightweight, security-oriented distribution.
FROM python:3.9-alpine3.13

# Set the maintainer label to provide information about the author.
LABEL maintainer="Lewis Benson"

# Set the environment variable PYTHONUNBUFFERED to ensure that
# Python runs in unbuffered mode, which is recommended for
# containerized applications as it can improve performance.
ENV PYTHONUNBUFFERED 1

# Copy the requirements.txt file to a temporary directory in the
# container, which will be used later to install the required
# Python packages.
COPY ./requirements.txt /tmp/requirements.txt

# Copy the Django app code to the /app directory in the container.
COPY ./app /app

# Copy the dev dependencies to the directory in the container.
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Set the working directory to /app, where the application code
# is located in the container.
WORKDIR /app

# Expose port 8000, the default port for Django applications,
# so it can be accessed from outside the container.
EXPOSE 8000

# Create a virtual environment to isolate the Python dependencies,
# install the required packages using the copied requirements.txt,
# delete the temporary directory, and create a non-root user
# called "django-user" without a home directory.

#Overrides the docker-compose ARG for Dev=True putting the application in production mode
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Add the virtual environment binaries to the PATH environment
# variable, ensuring that the installed packages are used when
# running Python commands.
ENV PATH="/py/bin:$PATH"

# Switch to the non-root user "django-user" to run the Django app,
# following best practices for running containerized applications.
USER django-user
