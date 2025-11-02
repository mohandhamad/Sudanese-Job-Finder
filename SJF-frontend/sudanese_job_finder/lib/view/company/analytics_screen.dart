// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final CompanyServices _companyServices = CompanyServices();
  Map<String, Map<String, int>> _jobRequestsStatusCounts = {};
  Map<String, int> _jobViewCounts = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  Future<void> _fetchAnalyticsData() async {
    try {
      final companyProfileId =
          Provider.of<CompanyProfileProvider>(context, listen: false)
              .companyProfileList[0]
              .id;

      final jobs = await _companyServices.getJobs(companyProfileId!);
      final Map<String, Map<String, int>> jobRequestsStatusCounts = {};
      final Map<String, int> jobViewCounts = {};

      for (var job in jobs) {
        // Fetch job request counts
        final statusCounts =
            await _companyServices.fetchJobRequestsCounts(job.id ?? 0);
        jobRequestsStatusCounts[job.jobTitle ?? 'Unknown'] = {
          'Requests': statusCounts['Requests'] ?? 0,
          'Approved': statusCounts['Approved'] ?? 0,
          'Rejected': statusCounts['Rejected'] ?? 0,
          'Pending': statusCounts['Pending'] ?? 0,
        };

        // Fetch job view counts
        final jobViewCount =
            await _companyServices.getJobViewCount(job.id ?? 0);
        jobViewCounts[job.jobTitle ?? 'Unknown'] =
            jobViewCount; // Store the count
      }

      setState(() {
        _jobRequestsStatusCounts = jobRequestsStatusCounts;
        _jobViewCounts = jobViewCounts;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching analytics data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Analytics', isHome: false),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _jobRequestsStatusCounts.length,
              itemBuilder: (context, index) {
                final jobTitle = _jobRequestsStatusCounts.keys.elementAt(index);
                final statusCounts = _jobRequestsStatusCounts[jobTitle]!;
                final jobViewCount = _jobViewCounts[jobTitle] ?? 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job Title
                        Text(
                          jobTitle,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.appPrimaryColor,
                                  ),
                        ),
                        const SizedBox(height: 8),

                        // Job Views
                        Row(
                          children: [
                            const Icon(Icons.visibility,
                                color: AppColor.appSecondaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Views: $jobViewCount',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const Divider(height: 24, thickness: 1),

                        // Job Requests
                        Row(
                          children: [
                            const Icon(Icons.list_alt,
                                color: AppColor.appPrimaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Total Requests: ${statusCounts['Requests']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Approved Requests
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Approved: ${statusCounts['Approved']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rejected Requests
                        Row(
                          children: [
                            const Icon(Icons.cancel, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              'Rejected: ${statusCounts['Rejected']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Pending Requests
                        Row(
                          children: [
                            const Icon(Icons.hourglass_empty,
                                color: AppColor.appSecondaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Pending: ${statusCounts['Pending']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
