import uuid
from django.db import models
from django.conf import settings
from job_seeker.models.job_seeker_profile import JobSeekerProfile


class JobSeekerProfessionalCertificate(models.Model):
    job_seeker_profile = models.ForeignKey(to=JobSeekerProfile, on_delete=models.CASCADE, related_name='professional_certificates')
    type = models.CharField(max_length=50, null=True, blank=True)
    mark = models.CharField(max_length=50, null=True, blank=True)
    exam_date = models.DateField(null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_seeker_professional_certificate_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_seeker_professional_certificate_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.type if self.type else "Unnamed Type"

    class Meta:
        db_table = 'job_seeker_professional_certificate'
