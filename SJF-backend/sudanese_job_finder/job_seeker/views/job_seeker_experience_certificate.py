from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from job_seeker.models.job_seeker_experience_certificate import JobSeekerExperienceCertificate
from job_seeker.serializers.job_seeker_experience_certificate import JobSeekerExperienceCertificateSerializer


class JobSeekerExperienceCertificateViewSet(ModelViewSet):
    http_method_names = ['get', 'patch', 'post', 'delete']
    queryset = JobSeekerExperienceCertificate.objects.all()
    serializer_class = JobSeekerExperienceCertificateSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job_seeker_profile']