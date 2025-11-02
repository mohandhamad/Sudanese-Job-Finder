import uuid
from django.db import models
from django.conf import settings
from job_seeker.models.job_seeker_profile import JobSeekerProfile


class JobSeekerAttachment(models.Model):
    job_seeker_profile = models.ForeignKey(to=JobSeekerProfile, on_delete=models.CASCADE, related_name='attachments')
    job_seeker_attachment_type = models.CharField(max_length=255, null=True, blank=True)
    file_data = models.BinaryField()

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_date = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_date = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        # to=User,
        null=True,
        blank=True,
        related_name='job_seeker_attachment_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        # to=User,
        null=True,
        blank=True,
        related_name='job_seeker_attachment_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.job_seeker_attachment_type if self.job_seeker_attachment_type else "Unnamed Attachment Type"

    class Meta:
        db_table = 'job_seeker_attachment'
