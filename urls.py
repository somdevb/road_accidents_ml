from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name = 'index'), 
    #tells django to execute index function of views.py
    path('processed', views.processed, name = 'processed'),
    path('hello', views.hello, name = 'hello'),
    path('form', views.form, name = 'form'),
    path('map11', views.map, name = 'map11'),
    path('form2', views.coor, name = 'form2'),
    path('report', views.report, name = 'report'),
    path('thanks', views.thanks, name = 'thanks'),
]