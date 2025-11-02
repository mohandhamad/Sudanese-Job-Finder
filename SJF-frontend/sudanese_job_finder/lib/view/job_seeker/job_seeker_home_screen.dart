// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/model/company_job_detail_response.dart';
import 'package:sudanese_job_finder/model/company_job_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_request.dart';
import 'package:sudanese_job_finder/model/job_view_request.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/job_filter.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_job_detail_screen.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_j_p_card_widget.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class JobSeekerHomeScreen extends StatefulWidget {
  const JobSeekerHomeScreen({super.key});

  @override
  State<JobSeekerHomeScreen> createState() => _JobSeekerHomeScreenState();
}

class _JobSeekerHomeScreenState extends State<JobSeekerHomeScreen> {
  final _api = CompanyServices();
  int _currentIndex = 0;
  late Future<List<CompanyJobDetailResponse>> _allJobsFuture;
  late Future<List<CompanyJobDetailResponse>> _recommendedJobsFuture;
  List<CompanyJobDetailResponse> _allJobs = [];
  List<CompanyJobDetailResponse> _recommendedJobs = [];
  List<CompanyJobDetailResponse> _filteredJobs = [];
  String _searchQuery = '';
  String _selectedFilter = 'jobTitle';

  @override
  void initState() {
    super.initState();
    _allJobsFuture = _api.getJobsDetail();
    _recommendedJobsFuture = _loadRecommendedJobs();
    _loadAllJobs();
  }

  Future<List<CompanyJobDetailResponse>> _loadRecommendedJobs() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    _recommendedJobs = await _api.getRecommedJob(id!);
    _filteredJobs = _recommendedJobs;
    setState(() {});
    return _recommendedJobs;
  }

  void _loadAllJobs() async {
    _allJobs = await _api.getJobsDetail();
    _filteredJobs = _allJobs;
    setState(() {});
  }

  void _updateFilteredJobs(List<CompanyJobDetailResponse> filteredJobs) {
    setState(() {
      _filteredJobs = filteredJobs;
    });
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppBarWidget(title: 'Find Your Dream Job', isHome: true),
      body: Column(
        children: [
          _buildSegmentedControl(theme),
          const SizedBox(height: 16),
          _buildSearchBar(theme),
          const SizedBox(height: 16),
          _buildFilterChipRow(theme),
          const SizedBox(height: 8),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                _buildJobList(_allJobsFuture),
                _buildJobList(_recommendedJobsFuture),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SegmentedButton(
        segments: const [
          ButtonSegment(
            value: 0,
            label: Text('All Jobs'),
            icon: Icon(Icons.work_outline),
          ),
          ButtonSegment(
            value: 1,
            label: Text('Recommended'),
            icon: Icon(Icons.thumb_up_outlined),
          ),
        ],
        selected: {_currentIndex},
        onSelectionChanged: (Set<int> newSelection) {
          setState(() {
            _currentIndex = newSelection.first;
            _filteredJobs = _currentIndex == 0 ? _allJobs : _recommendedJobs;
          });
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return AppColor.appPrimaryColor;
              }
              return theme.colorScheme.surfaceContainerHighest;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SearchBar(
        hintText: 'Search jobs...',
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
        onChanged: (query) {
          _searchQuery = query;
          filterJobs(
            query,
            _selectedFilter,
            _currentIndex,
            _allJobs,
            _recommendedJobs,
            _updateFilteredJobs,
          );
        },
      ),
    );
  }

  Widget _buildFilterChipRow(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 16),
          FilterChip(
            label: const Text('Job Title'),
            selected: _selectedFilter == 'jobTitle',
            onSelected: (bool selected) => _updateFilter('jobTitle'),
            selectedColor: AppColor.appPrimaryColor,
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Company'),
            selected: _selectedFilter == 'companyName',
            onSelected: (bool selected) => _updateFilter('companyName'),
            selectedColor: AppColor.appPrimaryColor,
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Salary'),
            selected: _selectedFilter == 'salary',
            onSelected: (bool selected) => _updateFilter('salary'),
            selectedColor: AppColor.appPrimaryColor,
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Experience'),
            selected: _selectedFilter == 'expLevel',
            onSelected: (bool selected) => _updateFilter('expLevel'),
            selectedColor: AppColor.appPrimaryColor,
          ),
        ],
      ),
    );
  }

  void _updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      filterJobs(
        _searchQuery,
        _selectedFilter,
        _currentIndex,
        _allJobs,
        _recommendedJobs,
        _updateFilteredJobs,
      );
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter By'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('Job Title', 'jobTitle'),
              _buildFilterOption('Company Name', 'companyName'),
              _buildFilterOption('Skills', 'skills'),
              _buildFilterOption('Salary', 'salary'),
              _buildFilterOption('Job Type', 'jobType'),
              _buildFilterOption('Experience', 'expLevel'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, String value) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedFilter,
        onChanged: (String? newValue) {
          setState(() {
            _selectedFilter = newValue!;
            filterJobs(
              _searchQuery,
              _selectedFilter,
              _currentIndex,
              _allJobs,
              _recommendedJobs,
              _updateFilteredJobs,
            );
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildJobList(Future<List<CompanyJobDetailResponse>> future) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Image.asset('assets/error.png'));
        }
        return _JobListContent(jobs: _filteredJobs);
      },
    );
  }
}

class _JobListContent extends StatelessWidget {
  final List<CompanyJobDetailResponse> jobs;

  const _JobListContent({required this.jobs});

  @override
  Widget build(BuildContext context) {
    final companyServices = CompanyServices();
    final jobSeekerProfileProvider =
        Provider.of<JobSeekerProfileProvider>(context, listen: false);
    final jobSeekerProfile = jobSeekerProfileProvider.jobSeekerProfileList[0];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobSeekerJPCardWidget(
          companyName: job.companyProfile?.companyName ?? '',
          endDate: job.deadline?.toLocal().toString() ?? 'N/A',
          logo: job.companyProfile?.image,
          jobRole: job.jobTitle ?? '',
          jobDes: job.jobDescription ?? '',
          salary: job.salary ?? 'Not specified',
          voidCallback: () async {
            // Check if the job view already exists
            final exists = await companyServices.checkJobViewExists(
              job.id!,
              jobSeekerProfile.id!,
            );

            if (!exists) {
              // If the job view does not exist, post it
              final jobViewRequest = JobViewRequest(
                companyJob: job.id,
                jobSeeker: jobSeekerProfile.id,
              );

              await companyServices.postJobView(jobViewRequest);
            }

            // Navigate to the job detail screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobSeekerJobDetailScreen(data: job),
              ),
            );
          },
        );
      },
    );
  }
}
