from django.utils.translation import gettext_lazy as _
from django.db import models
from django.conf import settings
from company.models.company_profile import CompanyProfile
import uuid


def upload_to(instance, filename):
    return 'company_images/{filename}'.format(filename=filename)


class CompanyImages(models.Model):
    company_profile = models.ForeignKey(to=CompanyProfile, related_name='company_images', on_delete=models.CASCADE)
    title = models.CharField(max_length=25, null=True, blank=True)
    description = models.CharField(max_length=255, null=True, blank=True)
    image = models.ImageField(_("Image"), upload_to=upload_to, null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_images_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_images_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.title if self.title else "Unnamed Title"

    class Meta:
        db_table = 'company_images'
