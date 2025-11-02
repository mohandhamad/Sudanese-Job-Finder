import uuid
from django.db import models
from django.conf import settings


class LookupDataApplicationStatus(models.Model):
    description = models.CharField(max_length=200, null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_date = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_date = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='lookup_data_application_status_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='lookup_data_application_status_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.description if self.description else "Unnamed Description"

    class Meta:
        db_table = 'lookup_data_application_status'
