From python:3.9-slim
WORKDIR /app
COPY main.py .
Run pip install fastapi uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]