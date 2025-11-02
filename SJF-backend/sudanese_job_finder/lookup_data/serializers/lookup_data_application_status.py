from lookup_data.models.lookup_data_application_status import LookupDataApplicationStatus
from rest_framework import serializers


class LookupDataApplicationStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = LookupDataApplicationStatus
        fields = [
            'id',
            'description',
            'created_by',
            'modified_by',
            'is_delete',
        ]