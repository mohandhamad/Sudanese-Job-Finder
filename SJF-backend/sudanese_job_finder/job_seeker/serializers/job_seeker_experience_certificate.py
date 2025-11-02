from rest_framework import serializers
from job_seeker.models.job_seeker_experience_certificate import JobSeekerExperienceCertificate


class JobSeekerExperienceCertificateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeekerExperienceCertificate
        fields = [
            'id',
            'job_seeker_profile',
            'experience_role',
            'start_date',
            'end_date',
            'job_duties',
            'implemented_projects',
            'created_by',
            'modified_by',
            'is_delete'
        ]