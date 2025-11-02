from rest_framework import serializers
from company.models.company_profile import CompanyProfile
from django.core.files.storage import default_storage
import os
import uuid


class CompanyProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyProfile
        fields = [
            'id',
            'company_name',
            'image',
            'mobile',
            'description',
            'web_site',
            'created_by',
            'modified_by',
            'is_delete'
        ]
    
    def update(self, instance, validated_data):
        if 'mobile' in validated_data:
            mobile = validated_data['mobile']
            existing_profiles = CompanyProfile.objects.filter(mobile=mobile)
            existing_profiles = existing_profiles.exclude(pk=instance.pk)
            if existing_profiles.exists():
                raise serializers.ValidationError("Mobile number must be unique.")
        if 'image' in validated_data and instance.image:
            image_path = instance.image.path
            if default_storage.exists(image_path):
                default_storage.delete(image_path)
        return super().update(instance, validated_data)
    
    def validate_image(self, value):
        if value:
            filename = value.name
            if self.instance and self.instance.image:
                current_image_name = self.instance.image.name
                if current_image_name != filename:
                    unique_filename = self.get_unique_filename(filename)
                    value.name = unique_filename
            else:
                unique_filename = self.get_unique_filename(filename)
                value.name = unique_filename
        return value
    
    def get_unique_filename(self, filename):
        unique_identifier = uuid.uuid4().hex[:6]
        file_extension = os.path.splitext(filename)[1]
        unique_filename = f"{unique_identifier}_{filename}"
        return unique_filename
