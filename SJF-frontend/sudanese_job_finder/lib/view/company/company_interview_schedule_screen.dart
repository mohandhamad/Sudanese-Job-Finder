// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/model/interview_response.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class CompanyInterviewScheduleScreen extends StatefulWidget {
  const CompanyInterviewScheduleScreen({super.key});

  @override
  State<CompanyInterviewScheduleScreen> createState() =>
      _CompanyInterviewScheduleScreenState();
}

class _CompanyInterviewScheduleScreenState
    extends State<CompanyInterviewScheduleScreen> {
  final List<InterviewResponse> _interviews = [];
  final _formKey = GlobalKey<FormState>();
  final _candidateController = TextEditingController();
  final _jobController = TextEditingController();
  String? _selectedFilter; // Set to null to display all interviews by default
  String? _selectedStatus; // Status selected for adding or updating interviews
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = true;
  final List<String> _statusOptions = ['All', 'Upcoming', 'Done', 'Canceled'];
  final CompanyServices _companyServices = CompanyServices();
  final JobSeekerServices _jobSeekerServices = JobSeekerServices();

  @override
  void initState() {
    super.initState();
    final companyProfileId =
        Provider.of<CompanyProfileProvider>(context, listen: false)
            .companyProfileList[0]
            .id;
    _fetchInterviews(companyProfileId!);
  }

  Future<void> _fetchInterviews(int companyProfileId) async {
    try {
      final interviews =
          await _companyServices.fetchInterviews(companyProfileId);
      setState(() {
        _interviews.addAll(interviews);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching interviews: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addInterview(int id) async {
    _candidateController.clear();
    _jobController.clear();
    _selectedStatus = null;
    _selectedDate = null;
    _selectedTime = null;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Interview'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _jobController,
                  decoration: const InputDecoration(
                    labelText: 'Job Position',
                    prefixIcon: Icon(Icons.work, color: AppColor.appPrimaryColor),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _candidateController,
                  decoration: const InputDecoration(
                    labelText: 'Candidate Name',
                    prefixIcon: Icon(Icons.person, color: AppColor.appPrimaryColor),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    prefixIcon: Icon(Icons.info, color: AppColor.appPrimaryColor),
                  ),
                  items: _statusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) => value == null ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: AppColor.appPrimaryColor),
                  title: Text(
                    _selectedDate == null
                        ? 'Pick Date'
                        : DateFormat("yyyy-MM-dd").format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null
                          ? Colors.grey
                          : AppColor.appPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.access_time, color: AppColor.appPrimaryColor),
                  title: Text(
                    _selectedTime == null
                        ? 'Pick Time'
                        : _selectedTime!.format(context),
                    style: TextStyle(
                      color: _selectedTime == null
                          ? Colors.grey
                          : AppColor.appPrimaryColor,
                    ),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => _selectedTime = time);
                    }
                  },
                ),
              ],
            ),
          ),
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (_selectedDate == null || _selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a date and time'),
                    ),
                  );
                  return;
                }

                final jobSeekerProfile = await _jobSeekerServices
                    .getProfileByName(_candidateController.text);
                final companyJob =
                    await _companyServices.getJobByTitle(_jobController.text);

                final newInterview = InterviewResponse(
                  time: DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  ),
                  jobSeekerProfile: jobSeekerProfile,
                  companyJob: companyJob,
                  status: _selectedStatus!,
                  createdBy: id,
                  modifiedBy: id,
                );

                final success =
                    await _companyServices.postInterview(newInterview);
                if (success) {
                  setState(() {
                    _interviews.add(InterviewResponse(
                      time: newInterview.time,
                      jobSeekerProfile: newInterview.jobSeekerProfile,
                      companyJob: newInterview.companyJob,
                      status: newInterview.status,
                    ));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add interview')),
                  );
                  return;
                }

                _candidateController.clear();
                _jobController.clear();
                _selectedStatus = null;
                _selectedDate = null;
                _selectedTime = null;
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.appPrimaryColor,
              foregroundColor: Colors.white, // Ensures the text color is white
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }


  void _openUpdateStatusDialog(BuildContext context, int index) {
    final interview = _interviews[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: DropdownButtonFormField<String>(
            value: interview.status,
            decoration: const InputDecoration(
              labelText: 'Status',
              prefixIcon: Icon(Icons.info, color: AppColor.appPrimaryColor),
            ),
            items: _statusOptions.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  interview.status = value;
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
              onPressed: () async {
                // Update the status in the backend
                final success = await _companyServices.updateInterviewStatus(
                  interview.id!,
                  interview.status!,
                );
                if (success) {
                  setState(() {
                    _interviews[index] = interview;
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update status')),
                  );
                }
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

  @override
  Widget build(BuildContext context) {
    final id = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0]
        .id;

    // Filter interviews based on the selected filter
    final filteredInterviews = _selectedFilter == null || _selectedFilter == 'All'
        ? _interviews
        : _interviews.where((interview) => interview.status == _selectedFilter).toList();

    return Scaffold(
      appBar: const AppBarWidget(title: 'Interviews Schedule', isHome: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedFilter ?? 'All', // Default to 'All'
              decoration: const InputDecoration(
                labelText: 'Filter by Status',
                prefixIcon: Icon(Icons.filter_list, color: AppColor.appPrimaryColor),
              ),
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value == 'All' ? null : value;
                });
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.appPrimaryColor,
                    ),
                  )
                : filteredInterviews.isEmpty
                    ? const Center(child: Text('No interviews scheduled'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredInterviews.length,
                        itemBuilder: (context, index) {
                          final interview = filteredInterviews[index];
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
                                  Text(
                                    interview.jobSeekerProfile.firstName ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.appPrimaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    interview.companyJob?.jobTitle ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColor.appPrimaryColor,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (interview.time != null)
                                    Text(
                                      '${DateFormat("yyyy-MM-dd").format(interview.time!)} '
                                      'at ${TimeOfDay.fromDateTime(interview.time!).format(context)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Status: ${interview.status ?? 'N/A'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _openUpdateStatusDialog(context, index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.appPrimaryColor,
                                      foregroundColor: Colors.white, // Button text color
                                    ),
                                    child: const Text('Update Status'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addInterview(id!),
        backgroundColor: AppColor.appPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
