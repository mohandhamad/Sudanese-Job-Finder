import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_qualifications_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_qualifications_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/date_widget.dart';
import 'package:sudanese_job_finder/widget/global/dropdown_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_qualification_card_widget.dart';

class JobSeekerQualificationsScreen extends StatefulWidget {
  const JobSeekerQualificationsScreen({super.key});

  @override
  State<JobSeekerQualificationsScreen> createState() =>
      _JobSeekerQualificationsScreenState();
}

class _JobSeekerQualificationsScreenState
    extends State<JobSeekerQualificationsScreen> {
  final _api = JobSeekerServices();
  JobSeekerQualificationsRequest _request = JobSeekerQualificationsRequest();
  JobSeekerQualificationsResponse _response = JobSeekerQualificationsResponse();
  final TextEditingController _graduationDate = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  bool _isLoading = false;

  List degree = [
    {'name': 'Bachelors', 'value': 'Bachelors'},
    {'name': 'Master', 'value': 'Master'},
    {'name': 'Doctorate', 'value': 'Doctorate'},
    {'name': 'Associates Degree', 'value': 'Associates Degree'},
    {'name': 'Professional Degrees', 'value': 'Professional Degrees'},
  ];

  List gpa = [
    {'name': '100', 'value': '100'},
    {'name': '5', 'value': '5'},
    {'name': '4', 'value': '4'},
  ];

  Future<List<JobSeekerQualificationsResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getQualifications(id!);
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
    if (_request.degree == null ||
        _request.major == null ||
        _request.school == null ||
        _graduationDate.text.isEmpty ||
        _request.gpa == null ||
        _request.grade == null ||
        _startDate.text.isEmpty ||
        _endDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_request.school!.length > 30) {
      errorToast(
          'The Educational organization must be less then 30 characters');
      return;
    }
    if (_request.grade!.length > 3) {
      errorToast('The Grade must be less then 3 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _request.jobSeekerProfile = profileId;
    _request.graduationDate = dateFormat.parse(_graduationDate.text);
    _request.startDate = dateFormat.parse(_startDate.text);
    _request.endDate = dateFormat.parse(_endDate.text);
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postQualifications(_request).then((response) {
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
    if (_response.degree == null ||
        _response.major == null ||
        _response.school == null ||
        _graduationDate.text.isEmpty ||
        _response.gpa == null ||
        _response.grade == null ||
        _startDate.text.isEmpty ||
        _endDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_response.school!.length > 30) {
      errorToast(
          'The Educational organization must be less then 30 characters');
      return;
    }
    if (_response.grade!.length > 3) {
      errorToast('The Grade must be less then 3 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _response.graduationDate = dateFormat.parse(_graduationDate.text);
    _response.startDate = dateFormat.parse(_startDate.text);
    _response.endDate = dateFormat.parse(_endDate.text);
    _response.createdBy = id;
    _response.modifiedBy = id;
    _response.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.patchQualifications(_response.id!, _response).then((response) {
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
    _api.deleteQualifications(id).then((response) {
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
    _graduationDate.dispose();
    _startDate.dispose();
    _endDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<JobSeekerQualificationsResponse>> snapshot,
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
          return _qualificationsBody(context, data);
        }
      },
    );
  }

  SingleChildScrollView _qualificationsBody(
      BuildContext context, List<JobSeekerQualificationsResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 275,
              child: BtnWidget(
                btnName: "New Academic Qualification",
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
              return JobSeekerQualificationCardWidget(
                major: data[index].major ?? '',
                org: data[index].school ?? '',
                degree: data[index].degree ?? '',
                grade: data[index].grade ?? '',
                voidCallbackUpdate: () {
                  _openDialog(
                    context: context,
                    isPost: false,
                    obj: data[index],
                  );
                },
                voidCallbackDelete: () => deleteData(data[index].id!),
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
    JobSeekerQualificationsResponse? obj,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (!isPost) {
          _response = obj!;
          _graduationDate.text = obj.graduationDate.toString();
          _startDate.text = obj.startDate.toString();
          _endDate.text = obj.endDate.toString();
        } else {
          _request.clear();
          _graduationDate.clear();
          _startDate.clear();
          _endDate.clear();
        }
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Academic Qualifications',
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
            'Major',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.major : _response.major,
            textInputType: TextInputType.name,
            onChanged: (major) => isPost
                ? _request = _request.copyWith(major: major)
                : _response = _response.copyWith(major: major),
          ),
          const SizedBox(height: 20),
          DropdownButtonWidget(
            listData: degree,
            onChanged: (degree) => isPost
                ? _request = _request.copyWith(degree: degree)
                : _response = _response.copyWith(
                    degree: degree,
                  ),
            selectedValue: isPost ? _request.degree : _response.degree,
            labelText: 'Degree',
            mapText: 'name',
            mapValue: 'value',
          ),
          const SizedBox(height: 10),
          const Text(
            'Educational organization',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.school : _response.school,
            textInputType: TextInputType.name,
            onChanged: (school) => isPost
                ? _request = _request.copyWith(school: school)
                : _response = _response.copyWith(school: school),
          ),
          const SizedBox(height: 20),
          DateFieldWidget(
            controller: _graduationDate,
            labelText: 'Graduation Date',
            now: isPost ? _request.graduationDate : _response.graduationDate,
          ),
          const SizedBox(height: 20),
          DropdownButtonWidget(
            listData: gpa,
            onChanged: (gpa) => isPost
                ? _request = _request.copyWith(gpa: gpa)
                : _response = _response.copyWith(
                    gpa: gpa,
                  ),
            selectedValue: isPost ? _request.gpa : _response.gpa,
            labelText: 'GPA',
            mapText: 'name',
            mapValue: 'value',
          ),
          const SizedBox(height: 10),
          const Text(
            'Grade',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.grade : _response.grade,
            textInputType: TextInputType.number,
            onChanged: (grade) => isPost
                ? _request = _request.copyWith(grade: grade)
                : _response = _response.copyWith(grade: grade),
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
        ],
      ),
    );
  }
}
