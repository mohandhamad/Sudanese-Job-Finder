from rest_framework.viewsets import ModelViewSet
from job_seeker.models import JobSeekerJobApplication
from job_seeker.serializers import JobSeekerJobApplicationSerializer
from rest_framework import permissions

class JobSeekerJobApplicationViewSet(ModelViewSet):
    queryset = JobSeekerJobApplication.objects.all()
    serializer_class = JobSeekerJobApplicationSerializer
    permission_classes = (permissions.IsAuthenticated,)