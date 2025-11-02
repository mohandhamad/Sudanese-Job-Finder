from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import Group
from .models import User

class CustomUserAdmin(UserAdmin):
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        return queryset.prefetch_related('groups')

    list_display = ['id', 'email', 'username', 'display_group', 'is_staff', 'is_superuser', 'is_verified']
    list_filter = ['is_staff', 'is_superuser', 'is_verified', 'groups']
    search_fields = ['email', 'username']
    ordering = ['id']
    fieldsets = (
        (None, {'fields': ('email', 'username', 'password')}),
        ('Permissions', {'fields': ('is_staff', 'is_superuser', 'is_verified', 'groups')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': (
                'email', 'username', 'password1', 'password2',
                'is_staff', 'is_superuser', 'is_verified', 'groups'
            ),
        }),
    )

    def display_group(self, obj):
        return ', '.join([group.name for group in obj.groups.all()])

    display_group.short_description = 'Group'

admin.site.unregister(Group)

admin.site.register(User, CustomUserAdmin)