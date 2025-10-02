import os

# Path to frontend build folder
FRONTEND_BUILD_DIR = os.path.join(BASE_DIR, "frontend_build")

# Serve React build files as static
STATICFILES_DIRS = [os.path.join(FRONTEND_BUILD_DIR, "static")]
TEMPLATES[0]["DIRS"] = [FRONTEND_BUILD_DIR]
