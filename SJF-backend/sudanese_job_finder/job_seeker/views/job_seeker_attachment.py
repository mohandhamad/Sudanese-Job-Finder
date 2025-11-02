from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from job_seeker.models.job_seeker_attachment import JobSeekerAttachment
from job_seeker.serializers.job_seeker_attachment import JobSeekerAttachmentSerializer
from rest_framework.parsers import MultiPartParser, FormParser


class JobSeekerAttachmentViewSet(ModelViewSet):
    http_method_names = ['get', 'post', 'delete']
    queryset = JobSeekerAttachment.objects.all()
    serializer_class = JobSeekerAttachmentSerializer
    permission_classes = (permissions.IsAuthenticated,)
    parser_classes = [MultiPartParser, FormParser]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['job_seeker_profile']