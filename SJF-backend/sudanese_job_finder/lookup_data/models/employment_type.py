# import uuid
# from django.db import models


# class EmploymentType(models.Model):
#     description = models.CharField(max_length=100)

#     unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
#     is_deleted = models.BooleanField(default=False, blank=True, null=True)

#     class Meta:
#         db_table = 'lookup_employment_type'
