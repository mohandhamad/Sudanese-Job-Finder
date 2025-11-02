from rest_framework import viewsets
from company.models.job_views import JobView
from company.serializers.job_views import JobViewSerializer
from rest_framework import permissions
from django_filters.rest_framework import DjangoFilterBackend

class JobViewViewSet(viewsets.ModelViewSet):
    http_method_names = ['get', 'patch', 'post', 'delete']
    queryset = JobView.objects.all()
    serializer_class = JobViewSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filterset_fields = ['company_job']
    filter_backends = [DjangoFilterBackend]