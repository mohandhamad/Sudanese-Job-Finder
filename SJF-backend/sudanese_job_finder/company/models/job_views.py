from django.db import models
from company.models.company_job import CompanyJob
from job_seeker.models.job_seeker_profile import JobSeekerProfile

class JobView(models.Model):
    company_job = models.ForeignKey(CompanyJob, on_delete=models.CASCADE)
    job_seeker = models.ForeignKey(JobSeekerProfile, on_delete=models.CASCADE)
    viewed_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.job_seeker} viewed {self.company_job}'

    class Meta:
        db_table = 'job_view'