FROM python:2.7-stretch
RUN pip install flask
COPY free_flag_no_catch.py ./
COPY templates ./templates/
CMD [ "python", "./free_flag_no_catch.py" ]
