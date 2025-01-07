# Dockerfile
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy application code and requirements
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for the Flask app
EXPOSE 8080

# Command to run the app
CMD ["python", "Exercise-1.py"]
