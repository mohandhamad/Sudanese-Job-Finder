from django.contrib import admin
from company.models.company_job import CompanyJob
from company.models.company_profile import CompanyProfile
from company.models.interview import Interview
from company.models.job_views import JobView
from .models.company_images import CompanyImages

class CompanyProfileAdmin(admin.ModelAdmin):
    list_display = ('company_name', 'mobile', 'web_site')
    search_fields = ('company_name', 'mobile', 'web_site')

admin.site.register(CompanyProfile, CompanyProfileAdmin)

class CompanyJobAdmin(admin.ModelAdmin):
    list_display = ('get_company_name', 'job_title', 'job_field', 'exp_level', 'job_type', 'salary', 'deadline')
    search_fields = ('job_title', 'company_profile__company_name')

    def get_company_name(self, obj):
        return obj.company_profile.company_name
    get_company_name.short_description = 'Company Name'

admin.site.register(CompanyJob, CompanyJobAdmin)

class CompanyImagesAdmin(admin.ModelAdmin):
    list_display = ('company_name_display', 'title_display', 'description')
    search_fields = ['title', 'description', 'company_profile__company_name']

    def get_search_results(self, request, queryset, search_term):
        queryset, use_distinct = super().get_search_results(request, queryset, search_term)
        if search_term:
            jobs_query = CompanyJob.objects.filter(job_title__icontains=search_term).values_list('company_profile_id', flat=True)
            queryset |= self.model.objects.filter(company_profile_id__in=jobs_query)
            use_distinct = True
        return queryset, use_distinct

    @admin.display(description='Company Name')
    def company_name_display(self, obj):
        return obj.company_profile.company_name if obj.company_profile and obj.company_profile.company_name else 'No Company Name'

    @admin.display(description='Title')
    def title_display(self, obj):
        return obj.title if obj.title else 'No Title'
    
admin.site.register(CompanyImages, CompanyImagesAdmin)

class InterviewAdmin(admin.ModelAdmin):
    list_display = ('get_company_name', 'get_job_title', 'get_job_seeker_name', 'time', 'status', 'created_at', 'modified_at')
    search_fields = ('company_job__company_profile__company_name', 'company_job__job_title', 'job_seeker_profile__first_name', 'job_seeker_profile__last_name', 'status')

    @admin.display(description='Company Name')
    def get_company_name(self, obj):
        return obj.company_job.company_profile.company_name

    @admin.display(description='Job Title')
    def get_job_title(self, obj):
        return obj.company_job.job_title

    @admin.display(description='Job Seeker Name')
    def get_job_seeker_name(self, obj):
        return f"{obj.job_seeker_profile.first_name} {obj.job_seeker_profile.last_name}"

admin.site.register(Interview, InterviewAdmin)

class JobViewAdmin(admin.ModelAdmin):
    list_display = ('id','job_seeker_id','company_job_id','get_company_name', 'get_job_title', 'get_job_seeker_name', 'viewed_at')
    search_fields = ('company_job__company_profile__company_name', 'company_job__job_title', 'job_seeker__first_name', 'job_seeker__last_name')

    @admin.display(description='Company Name')
    def get_company_name(self, obj):
        return obj.company_job.company_profile.company_name

    @admin.display(description='Job Title')
    def get_job_title(self, obj):
        return obj.company_job.job_title

    @admin.display(description='Job Seeker Name')
    def get_job_seeker_name(self, obj):
        return f"{obj.job_seeker.first_name} {obj.job_seeker.last_name}"

admin.site.register(JobView, JobViewAdmin)