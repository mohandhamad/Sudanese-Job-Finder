from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
from company.models.company_images import CompanyImages
from company.serializers.company_images import CompanyImagesSerializer
from rest_framework.parsers import MultiPartParser, FormParser


class CompanyImagesViewSet(ModelViewSet):
    http_method_names = ['get', 'post', 'delete']
    queryset = CompanyImages.objects.all()
    serializer_class = CompanyImagesSerializer
    permission_classes = (permissions.IsAuthenticated,)
    parser_classes = [MultiPartParser, FormParser]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['company_profile_id']