from django.urls import path, include
from rest_framework.routers import DefaultRouter
from job_seeker.views.job_application import JobApplicationDetailViewSet, JobApplicationSeekerDetailViewSet, JobApplicationViewSet
from job_seeker.views.job_seeker_academic_qualifications import JobSeekerAcademicQualificationsViewSet
from job_seeker.views.job_seeker_attachment import JobSeekerAttachmentViewSet
from job_seeker.views.job_seeker_contact import JobSeekerContactViewSet
from job_seeker.views.job_seeker_experience_certificate import JobSeekerExperienceCertificateViewSet
from job_seeker.views.job_seeker_professional_certificate import JobSeekerProfessionalCertificateViewSet
from job_seeker.views.job_seeker_profile import JobSeekerProfileViewSet

router = DefaultRouter()
router.register(prefix='job_seeker_profile', viewset=JobSeekerProfileViewSet, basename='job_seeker_profile')
router.register(prefix='job_seeker_academic_qualifications', viewset=JobSeekerAcademicQualificationsViewSet, basename='job_seeker_academic_qualifications')
router.register(prefix='job_seeker_professional_certificate', viewset=JobSeekerProfessionalCertificateViewSet, basename='job_seeker_professional_certificate')
router.register(prefix='job_seeker_experience_certificate', viewset=JobSeekerExperienceCertificateViewSet, basename='job_seeker_experience_certificate')
router.register(prefix='job_seeker_contact', viewset=JobSeekerContactViewSet, basename='job_seeker_contact')
router.register(prefix='job_seeker_attachment', viewset=JobSeekerAttachmentViewSet, basename='job_seeker_attachment')
router.register(prefix='job_seeker_job_application', viewset=JobApplicationViewSet, basename='job_seeker_job_application')
router.register(prefix='job_application_detail', viewset=JobApplicationDetailViewSet, basename='job_application_detail')
router.register(prefix='job_application_seeker_detail', viewset=JobApplicationSeekerDetailViewSet, basename='job_application_seeker_detail')

urlpatterns = [
    path('', include(router.urls)),
]