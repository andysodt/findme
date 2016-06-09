from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic import TemplateView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^clients/', 'monitor.views.clients'),
    url(r'^$', TemplateView.as_view(template_name='dashboard.html')),
]
