# Use a base image with Python 3.10
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies (needed for numpy, dlib, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirement files and wheel
COPY requirements.txt .
COPY dlib-19.22.99-cp310-cp310-win_amd64.whl .

# Install dlib from the local wheel first
RUN pip install dlib-19.22.99-cp310-cp310-win_amd64.whl

# Then install remaining requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .

# Expose the port (Flask default)
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
