# from lookup_data.models.employment_type import EmploymentType
# from lookup_data.serializers.employment_type import EmploymentTypeSerializer
# from rest_framework.viewsets import ModelViewSet
# from rest_framework import permissions


# class EmploymentTypeViewSet(ModelViewSet):
#     http_method_names = ['get', 'post', 'put']
#     queryset = EmploymentType.objects.filter(is_deleted=0)
#     serializer_class = EmploymentTypeSerializer
#     permission_classes = (permissions.IsAuthenticated,)
#     filterset_fields = []