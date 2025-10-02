import os

# Define BASE_DIR first
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SECRET_KEY = "django-insecure-key"
DEBUG = True
ALLOWED_HOSTS = ["*"]

INSTALLED_APPS = [
    "django.contrib.staticfiles",
]

MIDDLEWARE = []

ROOT_URLCONF = "backend.urls"
WSGI_APPLICATION = "backend.wsgi.application"

# Path to frontend build folder
FRONTEND_BUILD_DIR = os.path.join(BASE_DIR, "frontend_build")

# Serve React build files as static
STATIC_URL = "/static/"
STATICFILES_DIRS = [os.path.join(FRONTEND_BUILD_DIR, "static")]

# Make templates point to React build
TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [FRONTEND_BUILD_DIR],
        "APP_DIRS": True,
        "OPTIONS": {"context_processors": []},
    }
]
