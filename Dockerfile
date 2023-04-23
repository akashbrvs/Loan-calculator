FROM python:3.11.3-alpine3.16

RUN COPY . .

RUN pip install -r requirements.txt

CMD [ "python3", "./app.py", "runserver", "0.0.0.0:8000" ]

