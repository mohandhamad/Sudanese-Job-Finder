from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework import permissions
from rest_framework.viewsets import ModelViewSet
import spacy
from company.models.company_job import CompanyJob
from company.serializers.company_job import CompanyJobSerializer , CompanyJobDetailSerializer
from job_seeker.models.job_seeker_academic_qualifications import JobSeekerAcademicQualifications
from job_seeker.models.job_seeker_experience_certificate import JobSeekerExperienceCertificate
from job_seeker.models.job_seeker_professional_certificate import JobSeekerProfessionalCertificate
from job_seeker.models.job_seeker_profile import JobSeekerProfile


class CompanyJobViewSet(ModelViewSet):
    http_method_names = ['get', 'patch', 'post', 'delete']
    queryset = CompanyJob.objects.all()
    serializer_class = CompanyJobSerializer
    permission_classes = (permissions.IsAuthenticated,)
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['company_profile']

class CompanyJobDetailViewSet(ModelViewSet):
    http_method_names = ['get']
    queryset = CompanyJob.objects.all()
    serializer_class = CompanyJobDetailSerializer
    permission_classes = (permissions.IsAuthenticated,)


class JobRecommendationViewSet(ModelViewSet):
    http_method_names = ['get']
    queryset = CompanyJob.objects.all()
    serializer_class = CompanyJobDetailSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def list(self, request):
        pramid = self.request.query_params.get('pramid')
        jobserprofileid = JobSeekerProfile.objects.get(id=pramid)
        job_seeker_profile_id = jobserprofileid.id
        match_threshold = 0.7

        try:
            job_seeker_professional_certificates = JobSeekerProfessionalCertificate.objects.filter(
                job_seeker_profile=job_seeker_profile_id)
            job_seeker_experience_certificates = JobSeekerExperienceCertificate.objects.filter(
                job_seeker_profile=job_seeker_profile_id)
            job_seeker_academic_qualifications = JobSeekerAcademicQualifications.objects.filter(
                job_seeker_profile=job_seeker_profile_id)

            # company_jobs = CompanyJob.objects.all()
            company_jobs = self.get_queryset()

            # nlp = spacy.load("en_core_web_sm")
            nlp = spacy.load("en_core_web_lg") # in middleware
            # nlp = spacy.load("en_core_web_trf")

            job_title_patterns = []

            for certificate in job_seeker_experience_certificates:
                if certificate.experience_role:
                    job_title_patterns.append(nlp(certificate.experience_role))
            for certificate in job_seeker_academic_qualifications:
                if certificate.major:
                    job_title_patterns.append(nlp(certificate.major))
            for certificate in job_seeker_professional_certificates:
                if certificate.type:
                    job_title_patterns.append(nlp(certificate.type))

            job_recommendations = []
            added_jobs = set()

            for company_job in company_jobs:
                doc_job_title = nlp(company_job.job_title)
                job_added = False
                for job_title_pattern in job_title_patterns:
                    similarity = (doc_job_title).similarity(job_title_pattern)
                    if similarity > match_threshold:
                        if company_job.id not in added_jobs:
                            added_jobs.add(company_job.id)
                            job_recommendations.append(company_job)
                            job_added = True
                            break

            serializer = self.get_serializer(job_recommendations, many=True)
            return Response(serializer.data)

        except (JobSeekerProfessionalCertificate.DoesNotExist, JobSeekerExperienceCertificate.DoesNotExist,
                JobSeekerAcademicQualifications.DoesNotExist):
            return Response([])


