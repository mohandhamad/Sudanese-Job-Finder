from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from job_seeker.models.job_application import JobApplication
from job_seeker.serializers.job_application import JobApplicationDetailSerializer, JobApplicationSeekerDetailSerializer, JobApplicationSerializer


class JobApplicationViewSet(ModelViewSet):
    http_method_names = ['post', 'patch', 'delete']
    queryset = JobApplication.objects.all()
    serializer_class = JobApplicationSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job_seeker_profile']


class JobApplicationDetailViewSet(ModelViewSet):
    http_method_names = ['get']
    queryset = JobApplication.objects.all()
    serializer_class = JobApplicationDetailSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job_seeker_profile']


class JobApplicationSeekerDetailViewSet(ModelViewSet):
    http_method_names = ['get']
    queryset = JobApplication.objects.all()
    serializer_class = JobApplicationSeekerDetailSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['company_job__company_profile']