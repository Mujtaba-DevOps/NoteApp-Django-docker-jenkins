from django.urls import path, re_path
from .views import FrontendAppView

urlpatterns = [
    # Add any API routes here, e.g. path('api/', include('api.urls')),

    # Catch-all route to serve React frontend
    re_path(r'^.*$', FrontendAppView.as_view(), name='frontend'),
]
