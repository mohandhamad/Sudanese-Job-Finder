from account.serializers import AccountSerializer, CompanyRegisterSerializer, JobSeekerRegisterSerializer, LoginSerializer, LogoutUserSerializer, PasswordResetConfirmSerializer, PasswordResetReequestSerializer, SetNewPasswordSerializer, VerifyEmailSerializer
from django.utils.encoding import smart_str, DjangoUnicodeDecodeError
from datetime import datetime, timedelta
from django.http import HttpResponseRedirect
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django_filters.rest_framework import DjangoFilterBackend
from django.contrib.sites.shortcuts import get_current_site
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated
from django.utils.http import urlsafe_base64_decode
from rest_framework.generics import GenericAPIView
from rest_framework.viewsets import ModelViewSet
from drf_yasg.utils import swagger_auto_schema
from rest_framework.response import Response
from django.shortcuts import redirect
from rest_framework import permissions
from .utils import send_normal_email
from rest_framework import status
from django.conf import settings
from django.urls import reverse
from drf_yasg import openapi
from .models import User
# import base64
# import time
import jwt
from rest_framework.decorators import api_view, permission_classes
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


class CompanyRegisterView(GenericAPIView):
    serializer_class=CompanyRegisterSerializer

    def post(self, request):
        user_data=request.data
        serializer=self.serializer_class(data=user_data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            user_data=serializer.data
            # send_code_to_user(user['email'])
            user = User.objects.get(email=user_data['email'])
            token = RefreshToken.for_user(user).access_token
            expiration_time = datetime.now() + timedelta(minutes=20)
            token['exp'] = int(expiration_time.timestamp())
            current_site = get_current_site(request).domain
            relative_link = reverse('email-verify')
            absolute_url = 'http://' + current_site + relative_link + "?token=" + str(token)
            email_body = 'Hi Use the link below to verify your email \n' + absolute_url
            data = {
            'email_body': email_body,
            'email_subject': 'Verify your email',
            'to_email': user.email,
            }
            send_normal_email(data)
            return Response({
                'data':user_data,
                'message':f'hi thanks for siging up a passcode has sent to your email'
            },status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class JobSeekerRegisterView(GenericAPIView):
    serializer_class=JobSeekerRegisterSerializer

    def post(self, request):
        user_data=request.data
        serializer=self.serializer_class(data=user_data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            user_data=serializer.data
            # send_code_to_user(user['email'])
            user = User.objects.get(email=user_data['email'])
            token = RefreshToken.for_user(user).access_token
            expiration_time = datetime.now() + timedelta(minutes=20)
            token['exp'] = int(expiration_time.timestamp())
            current_site = get_current_site(request).domain
            relative_link = reverse('email-verify')
            absolute_url = 'http://' + current_site + relative_link + "?token=" + str(token)
            email_body = 'Hi Use the link below to verify your email \n' + absolute_url
            data = {
            'email_body': email_body,
            'email_subject': 'Verify your email',
            'to_email': user.email,
            }
            send_normal_email(data)
            return Response({
                'data':user_data,
                'message':f'hi thanks for siging up a passcode has sent to your email'
            },status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class VerifyUserEmail(GenericAPIView):
    serializer_class = VerifyEmailSerializer

    token_param_config = openapi.Parameter(
        'token', in_=openapi.IN_QUERY, description='Description', type=openapi.TYPE_STRING)

    @swagger_auto_schema(manual_parameters=[token_param_config])
    def get(self, request):
        token = request.GET.get('token')
        try:
            payload = jwt.decode(token, settings.SECRET_KEY, algorithms='HS256')
            # Check token expiration
            current_time = datetime.now().timestamp()
            if 'exp' not in payload or current_time > payload['exp']:
                return HttpResponseRedirect("http://sudanese_job_finder.com/email-verify-error")
            user = User.objects.get(id=payload['user_id'])
            if not user.is_verified:
                user.is_verified = True
                user.save()
            # return Response({'email': 'Successfully activated'}, status=status.HTTP_200_OK)
            return HttpResponseRedirect('http://sudanese_job_finder.com/email-verify-success')
        except jwt.ExpiredSignatureError as identifier:
            # return Response({'error': 'Activation Expired'}, status=status.HTTP_400_BAD_REQUEST)
            return HttpResponseRedirect("http://sudanese_job_finder.com/email-verify-error")
        except jwt.exceptions.DecodeError as identifier:
            # return Response({'error': 'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)
            return HttpResponseRedirect("http://sudanese_job_finder.com/email-verify-error")


class AccountViewSet(ModelViewSet):
    http_method_names = ['post', 'get', 'patch', 'delete']
    queryset = User.objects.all()
    serializer_class = AccountSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]


class LoginUserView(GenericAPIView):
    serializer_class=LoginSerializer

    def post(self, request):
        serializer=self.serializer_class(data=request.data, context={'request':request})
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class PasswordResetRequestView(GenericAPIView):
    serializer_class=PasswordResetReequestSerializer
    def post(self, request):
        try:
            serializer=self.serializer_class(data=request.data, context={'request':request})
            serializer.is_valid(raise_exception=True)
            return Response({'message':"a link has been sent to your email to reset your password"}, status=status.HTTP_200_OK)
        except:
            return Response({'error': 'The email you entered is not exists in our system'},
                            status=status.HTTP_404_NOT_FOUND)


class PasswordResetConfirm(GenericAPIView):
    serializer_class=PasswordResetConfirmSerializer
    def get(self, request, uidb64, token):
        try:
            # token_expiration_time = request.GET.get('expires')
            # decoded_expiration_time = base64.urlsafe_b64decode(token_expiration_time).decode('utf-8')
            # if token_expiration_time is None or int(decoded_expiration_time) < time.time():
            #     return redirect("http://sudanese_job_finder.com/reset-password-token-expired")
            user_id=smart_str(urlsafe_base64_decode(uidb64))
            user=User.objects.get(id=user_id)
            if not PasswordResetTokenGenerator().check_token(user, token):
                return redirect("http://sudanese_job_finder.com/reset-password-token-expired")
            reset_url = f"http://sudanese_job_finder.com/set-new-password/{uidb64}/{token}"
            return redirect(reset_url)
        
        except DjangoUnicodeDecodeError:
            return redirect("http://sudanese_job_finder.com/reset-password-token-expired")


class SetNewPassword(GenericAPIView):
    serializer_class=SetNewPasswordSerializer
    def patch(self, request):
        serializer=self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response({'message':'password reset successfull'}, status=status.HTTP_200_OK)


class LogoutUserView(GenericAPIView):
    serializer_class=LogoutUserSerializer
    permission_classes=[IsAuthenticated]

    def post(self, request):
        serializer=self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(status=status.HTTP_204_NO_CONTENT)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def account_data(request):
    user = request.user
    data = {
        'username': user.username,
        'email': user.email,
        # Add other user data as needed
    }
    return Response(data)


class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = TokenObtainPairSerializer