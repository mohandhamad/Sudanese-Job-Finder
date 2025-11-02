import uuid
from django.db import models
from django.conf import settings
# from django.contrib.auth.models import User
from job_seeker.models.job_seeker_profile import JobSeekerProfile


class JobSeekerExperienceCertificate(models.Model):
    job_seeker_profile = models.ForeignKey(to=JobSeekerProfile, on_delete=models.CASCADE, related_name='experience_certificates')
    experience_role = models.CharField(max_length=100, null=True, blank=True)
    start_date = models.DateField(null=True, blank=True)
    end_date = models.DateField(null=True, blank=True)
    job_duties = models.CharField(max_length=500, null=True, blank=True)
    implemented_projects = models.CharField(max_length=500, null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        # to=User,
        null=True,
        blank=True,
        related_name='job_seeker_experience_certificate_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        # to=User,
        null=True,
        blank=True,
        related_name='job_seeker_experience_certificate_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    
    class Meta:
        db_table = 'job_seeker_experience_certificate'
