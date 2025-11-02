from django.contrib.auth.models import BaseUserManager
from django.core.exceptions import ValidationError
from django.contrib.auth.models import Group
from django.db import transaction
from django.core.validators import validate_email
from django.utils.translation import gettext_lazy as _



class UserManager(BaseUserManager):
    def email_validator(self, email):
        try:
            validate_email(email)
        except ValidationError:
            raise ValueError(_("Please enter a valid email address"))
        
    def create_user(self, username, email, password, groups=None, **extra_fields):
        if email:
            email=self.normalize_email(email)
            self.email_validator(email)
        else:
            raise ValueError(_("an email address is required"))
        if not username:
            raise ValueError(_("username is required"))
        if not groups or len(groups) == 0:
            raise TypeError('Users should belong to at least one group')
        
        user=self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        if groups:
            user.groups.set(groups)
            user.save()

        return user
    
    def create_superuser(self, username, email, password, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_verified", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError(_("is staff must be true for admin user"))
        
        if extra_fields.get("is_superuser") is not True:
            raise ValueError(_("is superuser must be true for admin user"))
        
        with transaction.atomic():
            try:
                group = Group.objects.get(id=1)
            except Group.DoesNotExist:
                raise ValueError("The group with ID 1 does not exist.")
        
        user=self.create_user(
            username, email, password, groups=[group], **extra_fields
        )
        user.save(using=self._db)
        return user