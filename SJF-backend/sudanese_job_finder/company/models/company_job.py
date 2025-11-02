import uuid
from django.db import models
from django.conf import settings
from company.models.company_profile import CompanyProfile


class CompanyJob(models.Model):

    EXPLEVEL = [
        ('Entry-level', 'Entry-level'),
        ('Intermediate', 'Intermediate'),
        ('Senior', 'Senior')
    ]

    JOBTYPE = [
        ('fulltime', 'Full Time'),
        ('parttime', 'Part Time'),
        ('internship', 'Internship'),
    ]

    company_profile = models.ForeignKey(to=CompanyProfile, on_delete=models.CASCADE)
    job_title = models.CharField(max_length=50, null=True, blank=True)
    job_field = models.CharField(max_length=50, null=True, blank=True)
    job_description = models.TextField(null=True, blank=True)
    skills = models.TextField(null=True, blank=True)
    exp_level = models.CharField(max_length=20, choices=EXPLEVEL, default='Entry-level')
    job_type = models.CharField(max_length=20, choices=JOBTYPE, default='fulltime')
    salary = models.CharField(max_length=10, null=True, blank=True)
    deadline = models.DateTimeField(null=True, blank=True)
    # job_responsibilitie = models.TextField(null=True, blank=True)
    # job_required_expertise = models.TextField(null=True, blank=True)
    # job_preferred_expertise = models.TextField(null=True, blank=True)
    # start_at = models.DateTimeField(null=True, blank=True)
    # end_at = models.DateTimeField(null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_job_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_job_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.job_title if self.job_title else "Unnamed Role name"

    class Meta:
        db_table = 'company_job'