import uuid
from django.db import models
from django.conf import settings
from company.models.company_job import CompanyJob
from job_seeker.models.job_seeker_profile import JobSeekerProfile
from job_seeker.models.job_application import JobApplication

class Interview(models.Model):
    STATUS_CHOICES = [
        ('Upcoming', 'Upcoming'),
        ('Done', 'Done'),
        ('Canceled', 'Canceled'),
    ]
    company_job = models.ForeignKey(CompanyJob, on_delete=models.CASCADE)
    job_seeker_profile = models.ForeignKey(JobSeekerProfile, on_delete=models.CASCADE)
    job_application = models.ForeignKey(JobApplication, on_delete=models.CASCADE)
    time = models.DateTimeField()
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Upcoming')

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='interview_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='interview_modified_by',
        on_delete=models.SET_NULL
    )
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'Interview for {self.job_seeker_profile} on {self.time}'

    class Meta:
        db_table = 'interview'