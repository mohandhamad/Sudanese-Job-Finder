from django.urls import path, include
from rest_framework.routers import DefaultRouter
from lookup_data.views.lookup_data_application_status import LookupDataApplicationStatusViewSet


router = DefaultRouter()
router.register(prefix='application-status', viewset=LookupDataApplicationStatusViewSet, basename='application-status')
# router.register(prefix='country', viewset=LookupDataCountryListViewSet, basename='country')
# router.register(prefix='language', viewset=LookupDataLanguageListViewSet, basename='language')
# router.register(prefix='employment_type', viewset=EmploymentTypeViewSet, basename='employment_type')

# pprint(router.urls)

urlpatterns = [
    path('', include(router.urls)),
]