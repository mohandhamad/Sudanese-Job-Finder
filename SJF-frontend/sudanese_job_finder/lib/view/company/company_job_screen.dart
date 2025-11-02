import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/company_job_request.dart';
import 'package:sudanese_job_finder/model/company_job_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/company_widget/company_job_widget.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/date_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/radio_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';

class CompanyJobScreen extends StatefulWidget {
  const CompanyJobScreen({super.key});

  @override
  State<CompanyJobScreen> createState() => _CompanyJobScreenState();
}

class _CompanyJobScreenState extends State<CompanyJobScreen> {
  // final TextEditingController _startAt = TextEditingController();
  final TextEditingController _deadline = TextEditingController();
  final _api = CompanyServices();
  CompanyJobRequest _request = CompanyJobRequest();
  CompanyJobResponse _response = CompanyJobResponse();
  bool _isLoading = false;

  Future<List<CompanyJobResponse>> fetchData() async {
    final id = Provider.of<CompanyProfileProvider>(context, listen: false)
        .companyProfileList[0]
        .id;
    final response = _api.getJobs(id!);
    return response;
  }

  void postData() {
    final id = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0]
        .id;
    final profileId =
        Provider.of<CompanyProfileProvider>(context, listen: false)
            .companyProfileList[0]
            .id;
    if (_request.jobTitle == null || _deadline.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_request.jobTitle!.length > 50) {
      errorToast('The Role name must be less then 50 characters');
      return;
    }
    if (_request.salary!.length > 10) {
      errorToast('Please enter a number with up to 10 digits');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _request.deadline = dateFormat.parse(_deadline.text);
    _request.companyProfile = profileId;
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    // print('Posting job with data: ${_request.toJson()}');
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postJob(_request).then((response) {
      // print('API response: $response');
      if (response) {
        successToast("Add successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    }).catchError((error) {
      // Log error
      // print('API call error: $error');
      unhandledExceptionMessage(context);
      setState(() => _isLoading = false);
    });
  }

  void patchData() {
    final id = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0]
        .id;
    final profileId =
        Provider.of<CompanyProfileProvider>(context, listen: false)
            .companyProfileList[0]
            .id;
    if (_response.jobTitle == null || _deadline.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_response.jobTitle!.length > 50) {
      errorToast('The Role name must be less then 50 characters');
      return;
    }
    if (_request.salary!.length > 10) {
      errorToast('Please enter a decimal number with up to 10 digits');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _response.companyProfile = profileId;
    _response.deadline = dateFormat.parse(_deadline.text);
    _response.createdBy = id;
    _response.modifiedBy = id;
    _response.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.patchJob(_response.id!, _response).then((response) {
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
    _api.deleteJob(id).then((response) {
      if (response) {
        successToast("Delete successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  // Mapping between display options and database values
  final Map<String, String> jobTypeMapping = {
    'Full Time': 'fulltime',
    'Part Time': 'parttime',
    'Internship': 'internship',
  };

  // Reverse mapping between database values and display options
  final Map<String, String> reverseJobTypeMapping = {
    'fulltime': 'Full Time',
    'parttime': 'Part Time',
    'internship': 'Internship',
  };

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _deadline.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Jobs', isHome: false),
      body: FutureBuilder(
        future: fetchData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CompanyJobResponse>> snapshot,
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
            return _jobBody(context, data);
          }
        },
      ),
    );
  }

  SingleChildScrollView _jobBody(
      BuildContext context, List<CompanyJobResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 150,
              child: BtnWidget(
                btnName: "New Job",
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
              return CompanyJobWidget(
                jobTitle: data[index].jobTitle ?? '',
                deadline: data[index].deadline?.toIso8601String() ?? '',
                salary: data[index].salary ?? '',
                voidCallbackDelete: () => deleteData(data[index].id!),
                voidCallbackUpdate: () => _openDialog(
                  context: context,
                  isPost: false,
                  obj: data[index],
                ),
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
    CompanyJobResponse? obj,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (!isPost) {
          _response = obj!;
          _deadline.text = obj.deadline.toString();
        } else {
          _deadline.clear();
          _request.clear();
        }
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Jobs',
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
            'Job Title',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.jobTitle : _response.jobTitle,
            textInputType: TextInputType.name,
            onChanged: (jobTitle) => isPost
                ? _request = _request.copyWith(jobTitle: jobTitle)
                : _response = _response.copyWith(jobTitle: jobTitle),
          ),
          const SizedBox(height: 10),
          const Text(
            'Salary',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.salary : _response.salary,
            textInputType: TextInputType.number,
            onChanged: (salary) => isPost
                ? _request = _request.copyWith(salary: salary)
                : _response = _response.copyWith(salary: salary),
          ),
          const SizedBox(height: 10),
          DateFieldWidget(controller: _deadline, labelText: 'Post Deadline'),
          const SizedBox(height: 10),
          const Text(
            'Job Type',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          RadioButtonWidget(
            selectedValue: isPost
                ? reverseJobTypeMapping[
                    _request.jobType] // Map database value to display option
                : reverseJobTypeMapping[
                    _response.jobType], // Map database value to display option
            options: jobTypeMapping.keys.toList(), // Use display options
            onChanged: (selectedDisplayOption) {
              final selectedDatabaseValue = jobTypeMapping[
                  selectedDisplayOption]; // Map display option to database value
              if (isPost) {
                // Update _request with the database value
                setState(() {
                  _request = _request.copyWith(jobType: selectedDatabaseValue);
                });
              } else {
                // Update _response with the database value
                setState(() {
                  _response =
                      _response.copyWith(jobType: selectedDatabaseValue);
                });
              }
            },
          ),
          // UpdateTxtFieldWidget(
          //   value: isPost ? _request.jobType : _response.jobType,
          //   textInputType: TextInputType.name,
          //   onChanged: (jobType) => isPost
          //       ? _request = _request.copyWith(jobType: jobType)
          //       : _response = _response.copyWith(jobType: jobType),
          //   maxLine: 4,
          // ),
          const SizedBox(height: 10),
          const Text(
            'Job Field',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.jobField : _response.jobField,
            textInputType: TextInputType.name,
            onChanged: (jobField) => isPost
                ? _request = _request.copyWith(jobField: jobField)
                : _response = _response.copyWith(jobField: jobField),
            maxLine: 4,
          ),
          const SizedBox(height: 10),
          const Text(
            'Required Skills',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.skills : _response.skills,
            textInputType: TextInputType.name,
            onChanged: (skills) => isPost
                ? _request = _request.copyWith(skills: skills)
                : _response = _response.copyWith(skills: skills),
            maxLine: 4,
          ),
          const SizedBox(height: 10),
          const Text(
            'Experience Level',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          RadioButtonWidget(
            selectedValue: isPost ? _request.expLevel : _response.expLevel,
            options: const ['Entry-level', 'Intermediate', 'Senior'],
            onChanged: (expLevel) {
              if (isPost) {
                setState(() {
                  _request = _request.copyWith(expLevel: expLevel);
                });
              } else {
                setState(() {
                  _response = _response.copyWith(expLevel: expLevel);
                });
              }
            },
          ),
          // UpdateTxtFieldWidget(
          //   value: isPost ? _request.expLevel : _response.expLevel,
          //   textInputType: TextInputType.name,
          //   onChanged: (expLevel) => isPost
          //       ? _request = _request.copyWith(expLevel: expLevel)
          //       : _response = _response.copyWith(expLevel: expLevel),
          //   maxLine: 4,
          // ),
          const SizedBox(height: 10),
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.jobDescription : _response.jobDescription,
            textInputType: TextInputType.name,
            onChanged: (jobDescription) => isPost
                ? _request = _request.copyWith(jobDescription: jobDescription)
                : _response =
                    _response.copyWith(jobDescription: jobDescription),
            maxLine: 4,
          ),
        ],
      ),
    );
  }
}
