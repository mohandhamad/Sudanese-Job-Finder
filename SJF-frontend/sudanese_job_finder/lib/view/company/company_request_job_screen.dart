// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/view/company/company_request_detail_screen.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';

class CompanyRequestJobScreen extends StatefulWidget {
  const CompanyRequestJobScreen({super.key});

  @override
  State<CompanyRequestJobScreen> createState() =>
      _CompanyRequestJobScreenState();
}

class _CompanyRequestJobScreenState extends State<CompanyRequestJobScreen> {
  final CompanyServices _api = CompanyServices();
  List<JobApplicationSeekerDetailResponse> _allData = [];
  List<JobApplicationSeekerDetailResponse> _filteredData = [];
  String? _selectedFilter; // Set to null to display all requests by default
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    try {
      final companyProfileId =
          Provider.of<CompanyProfileProvider>(context, listen: false)
              .companyProfileList[0]
              .id;
      final response = await _api.getJobApplicationDetail(companyProfileId!);
      setState(() {
        _allData = response;
        _filteredData = _allData; // Display all requests by default
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching requests: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterRequests(String? filter) {
    setState(() {
      _selectedFilter = filter;
      if (_selectedFilter == null || _selectedFilter == 'All') {
        _filteredData = _allData; // Show all requests if no filter is applied
      } else {
        _filteredData = _allData
            .where((request) =>
                request.applicationStatus?.description?.toLowerCase() ==
                filter?.toLowerCase())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Job Requests', isHome: false),
      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedFilter ?? 'All', // Default to 'All'
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                prefixIcon: const Icon(Icons.filter_list, color: AppColor.appPrimaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.appPrimaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.appPrimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: 'Pending',
                  child: Text('Pending'),
                ),
                DropdownMenuItem(
                  value: 'Approved',
                  child: Text('Approved'),
                ),
                DropdownMenuItem(
                  value: 'Rejected',
                  child: Text('Rejected'),
                ),
              ],
              onChanged: (value) {
                _filterRequests(value == 'All' ? null : value);
              },
            ),
          ),
          // Request List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColor.appPrimaryColor))
                : _filteredData.isEmpty
                    ? const Center(child: Text('No job requests found'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredData.length,
                        itemBuilder: (context, index) {
                          final request = _filteredData[index];
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
                                  // Job Seeker Name
                                  Text(
                                    '${request.jobSeekerProfile?.firstName ?? ''} ${request.jobSeekerProfile?.lastName ?? ''}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.appPrimaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Job Title
                                  Text(
                                    request.companyJob?.jobTitle ?? 'N/A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColor.appPrimaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Status
                                  Text(
                                    'Status: ${request.applicationStatus?.description ?? 'N/A'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Action Buttons
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigate to details screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CompanyRequestDetailScreen(
                                                data: request,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.appPrimaryColor,
                                          foregroundColor: Colors.white, // Button text color
                                        ),
                                        child: const Text('View Details'),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Open dialog to update status
                                          _openDialog(context, request);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.appPrimaryColor,
                                          foregroundColor: Colors.white, // Button text color
                                        ),
                                        child: const Text('Update Status'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _openDialog(
      BuildContext context, JobApplicationSeekerDetailResponse request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: DropdownButtonFormField<String>(
            value: request.applicationStatus?.description,
            decoration: const InputDecoration(
              labelText: 'Status',
              prefixIcon: Icon(Icons.info, color: AppColor.appPrimaryColor),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Pending',
                child: Text('Pending'),
              ),
              DropdownMenuItem(
                value: 'Approved',
                child: Text('Approved'),
              ),
              DropdownMenuItem(
                value: 'Rejected',
                child: Text('Rejected'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  request.applicationStatus?.description = value;
                });
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.appPrimaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Update status logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.appPrimaryColor,
                foregroundColor: Colors.white, // Button text color
              ),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
