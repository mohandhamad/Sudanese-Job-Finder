from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from job_seeker.models.job_seeker_profile import JobSeekerProfile
from job_seeker.serializers.job_seeker_profile import JobSeekerProfileSerializer
from rest_framework.parsers import MultiPartParser, FormParser


class JobSeekerProfileViewSet(ModelViewSet):
    http_method_names = ['get', 'patch']
    queryset = JobSeekerProfile.objects.all()
    serializer_class = JobSeekerProfileSerializer
    permission_classes = (permissions.IsAuthenticated,)
    parser_classes = [MultiPartParser, FormParser]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['user']