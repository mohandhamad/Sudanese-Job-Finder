from .models import User
from rest_framework import serializers
from django.contrib.auth.models import Group
from company.models.company_profile import CompanyProfile
from job_seeker.models.job_seeker_profile import JobSeekerProfile
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.contrib.auth import authenticate
from rest_framework.exceptions import AuthenticationFailed
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import smart_bytes, force_str
from django.urls import reverse
from .utils import send_normal_email
from rest_framework_simplejwt.tokens import RefreshToken, TokenError
from django.utils import timezone
# import time
# import base64


class CompanyRegisterSerializer(serializers.ModelSerializer):
    groups = serializers.PrimaryKeyRelatedField(queryset=Group.objects.all(), many=True, required=False)
    password=serializers.CharField(max_length=68, min_length=6, write_only=True)

    class Meta:
        model=User
        fields=['username', 'email', 'password', 'groups']
    

    def validate(self, attrs):
        username = attrs.get('username', '')
        password=attrs.get('password', '')
        if User.objects.filter(username=username).exists():
            raise serializers.ValidationError('Username must be unique.')
        return attrs
    
    def create(self, validated_data):
        groups = validated_data.get('groups', [])
        if not any(group.pk == 2 for group in groups):
            raise serializers.ValidationError("User must be in the company group.")
        user = User.objects.create_user(
            username=validated_data.get('username'),
            email=validated_data['email'],
            password=validated_data.get('password'),
            groups = groups,
        )
        CompanyProfile.objects.create(user=user)
        return user


class JobSeekerRegisterSerializer(serializers.ModelSerializer):
    groups = serializers.PrimaryKeyRelatedField(queryset=Group.objects.all(), many=True, required=False)
    password=serializers.CharField(max_length=68, min_length=6, write_only=True)

    class Meta:
        model=User
        fields=['username', 'email', 'password', 'groups']
    

    def validate(self, attrs):
        username = attrs.get('username', '')
        password=attrs.get('password', '')
        if User.objects.filter(username=username).exists():
            raise serializers.ValidationError('Username must be unique.')
        return attrs
    
    def create(self, validated_data):
        groups = validated_data.get('groups', [])
        if not any(group.pk == 4 for group in groups):
            raise serializers.ValidationError("User must be in the job seeker group.")
        user = User.objects.create_user(
            username=validated_data.get('username'),
            email=validated_data['email'],
            password=validated_data.get('password'),
            groups = groups,
        )
        JobSeekerProfile.objects.create(user=user)
        return user


class VerifyEmailSerializer(serializers.Serializer):
    token = serializers.CharField(max_length=555)

    class Meta:
        model = User
        fields = ['token']


class AccountSerializer(serializers.ModelSerializer):
    groups = serializers.PrimaryKeyRelatedField(queryset=Group.objects.all(), many=True, required=False)
    unique_identity = serializers.CharField(read_only=True)
    password=serializers.CharField(max_length=68, min_length=6, write_only=True)
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password', 'is_verified', 'unique_identity', 'groups']

    def validate(self, attrs):
        username = attrs.get('username', '')
        email = attrs.get('email')
        password=attrs.get('password', '')
        if User.objects.filter(username=username).exists():
            raise serializers.ValidationError('Username must be unique.')
        try:
            validate_email(email)
        except ValidationError:
            raise serializers.ValidationError('Enter a valid email address.')
        return attrs
    
    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data.get('username'),
            email=validated_data['email'],
            password=validated_data.get('password'),
            is_verified=validated_data.get('is_verified'),
            groups = validated_data.get('groups', []),
        )

        return user

    def update(self, instance, validated_data):
        return super().update(instance, validated_data)
    

class LoginSerializer(serializers.ModelSerializer):
    email=serializers.EmailField(max_length=255, min_length=6, write_only=True)
    password=serializers.CharField(max_length=68, write_only=True)
    access_token=serializers.CharField(max_length=255, read_only=True)
    refresh_token=serializers.CharField(max_length=255, read_only=True)

    class Meta:
        model=User
        fields=['email', 'password', 'access_token', 'refresh_token']


    def validate(self, attrs):
        email=attrs.get('email')
        password=attrs.get('password')
        request=self.context.get('request')
        user= authenticate(request, email=email, password=password)
        if not user:
            raise AuthenticationFailed("invalid credentials try again")
        if not user.is_verified:
            raise AuthenticationFailed("Email is not verified try to change password")

        user_tokens=user.tokens()

        user.last_login = timezone.now()
        user.save()

        return {
            'access_token':str(user_tokens.get('access')),
            'refresh_token':str(user_tokens.get('refresh')),
        }


class PasswordResetReequestSerializer(serializers.Serializer):
    email=serializers.EmailField(max_length=255)

    class Meta:
        fields=['email']
    
    def validate(self, attrs):
        email=attrs.get('email')
        if User.objects.filter(email=email).exists:
            user=User.objects.get(email=email)
            uidb64=urlsafe_base64_encode(smart_bytes(user.id))
            token=PasswordResetTokenGenerator().make_token(user)
            # token_expiration_time = int(time.time()) + 3600
            # encoded_expiration_time = base64.urlsafe_b64encode(str(token_expiration_time).encode('utf-8')).decode('utf-8')
            request=self.context.get('request')
            site_domain=get_current_site(request).domain
            relative_link=reverse('password-reset-confirm', kwargs={'uidb64':uidb64, 'token':token})
            abslink=f"http://{site_domain}{relative_link}"
            # abslink=f"http://{site_domain}{relative_link}?expires={encoded_expiration_time}"
            email_body=f"Hi use the link below to reset your password \n{abslink}"
            data={
                'email_body':email_body,
                'email_subject':"Reset your Password",
                'to_email':user.email
            }
            send_normal_email(data)
        return super().validate(attrs)
  

class PasswordResetConfirmSerializer(serializers.Serializer):
    pass


class SetNewPasswordSerializer(serializers.Serializer):
    password=serializers.CharField(max_length=100, min_length=6, write_only=True)
    confirm_password=serializers.CharField(max_length=100, min_length=6, write_only=True)
    uidb64=serializers.CharField(write_only=True)
    token=serializers.CharField(write_only=True)

    class Meta:
        fields = ["password", "confirm_password", "uidb64", "token"]

    def validate(self, attrs):
        try:
            token=attrs.get('token')
            uidb64=attrs.get('uidb64')
            password=attrs.get('password')
            confirm_password=attrs.get('confirm_password')
            user_id=force_str(urlsafe_base64_decode(uidb64))
            user=User.objects.get(id=user_id)
            if not PasswordResetTokenGenerator().check_token(user, token):
                raise AuthenticationFailed("reset link is invalid or has expired", 401)
            if password != confirm_password:
                raise AuthenticationFailed("passwords do not match")
            user.set_password(password)
            if not user.is_verified:
                user.is_verified = True
            user.save()
            return user
        except Exception as e:
            raise AuthenticationFailed("link is invalid or has expired")
        

class LogoutUserSerializer(serializers.Serializer):
    refresh_token=serializers.CharField()

    default_error_message={
        'bad_token':('Token is Invalid or has expired')
    }

    def validate(self, attrs):
        self.token=attrs.get('refresh_token')
        return attrs
    
    def save(self, **kwargs):
        try:
            token=RefreshToken(self.token)
            token.blacklist()
        except TokenError:
            return self.fail('bad_token')

