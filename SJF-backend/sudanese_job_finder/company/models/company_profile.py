from django.utils.translation import gettext_lazy as _
from django.db import models
from django.conf import settings
import uuid


def upload_to(instance, filename):
    return 'company_profile_images/{filename}'.format(filename=filename)


class CompanyProfile(models.Model):
    user = models.OneToOneField(to=settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    company_name = models.CharField(max_length=50, null=True, blank=True)
    image = models.ImageField(_("Image"), upload_to=upload_to, null=True, blank=True)
    mobile = models.CharField(max_length=12, null=True, blank=True)
    description = models.CharField(max_length=200, null=True, blank=True)
    web_site = models.CharField(max_length=200, null=True, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_profile_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='company_profile_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return self.company_name if self.company_name else "Unnamed Company name"

    class Meta:
        db_table = 'company_profile'

