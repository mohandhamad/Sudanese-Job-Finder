from rest_framework import serializers
from company.serializers.company_images import CompanyImagesSerializer
from company.serializers.company_job import CompanyJobSerializer
from company.serializers.company_profile import CompanyProfileSerializer
from job_seeker.models.job_application import JobApplication
from job_seeker.serializers.job_seeker_academic_qualifications import JobSeekerAcademicQualificationsSerializer
from job_seeker.serializers.job_seeker_attachment import JobSeekerAttachmentSerializer
from job_seeker.serializers.job_seeker_contact import JobSeekerContactSerializer
from job_seeker.serializers.job_seeker_experience_certificate import JobSeekerExperienceCertificateSerializer
from job_seeker.serializers.job_seeker_professional_certificate import JobSeekerProfessionalCertificateSerializer
from job_seeker.serializers.job_seeker_profile import JobSeekerProfileSerializer
from lookup_data.serializers.lookup_data_application_status import LookupDataApplicationStatusSerializer


class JobApplicationSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobApplication
        fields = [
            'id',
            'job_seeker_profile',
            'company_job',
            'application_status',
            'created_by',
            'modified_by',
            'is_delete'
        ]


class JobApplicationDetailSerializer(serializers.ModelSerializer):
    company_job = CompanyJobSerializer()
    application_status = LookupDataApplicationStatusSerializer()
    company_profile = CompanyProfileSerializer(source='company_job.company_profile')
    company_images = CompanyImagesSerializer(many=True, source='company_job.company_profile.company_images')
    
    class Meta:
        model = JobApplication
        fields = [
            'id',
            'job_seeker_profile',
            'company_job',
            'application_status',
            'created_by',
            'modified_by',
            'is_delete',
            'company_profile',
            'company_images'
        ]


class JobApplicationSeekerDetailSerializer(serializers.ModelSerializer):
    company_job = CompanyJobSerializer()
    job_seeker_profile = JobSeekerProfileSerializer()
    application_status = LookupDataApplicationStatusSerializer()
    job_seeker_contact = JobSeekerContactSerializer(many=True, source='job_seeker_profile.contacts')
    job_seeker_experience_certificate = JobSeekerExperienceCertificateSerializer(many=True, source='job_seeker_profile.experience_certificates')
    job_seeker_academic_qualifications = JobSeekerAcademicQualificationsSerializer(many=True, source='job_seeker_profile.academic_qualifications')
    job_seeker_professional_certificate = JobSeekerProfessionalCertificateSerializer(many=True, source='job_seeker_profile.professional_certificates')
    job_seeker_attachment = JobSeekerAttachmentSerializer(many=True, source='job_seeker_profile.attachments')

    class Meta:
        model = JobApplication
        fields = [
            'id',
            'job_seeker_profile',
            'company_job',
            'application_status',
            'created_by',
            'modified_by',
            'is_delete',
            'job_seeker_contact',
            'job_seeker_experience_certificate',
            'job_seeker_academic_qualifications',
            'job_seeker_professional_certificate',
            'job_seeker_attachment'
        ]
