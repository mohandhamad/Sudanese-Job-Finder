from rest_framework import serializers
from job_seeker.models.job_application import JobApplication


class JobSeekerJobApplicationSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobApplication
        fields = [
            'id',
            'job',
            'job_seeker',
            'status',
            'created_at',
            'updated_at'
        ]