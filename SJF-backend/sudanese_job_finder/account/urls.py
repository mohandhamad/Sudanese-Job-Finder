from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from account.views import AccountViewSet, CompanyRegisterView, JobSeekerRegisterView, LoginUserView, LogoutUserView, PasswordResetConfirm, PasswordResetRequestView, SetNewPassword, VerifyUserEmail


router = DefaultRouter()
router.register(prefix='account_data', viewset=AccountViewSet, basename='account')

urlpatterns = [
    path('', include(router.urls)),
    path('company_register/', CompanyRegisterView.as_view(), name='company_register'),
    path('job_seeker_register/', JobSeekerRegisterView.as_view(), name='job_seeker_register'),
    path('verify-email/', VerifyUserEmail.as_view(), name='email-verify'),
    path('login/', LoginUserView.as_view(), name='login'),
    path('password-reset/', PasswordResetRequestView.as_view(), name='password-reset'),
    path('password-reset-confirm/<uidb64>/<token>/', PasswordResetConfirm.as_view(), name='password-reset-confirm'),
    path('set-new-password/', SetNewPassword.as_view(), name='set-new-password'),
    path('logout/', LogoutUserView.as_view(), name='logout'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]