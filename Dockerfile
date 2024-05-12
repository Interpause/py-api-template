# syntax=docker/dockerfile:1
# NOTE: Docker's GPU support works for most images despite common misconceptions.
FROM python:3.11-slim-bookworm
# Example of prebuilt pytorch image to save download time.
#FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

COPY --link . /app
WORKDIR /app

RUN pip3 install --no-cache-dir .

EXPOSE 3000
CMD [ \
  "gunicorn", \
  "--worker-class=uvicorn.workers.UvicornWorker", \
  "--bind=0.0.0.0:3000", \
  "py_api_template:app" \
  ]
