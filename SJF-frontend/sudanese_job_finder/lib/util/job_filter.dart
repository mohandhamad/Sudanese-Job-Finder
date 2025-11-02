import 'package:sudanese_job_finder/model/company_job_detail_response.dart';

void filterJobs(
  String query,
  String selectedFilter,
  int currentIndex,
  List<CompanyJobDetailResponse> allJobs,
  List<CompanyJobDetailResponse> recommendedJobs,
  Function(List<CompanyJobDetailResponse>) updateFilteredJobs,
) {
  List<CompanyJobDetailResponse> filteredJobs;

  switch (selectedFilter) {
    case 'jobTitle':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.jobTitle!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.jobTitle!.toLowerCase().contains(query.toLowerCase()))
              .toList();
      break;
    case 'companyName':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) => job.companyProfile!.companyName!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) => job.companyProfile!.companyName!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
      break;
    case 'skills':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.skills!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.skills!.toLowerCase().contains(query.toLowerCase()))
              .toList();
      break;
    case 'salary':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.salary!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.salary!.toLowerCase().contains(query.toLowerCase()))
              .toList();
      break;
    case 'jobType':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.jobType!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.jobType!.toLowerCase().contains(query.toLowerCase()))
              .toList();
      break;
    case 'expLevel':
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.expLevel!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.expLevel!.toLowerCase().contains(query.toLowerCase()))
              .toList();
      break;
    default:
      filteredJobs = currentIndex == 0
          ? allJobs
              .where((job) =>
                  job.jobTitle!.toLowerCase().contains(query.toLowerCase()) ||
                  job.companyProfile!.companyName!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList()
          : recommendedJobs
              .where((job) =>
                  job.jobTitle!.toLowerCase().contains(query.toLowerCase()) ||
                  job.companyProfile!.companyName!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
  }

  updateFilteredJobs(filteredJobs);
}
