FROM python:3.11.3-alpine3.16
LABEL MAINTAINER="Akash"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
RUN python3 -m pytest --cov

RUN adduser -u 5936 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8080" ]
EXPOSE 8080

