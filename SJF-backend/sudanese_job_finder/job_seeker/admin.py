from django.contrib import admin
from .models.job_seeker_profile import JobSeekerProfile
from .models.job_application import JobApplication
from .models.job_seeker_contact import JobSeekerContact
from .models.job_seeker_attachment import JobSeekerAttachment
from .models.job_seeker_academic_qualifications import JobSeekerAcademicQualifications
from .models.job_seeker_experience_certificate import JobSeekerExperienceCertificate
from .models.job_seeker_professional_certificate import JobSeekerProfessionalCertificate
from django.utils.html import format_html


class JobSeekerProfileAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'gender_display', 'marital_status', 'national_id', 'birth_date_display', 'skills_display', 'created_at_display', 'modified_at_display')
    search_fields = ['first_name', 'middle_name', 'last_name', 'skills']

    @admin.display(description='Full Name')
    def full_name(self, obj):
        name_parts = [obj.first_name, obj.middle_name, obj.last_name]
        return ' '.join(part for part in name_parts if part)

    @admin.display(description='Gender')
    def gender_display(self, obj):
        return obj.get_gender_display()

    @admin.display(description='Birth Date')
    def birth_date_display(self, obj):
        return obj.birth_date.strftime('%Y-%m-%d') if obj.birth_date else 'Not Provided'

    @admin.display(description='Skills')
    def skills_display(self, obj):
        return ', '.join(obj.skills) if obj.skills else 'No Skills Provided'

    @admin.display(description='Created At')
    def created_at_display(self, obj):
        return obj.created_at.strftime('%Y-%m-%d %H:%M:%S') if obj.created_at else 'Not Applicable'

    @admin.display(description='Modified At')
    def modified_at_display(self, obj):
        return obj.modified_at.strftime('%Y-%m-%d %H:%M:%S') if obj.modified_at else 'Not Applicable'

admin.site.register(JobSeekerProfile, JobSeekerProfileAdmin)


class JobApplicationAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'job_title', 'application_status_display', 'created_date_display', 'modified_date_display')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'company_job__job_title', 'application_status__description']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        if obj.job_seeker_profile:
            return f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}"
        return "No Name Provided"

    @admin.display(description='Role Name')
    def job_title(self, obj):
        if obj.company_job and obj.company_job.job_title:
            return obj.company_job.job_title
        return "No Role Name"

    @admin.display(description='Application Status')
    def application_status_display(self, obj):
        return obj.application_status.description if obj.application_status and obj.application_status.description else 'Status Not Set'

    @admin.display(description='Created Date')
    def created_date_display(self, obj):
        return obj.created_date.strftime('%Y-%m-%d %H:%M:%S') if obj.created_date else 'Not Applicable'

    @admin.display(description='Modified Date')
    def modified_date_display(self, obj):
        return obj.modified_date.strftime('%Y-%m-%d %H:%M:%S') if obj.modified_date else 'Not Applicable'

admin.site.register(JobApplication, JobApplicationAdmin)




class JobSeekerContactAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'contact_type', 'contact_number')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'contact_number']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        return format_html(f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}")

    @admin.display(description='Contact Type')
    def contact_type(self, obj):
        return obj.type if obj.type else 'Not Specified'

    @admin.display(description='Contact Number')
    def contact_number_display(self, obj):
        return obj.contact_number if obj.contact_number else 'Not Available'

admin.site.register(JobSeekerContact, JobSeekerContactAdmin)


class JobSeekerAttachmentAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'attachment_type')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        return format_html(f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}")

    @admin.display(description='Attachment Type')
    def attachment_type(self, obj):
        return obj.job_seeker_attachment_type if obj.job_seeker_attachment_type else 'Not Specified'

admin.site.register(JobSeekerAttachment, JobSeekerAttachmentAdmin)


class JobSeekerAcademicQualificationsAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'degree', 'major', 'school', 'graduation_date')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'school']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        return format_html(f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}")

    @admin.display(description='Major')
    def display_major(self, obj):
        return obj.major

admin.site.register(JobSeekerAcademicQualifications, JobSeekerAcademicQualificationsAdmin)


class JobSeekerExperienceCertificateAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'experience_role', 'formatted_dates', 'implemented_projects')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'experience_role']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        return format_html(f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}")

    @admin.display(description='Experience Role')
    def experience_role_display(self, obj):
        return obj.experience_role if obj.experience_role else 'Not specified'

    @admin.display(description='Duration')
    def formatted_dates(self, obj):
        start_date = obj.start_date.strftime('%Y-%m-%d') if obj.start_date else 'Not Started'
        end_date = obj.end_date.strftime('%Y-%m-%d') if obj.end_date else 'Present'
        return f"{start_date} to {end_date}"

    @admin.display(description='Projects Implemented')
    def implemented_projects_display(self, obj):
        return obj.implemented_projects if obj.implemented_projects else 'None'

admin.site.register(JobSeekerExperienceCertificate, JobSeekerExperienceCertificateAdmin)


class JobSeekerProfessionalCertificateAdmin(admin.ModelAdmin):
    list_display = ('job_seeker_name', 'type', 'mark', 'formatted_exam_date')
    search_fields = ['job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'type']

    @admin.display(description='Job Seeker Name')
    def job_seeker_name(self, obj):
        return format_html(f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}")

    @admin.display(description='Type of Certificate')
    def type_display(self, obj):
        return obj.type if obj.type else 'Not Specified'

    @admin.display(description='Mark')
    def mark_display(self, obj):
        return obj.mark if obj.mark else 'Not Specified'

    @admin.display(description='Exam Date')
    def formatted_exam_date(self, obj):
        return obj.exam_date.strftime('%Y-%m-%d') if obj.exam_date else 'Not Applicable'

admin.site.register(JobSeekerProfessionalCertificate, JobSeekerProfessionalCertificateAdmin)

