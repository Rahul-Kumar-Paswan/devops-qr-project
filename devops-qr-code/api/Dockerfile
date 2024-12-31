FROM python:3.9
COPY . /app/
WORKDIR /app/
RUN pip install --no-cache-dir -r requirements.txt
ENV AWS_ACCESS_KEY=$AWS_ACCESS_KEY
ENV AWS_SECRET_KEY=$AWS_SECRET_KEY
CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80" ]