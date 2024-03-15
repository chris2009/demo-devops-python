from django.contrib import admin
from django.urls import include, path
from django.views import health_check

urlpatterns = [path("admin/", admin.site.urls), path("api/", include("api.urls")), path('health', health_check)]
