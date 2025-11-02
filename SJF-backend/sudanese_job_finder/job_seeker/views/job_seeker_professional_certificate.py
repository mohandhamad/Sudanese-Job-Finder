from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from job_seeker.models.job_seeker_professional_certificate import JobSeekerProfessionalCertificate
from job_seeker.serializers.job_seeker_professional_certificate import JobSeekerProfessionalCertificateSerializer


class JobSeekerProfessionalCertificateViewSet(ModelViewSet):
    http_method_names = ['get', 'patch', 'post', 'delete']
    queryset = JobSeekerProfessionalCertificate.objects.all()
    serializer_class = JobSeekerProfessionalCertificateSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job_seeker_profile']