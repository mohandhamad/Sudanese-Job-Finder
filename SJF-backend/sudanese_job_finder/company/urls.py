from django.urls import path, include
from rest_framework.routers import DefaultRouter
from company.views.company_job import CompanyJobViewSet, CompanyJobDetailViewSet, JobRecommendationViewSet
from company.views.company_profile import CompanyProfileViewSet
from company.views.company_images import CompanyImagesViewSet
from company.views.interview import InterviewViewSet
from company.views.job_views import JobViewViewSet


router = DefaultRouter()
router.register(prefix='company_profile', viewset=CompanyProfileViewSet, basename='company_profile')
router.register(prefix='company_job', viewset=CompanyJobViewSet, basename='company_job')
router.register(prefix='company_images', viewset=CompanyImagesViewSet, basename='company_images')
router.register(prefix='company_job_detail', viewset=CompanyJobDetailViewSet, basename='company_job_detail')
router.register(prefix='job_recommended', viewset=JobRecommendationViewSet, basename='job_recommended')
router.register(prefix='interviews',viewset= InterviewViewSet)
router.register(prefix='job_views', viewset=JobViewViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
