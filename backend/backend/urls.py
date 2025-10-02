from django.urls import path
from django.http import HttpResponse

def home(request):
    return HttpResponse("Hello from Django backend!")

urlpatterns = [
    path("", home),
]
