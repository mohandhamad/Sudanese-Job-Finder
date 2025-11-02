import base64
from rest_framework import serializers
from job_seeker.models.job_seeker_attachment import JobSeekerAttachment


class Base64FileField(serializers.FileField):
    def to_representation(self, value):
        if value:
            return base64.b64encode(value).decode()
        return None

class JobSeekerAttachmentSerializer(serializers.ModelSerializer):
    file_data = Base64FileField(max_length=None, use_url=False)
    
    class Meta:
        model =  JobSeekerAttachment
        fields = [
            'id',
            'job_seeker_profile',
            'job_seeker_attachment_type',
            'file_data',
            'created_by',
            'modified_by',
            'is_delete',
        ]
    
    def create(self, validated_data):
        file_data = validated_data.pop('file_data')
        binary_content = file_data.read()  # read file data into binary
        validated_data['file_data'] = binary_content  # store binary data directly
        return JobSeekerAttachment.objects.create(**validated_data)