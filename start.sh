#!/bin/bash
echo "Starting Xvfb and Flask app..."
xvfb-run -a python app.py
