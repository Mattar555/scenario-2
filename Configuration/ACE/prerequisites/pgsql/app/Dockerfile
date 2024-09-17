FROM python:3.12-slim-bookworm
WORKDIR /code
COPY requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./ /code/app
EXPOSE 8000
CMD ["python3", "app/main.py"]