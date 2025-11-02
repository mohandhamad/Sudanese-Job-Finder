from django.contrib import admin
from .models.lookup_data_application_status import LookupDataApplicationStatus

@admin.register(LookupDataApplicationStatus)
class LookupDataApplicationStatusAdmin(admin.ModelAdmin):
    list_display = ('id','description_display',)
    search_fields = ['description']

    @admin.display(description='Description')
    def description_display(self, obj):
        return obj.description if obj.description else 'No Description Provided'