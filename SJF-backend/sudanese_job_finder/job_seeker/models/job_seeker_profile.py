from django.conf import settings
from django.utils.translation import gettext_lazy as _
from django.db import models
import uuid


def upload_to(instance, filename):
    return 'job_seeker_profile_images/{filename}'.format(filename=filename)


class JobSeekerProfile(models.Model):
    MALE = 'M'
    FEMALE = 'F'

    GENDER_CHOICES = [
        (MALE, 'Male'),
        (FEMALE, 'Female'),
    ]

    user = models.OneToOneField(to=settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    image = models.ImageField(_("Image"), upload_to=upload_to, null=True, blank=True)
    national_id = models.CharField(max_length=50, null=True, blank=True)
    first_name = models.CharField(max_length=100, null=True, blank=True)
    middle_name = models.CharField(max_length=100, null=True, blank=True)
    last_name = models.CharField(max_length=100, null=True, blank=True)
    birth_date = models.DateField(null=True, blank=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, default=MALE, null=True, blank=True)
    marital_status = models.CharField(max_length=50, null=True, blank=True)
    skills = models.JSONField(default=list, blank=True)

    unique_identity = models.CharField(max_length=36, unique=True, default=uuid.uuid4)
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    modified_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    created_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_seeker_profile_created_by',
        on_delete=models.SET_NULL
    )
    modified_by = models.ForeignKey(
        to=settings.AUTH_USER_MODEL,
        null=True,
        blank=True,
        related_name='job_seeker_profile_modified_by',
        on_delete=models.SET_NULL
    )
    is_delete = models.BooleanField(default=False, null=True, blank=True)

    def __str__(self):
        return f'{self.first_name} {self.last_name}'

    class Meta:
        db_table = 'job_seeker_profile'
