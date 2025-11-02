from rest_framework import serializers
from job_seeker.models.job_seeker_professional_certificate import JobSeekerProfessionalCertificate


class JobSeekerProfessionalCertificateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeekerProfessionalCertificate
        fields = [
            'id',
            'job_seeker_profile',
            'type',
            'mark',
            'exam_date',
            'created_by',
            'modified_by',
            'is_delete',
        ]