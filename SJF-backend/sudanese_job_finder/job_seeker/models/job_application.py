import uuid
from django.db import models
from django.conf import settings
from company.models.company_job import CompanyJob
from job_seeker.models.job_seeker_profile import JobSeekerProfile
from lookup_data.models.lookup_data_application_status import LookupDataApplicationStatus


class JobApplication(models.Model):
    job_seeker_profile = models.ForeignKey(to=JobSeekerProfile, on_delete=models.PROTECT)
    company_job = models.ForeignKey(to=CompanyJob, on_delete=models.PROTECT)
    application_status = models.ForeignKey(to=LookupDataApplicationStatus, null=True, on_delete=models.SET_NULL)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_date = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_date = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_application_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_application_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)


    class Meta:
        db_table = 'job_application'