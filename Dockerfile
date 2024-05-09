# syntax=docker/dockerfile:1
# TODO: Test if pip-installed cuda wheels can work without using the bulky nvidia/cuda image.
FROM python:3.11-slim-bookworm

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
