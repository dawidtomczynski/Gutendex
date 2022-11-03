from python:3.9
COPY ./project /project
WORKDIR /project
RUN pip install -r requirements.txt
RUN rm -r static
ENTRYPOINT python3 manage.py runserver 0.0.0.0:8000
