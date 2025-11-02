from django.contrib import admin
from django.urls import path, include
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from django.conf import settings
from django.conf.urls.static import static
from account.views import CustomTokenObtainPairView, account_data

schema_view = get_schema_view(
    openapi.Info(
        title="SJF API",
        default_version='v2',
        description="Sudanese Job Finder is a web application designed to take the hassle out of job hunting. "
                    "Leveraging advanced algorithms, it matches job seekers with the most relevant opportunities "
                    "based on their skills, experiences, and preferences, "
                    "making the search for the perfect job faster and more efficient.",
        terms_of_service="https://www.sjf.com/policies/terms/",
        contact=openapi.Contact(email="sudanessjobfinder@gmail.com"),
        license=openapi.License(name="SJF License"),
    ),
    public=True,
    permission_classes=[permissions.AllowAny]
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/account/', include('account.urls')),
    path('api/company/', include('company.urls')),
    path('api/job_seeker/', include('job_seeker.urls')),
     path('api/lookup_data/', include('lookup_data.urls')),
    path('api/account/login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/account/account_data/', account_data, name='account_data'),

    path('', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
