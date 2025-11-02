from rest_framework import serializers
from company.models.company_images import CompanyImages
from company.models.company_job import CompanyJob
from company.serializers.company_images import CompanyImagesSerializer
from company.serializers.company_profile import CompanyProfileSerializer


class CompanyJobSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyJob
        fields = [
            'id',
            'company_profile',
            'job_title',
            'job_field',
            'job_description',
            'skills',
            'exp_level',
            'job_type',
            'salary',
            'deadline',
            'created_by',
            'modified_by',
            'is_delete'
        ]

    
class CompanyJobDetailSerializer(serializers.ModelSerializer):
    company_profile = CompanyProfileSerializer()
    company_images = CompanyImagesSerializer(many=True, source='company_profile.company_images')

    class Meta:
        model = CompanyJob
        fields = [
            'id',
            'company_profile',
            'company_images',
            'job_title',
            'job_field',
            'job_description',
            'skills',
            'exp_level',
            'job_type',
            'salary',
            'deadline',
            'created_by',
            'modified_by',
            'is_delete'
        ]

