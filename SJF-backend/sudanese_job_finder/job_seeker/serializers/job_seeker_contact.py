from job_seeker.models.job_seeker_contact import JobSeekerContact
from rest_framework import serializers


class JobSeekerContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeekerContact
        fields = [
            'id',
            'job_seeker_profile',
            'type',
            'contact_number',
            'created_by',
            'modified_by',
            'is_delete',
        ]