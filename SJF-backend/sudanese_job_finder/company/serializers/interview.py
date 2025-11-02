from rest_framework import serializers
from company.models.interview import Interview
from company.serializers.company_job import CompanyJobSerializer
from job_seeker.serializers.job_seeker_profile import JobSeekerProfileSerializer
from job_seeker.serializers.job_application import JobApplicationSerializer

class InterviewSerializer(serializers.ModelSerializer):
    company_job = CompanyJobSerializer()
    job_seeker_profile = JobSeekerProfileSerializer()
    job_application = JobApplicationSerializer()

    class Meta:
        model = Interview
        fields = [
            'id',
            'company_job',
            'job_seeker_profile',
            'job_application',
            'time',
            'status',
            'created_by',
            'modified_by',
            'created_at',
            'modified_at'
        ]