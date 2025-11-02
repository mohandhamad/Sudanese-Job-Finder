// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/token_decode.dart';

class JobSeekerSkillsScreen extends StatefulWidget {
  const JobSeekerSkillsScreen({super.key});

  @override
  State<JobSeekerSkillsScreen> createState() => _JobSeekerSkillsScreenState();
}

class _JobSeekerSkillsScreenState extends State<JobSeekerSkillsScreen> {
  final _api = JobSeekerServices();
  final _token = TokenDecode();
  late Future<JobSeekerProfileResponse> _jobSeekerProfileFuture;
  final TextEditingController _skillController = TextEditingController();
  List<String> _skills = [];
  late JobSeekerProfileResponse _jobSeekerProfile;

  @override
  void initState() {
    super.initState();
    _jobSeekerProfileFuture = _fetchJobSeekerProfile();
  }

  Future<JobSeekerProfileResponse> _fetchJobSeekerProfile() async {
    final userId = await _token.getUserID();
    if (userId != null) {
      final profiles = await _api.getProfile(userId);
      if (profiles.isNotEmpty) {
        _jobSeekerProfile = profiles.first;
        return _jobSeekerProfile;
      } else {
        throw Exception('No profiles found');
      }
    } else {
      throw Exception('User ID not found');
    }
  }

  void _addSkill() async {
    final newSkill = _skillController.text.trim();
    if (newSkill.isNotEmpty) {
      setState(() {
        _skills.add(newSkill);
        _skillController.clear();
      });
      // حالياً لا تعمل
      // Update the profile with the new skill
      final updatedProfile = _jobSeekerProfile.copyWith(
        skills: _skills,
      );
      final profileRequest = JobSeekerProfileRequest(
        id: updatedProfile.id,
        image: updatedProfile.image,
        nationalId: updatedProfile.nationalId,
        firstName: updatedProfile.firstName,
        middleName: updatedProfile.middleName,
        lastName: updatedProfile.lastName,
        birthDate: updatedProfile.birthDate,
        gender: updatedProfile.gender,
        maritalStatus: updatedProfile.maritalStatus,
        createdBy: updatedProfile.createdBy,
        modifiedBy: updatedProfile.modifiedBy,
        isDelete: updatedProfile.isDelete,
        skills: updatedProfile.skills,
      );

      final success = await _api.updateProfile(profileRequest);
      if (!success) {
        // Handle the error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<JobSeekerProfileResponse>(
        future: _jobSeekerProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final jobSeekerProfile = snapshot.data!;
            _skills = jobSeekerProfile.skills ?? [];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _skillController,
                          decoration: const InputDecoration(
                            labelText: 'Add a new skill',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: _addSkill,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _skills.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.check),
                        title: Text(_skills[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
