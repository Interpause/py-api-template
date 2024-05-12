# syntax=docker/dockerfile:1
# NOTE: Docker's GPU support works for most images despite common misconceptions.
FROM python:3.11-slim-bookworm
# Example of prebuilt pytorch image to save download time.
#FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

COPY --link . /app
WORKDIR /app

# Cache packages to speed up builds, see: https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypecache
# Example:
# RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
#   echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
# RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
#   --mount=type=cache,target=/var/lib/apt,sharing=locked \
#   apt-get update && apt-get install -y vim

RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
  pip install .

EXPOSE 3000
CMD [ \
  "gunicorn", \
  "--worker-class=uvicorn.workers.UvicornWorker", \
  "--bind=0.0.0.0:3000", \
  "py_api_template:app" \
  ]
