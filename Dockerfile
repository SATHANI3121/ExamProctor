# Use a base image with Python 3.10
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3-dev \
    pkg-config \
    libmariadb-dev-compat \
    xvfb \
    x11-utils \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir face_recognition pyautogui

# Copy the full application
COPY . .

#COPY start.sh .
#CMD ["./start.sh"]

CMD ["python", "app.py"]

# Expose the Flask port
EXPOSE 5000

