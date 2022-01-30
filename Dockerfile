FROM python:3.9-slim-buster

ADD requirements.txt /tmp/
RUN pip install -U pip
RUN pip install --no-cache-dir -U -r /tmp/requirements.txt

RUN useradd -u 10001 playground && mkdir -p /home/playground
WORKDIR /home/playground/
COPY . .
  
USER playground

ENV PYTHONPATH="/home/playground/:${PYTHONPATH}"
CMD ["python", "playground.py"]
