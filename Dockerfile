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

WORKDIR /app

# Copy backend requirements and install dependencies as root
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy Django backend code
COPY backend/ ./backend/

# Copy React build from frontend stage
COPY --from=frontend /app/frontend/build ./staticfiles/

# Create non-root user and switch to it
RUN useradd -m appuser
USER appuser

# Collect static files (run as non-root)
RUN python backend/manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]
