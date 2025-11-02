from rest_framework import viewsets
from company.models.interview import Interview
from company.serializers.interview import InterviewSerializer

class InterviewViewSet(viewsets.ModelViewSet):
    queryset = Interview.objects.all()
    serializer_class = InterviewSerializer