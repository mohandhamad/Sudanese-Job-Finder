from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from lookup_data.models.lookup_data_application_status import LookupDataApplicationStatus
from lookup_data.serializers.lookup_data_application_status import LookupDataApplicationStatusSerializer


class LookupDataApplicationStatusViewSet(ModelViewSet):
    http_method_names = ['get', 'patch', 'post', 'delete']
    queryset = LookupDataApplicationStatus.objects.all()
    serializer_class = LookupDataApplicationStatusSerializer
    permission_classes = (permissions.IsAuthenticated,)