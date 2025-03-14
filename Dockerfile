FROM python:3.9-slim

# Establish working folder
WORKDIR /app

# Setup dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copu service package
COPY service/ ./service/

# Create non-root user
RUN useradd --uid 1000 theia &&\ 
    chown -R theia /app
USER theia

# Run service on port 8080
EXPOSE 8080

CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]