from rest_framework import serializers
from company.models.company_images import CompanyImages
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
import os
import uuid


class CompanyImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyImages
        fields = [
            'id',
            'company_profile',
            'title',
            'description',
            'image',
            'unique_identity',
            'created_at',
            'modified_at',
            'created_by',
            'modified_by',
            'is_delete',
        ]
    
    def delete(self, validated_data):
        instance_id = validated_data.get('id')
        if instance_id:
            try:
                instance = self.Meta.model.objects.get(id=instance_id)
                if instance.image:
                    image_path = instance.image.path
                    if default_storage.exists(image_path):
                        default_storage.delete(image_path)
            except self.Meta.model.DoesNotExist:
                pass

        return super().delete(validated_data)
    
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