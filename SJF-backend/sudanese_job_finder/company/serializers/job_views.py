from rest_framework import serializers
from company.models.job_views import JobView

class JobViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobView
        fields = [
            'id',
            'company_job',
            'job_seeker',
            'viewed_at'
        ]