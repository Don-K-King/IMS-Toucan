FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libsndfile1 \
        espeak-ng \
        ffmpeg \
        libasound2-dev \
        libportaudio2 \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN python -m pip install --no-cache-dir -r /app/requirements.txt

COPY . /app

RUN useradd -m -u 10001 appuser \
    && chown -R appuser:appuser /app

USER appuser
