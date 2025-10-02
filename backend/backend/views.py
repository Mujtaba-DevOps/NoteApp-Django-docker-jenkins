from django.views.generic import View
from django.http import HttpResponse
import os

class FrontendAppView(View):
    def get(self, request, *args, **kwargs):
        try:
            # Path to React build's index.html
            index_file_path = os.path.join(
                os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                'frontend', 'build', 'index.html'
            )
            with open(index_file_path) as f:
                return HttpResponse(f.read())
        except FileNotFoundError:
            return HttpResponse(
                "React build not found. Run 'npm run build' in frontend.",
                status=501,
            )
