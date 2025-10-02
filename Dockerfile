# ---------- FRONTEND BUILD ----------
FROM node:18 AS frontend
WORKDIR /app/frontend

# Copy package files and install dependencies
COPY frontend/package*.json ./
RUN npm install --unsafe-perm

# Copy frontend source code
COPY frontend/ ./

# Fix permissions for scripts like react-scripts
RUN chmod -R 755 /app/frontend/node_modules/.bin

# Build the React app
RUN npm run build

# ---------- BACKEND BUILD ----------
FROM python:3.11-slim AS backend
WORKDIR /app/backend

# Install Python dependencies
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend source code
COPY backend/ ./

# Copy built frontend into backend static files
COPY --from=frontend /app/frontend/build ./frontend_build

# Expose port (example: 8000 for Django)
EXPOSE 8000

# Command to run Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
