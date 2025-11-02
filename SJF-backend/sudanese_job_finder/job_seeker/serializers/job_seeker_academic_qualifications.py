from rest_framework import serializers
from job_seeker.models.job_seeker_academic_qualifications import JobSeekerAcademicQualifications


class JobSeekerAcademicQualificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobSeekerAcademicQualifications
        fields = [
            'id',
            'job_seeker_profile',
            'degree',
            'major',
            'school',
            'graduation_date',
            'gpa',
            'grade',
            'start_date',
            'end_date',
            'created_by',
            'modified_by',
            'is_delete'
        ]