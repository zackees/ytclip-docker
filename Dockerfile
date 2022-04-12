# FROM ubuntu:22.04
FROM python:3.10-slim-bullseye

# Might be necessary.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Setup the image
#RUN apt-get update
# Ubuntu:22.04 uses python 3.10
#RUN apt-get install -y python-is-python3 python3-pip

WORKDIR /app

# Install all the dependencies as it's own layer.
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Force the download of the static_ffmpeg executable.
RUN static_ffmpeg -version

# Add requirements file and install.
COPY . .

RUN python -m pip install -e .

# Expose the port and then launch the app.
EXPOSE 80

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "80", "ytclip_server.app:app"]
