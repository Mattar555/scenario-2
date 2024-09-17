FROM python:3.12-slim-bookworm

RUN groupadd --gid 1000 appuser \
    && useradd --uid 1000 --gid 1000 -ms /bin/bash appuser

RUN pip3 install --no-cache-dir --upgrade \
    pip \
    virtualenv

RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common


USER appuser
WORKDIR /home/appuser

COPY . .
## PYTHONUNBUFFERED for testing purposes, remove before production.
ENV PYTHONUNBUFFERED=1
ENV VIRTUAL_ENV=/home/appuser/venv
RUN virtualenv ${VIRTUAL_ENV}
RUN . ${VIRTUAL_ENV}/bin/activate && pip install -r requirements.txt

EXPOSE 8501


COPY run.sh /home/appuser
ENTRYPOINT ["./run.sh"]