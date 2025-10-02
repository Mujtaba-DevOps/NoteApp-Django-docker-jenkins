# -----------------------------
# Step 1: Build React Frontend
# -----------------------------
FROM node:18 AS frontend

WORKDIR /app/frontend

# Copy package files and install dependencies
COPY frontend/package*.json ./
RUN npm install

# Copy all frontend source and build
COPY frontend/ ./
RUN npm run build

# -----------------------------
# Step 2: Django Backend + Serve React
# -----------------------------
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Create non-root user (optional, safer)
RUN useradd -m appuser
USER appuser

# Copy backend requirements and install dependencies
COPY --chown=appuser:appuser backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy Django backend code
COPY --chown=appuser:appuser backend/ ./backend/

# Copy React build into Django staticfiles folder
COPY --from=frontend --chown=appuser:appuser /app/frontend/build ./staticfiles/

# Collect static files
RUN python backend/manage.py collectstatic --noinput

# Expose Django port
EXPOSE 8000

# Start Gunicorn server
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]
