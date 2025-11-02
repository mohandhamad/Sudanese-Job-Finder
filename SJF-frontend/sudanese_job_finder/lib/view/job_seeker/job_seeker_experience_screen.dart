import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_experience_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_experience_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/date_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_experience_card_widget.dart';

class JobSeekerExperienceScreen extends StatefulWidget {
  const JobSeekerExperienceScreen({super.key});

  @override
  State<JobSeekerExperienceScreen> createState() =>
      _JobSeekerExperienceScreenState();
}

class _JobSeekerExperienceScreenState extends State<JobSeekerExperienceScreen> {
  final _api = JobSeekerServices();
  JobSeekerExperienceRequest _request = JobSeekerExperienceRequest();
  JobSeekerExperienceResponse _response = JobSeekerExperienceResponse();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  bool _isLoading = false;

  Future<List<JobSeekerExperienceResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getExperience(id!);
    return response;
  }

  void postData() {
    final id = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0]
        .id;
    final profileId =
        Provider.of<JobSeekerProfileProvider>(context, listen: false)
            .jobSeekerProfileList[0]
            .id;
    if (_request.experienceRole == null ||
        _endDate.text.isEmpty ||
        _startDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_request.experienceRole!.length > 30) {
      errorToast('The Experience Role must be less then 30 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _request.jobSeekerProfile = profileId;
    _request.startDate = dateFormat.parse(_startDate.text);
    _request.endDate = dateFormat.parse(_endDate.text);
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postExperience(_request).then((response) {
      if (response) {
        successToast("Add successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  void patchData() {
    final id = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0]
        .id;
    if (_response.experienceRole == null ||
        _endDate.text.isEmpty ||
        _startDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_response.experienceRole!.length > 30) {
      errorToast('The Experience Role must be less then 30 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _response.startDate = dateFormat.parse(_startDate.text);
    _response.endDate = dateFormat.parse(_endDate.text);
    _response.createdBy = id;
    _response.modifiedBy = id;
    _response.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.patchExperience(_response.id!, _response).then((response) {
      if (response) {
        successToast('Update successfuilly');
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  void deleteData(int id) {
    setState(() => _isLoading = true);
    _api.deleteExperience(id).then((response) {
      if (response) {
        successToast("Delete successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _startDate.dispose();
    _endDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<JobSeekerExperienceResponse>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.appPrimaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Image.asset(AppStrings.appError));
        } else {
          final data = snapshot.data!;
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appPrimaryColor,
              ),
            );
          }
          return _experienceBody(context, data);
        }
      },
    );
  }

  SingleChildScrollView _experienceBody(
      BuildContext context, List<JobSeekerExperienceResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 200,
              child: BtnWidget(
                btnName: "New Experience",
                voidCallback: () => _openDialog(
                  context: context,
                  isPost: true,
                ),
              ),
            ),
          ),
          NonScrollableListViewWidget(
            itemCount: data.length,
            itemBuilder: (BuildContext context, index) {
              return JobSeekerExperienceCardWidget(
                voidCallbackDelete: () => deleteData(data[index].id!),
                voidCallbackUpdate: () {
                  _openDialog(
                    context: context,
                    isPost: false,
                    obj: data[index],
                  );
                },
                role: data[index].experienceRole ?? '',
                start: data[index].startDate.toString(),
                end: data[index].endDate.toString(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openDialog({
    required BuildContext context,
    required bool isPost,
    JobSeekerExperienceResponse? obj,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (!isPost) {
          _response = obj!;
          _startDate.text = obj.startDate.toString();
          _endDate.text = obj.endDate.toString();
        } else {
          _request.clear();
          _startDate.clear();
          _endDate.clear();
        }
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Academic Professional',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColor.appPrimaryColor,
            ),
          ),
          content: _dialogBody(isPost),
          actions: [
            TxtBtnWidget(
              voidCallback: () {
                Navigator.of(context).pop();
              },
              btnName: 'Cancel',
            ),
            TxtBtnWidget(
              voidCallback: () {
                isPost ? postData() : patchData();
              },
              btnName: 'Submit',
            )
          ],
        );
      },
    );
  }

  SingleChildScrollView _dialogBody(bool isPost) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Experience Role',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.experienceRole : _response.experienceRole,
            textInputType: TextInputType.name,
            onChanged: (experienceRole) => isPost
                ? _request = _request.copyWith(experienceRole: experienceRole)
                : _response =
                    _response.copyWith(experienceRole: experienceRole),
          ),
          const SizedBox(height: 20),
          DateFieldWidget(
            controller: _startDate,
            labelText: 'Start Date',
            now: isPost ? _request.startDate : _response.startDate,
          ),
          const SizedBox(height: 20),
          DateFieldWidget(
            controller: _endDate,
            labelText: 'End Date',
            now: isPost ? _request.endDate : _response.endDate,
          ),
          const SizedBox(height: 10),
          const Text(
            'Job Duties',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.jobDuties : _response.jobDuties,
            textInputType: TextInputType.text,
            maxLine: 3,
            onChanged: (jobDuties) => isPost
                ? _request = _request.copyWith(jobDuties: jobDuties)
                : _response = _response.copyWith(jobDuties: jobDuties),
          ),
          const SizedBox(height: 10),
          const Text(
            'Implemented Projects',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost
                ? _request.implementedProjects
                : _response.implementedProjects,
            textInputType: TextInputType.text,
            maxLine: 3,
            onChanged: (implementedProjects) => isPost
                ? _request =
                    _request.copyWith(implementedProjects: implementedProjects)
                : _response = _response.copyWith(
                    implementedProjects: implementedProjects),
          ),
        ],
      ),
    );
  }
}
