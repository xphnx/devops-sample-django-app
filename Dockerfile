FROM python:3.8-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y gcc build-essential

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN pip install uwsgi

ENV DJANGO_DB_HOST=db
ENV DJANGO_DB_NAME=app
ENV DJANGO_DB_USER=worker
ENV DJANGO_DB_PASS=worker
ENV DJANGO_DB_PORT=5432
ENV DJANGO_DEBUG=False

EXPOSE 8000

COPY . .

CMD ["uwsgi", "--init", "uwsgi.ini"]