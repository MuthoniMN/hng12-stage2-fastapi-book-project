# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI application code
COPY ./ ./

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/sites-available/default

# Expose the port for NGINX
EXPOSE 80

# Start NGINX and the FastAPI app using Uvicorn
CMD service nginx start && uvicorn ./main:app --host 0.0.0.0 --port 8000 --reload
