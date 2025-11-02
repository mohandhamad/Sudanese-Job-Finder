from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from company.models.company_profile import CompanyProfile
from company.serializers.company_profile import CompanyProfileSerializer
from rest_framework.parsers import MultiPartParser, FormParser


class CompanyProfileViewSet(ModelViewSet):
    http_method_names = ['get', 'patch']
    queryset = CompanyProfile.objects.all()
    serializer_class = CompanyProfileSerializer
    permission_classes = (permissions.IsAuthenticated,)
    parser_classes = [MultiPartParser, FormParser]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['user']