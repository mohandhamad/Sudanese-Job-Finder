import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_professional_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_professional_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/date_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_professional_card_widget.dart';

class JobSeekerProfessionalScreen extends StatefulWidget {
  const JobSeekerProfessionalScreen({super.key});

  @override
  State<JobSeekerProfessionalScreen> createState() =>
      _JobSeekerProfessionalScreenState();
}

class _JobSeekerProfessionalScreenState
    extends State<JobSeekerProfessionalScreen> {
  final _api = JobSeekerServices();
  JobSeekerProfessionalRequest _request = JobSeekerProfessionalRequest();
  JobSeekerProfessionalResponse _response = JobSeekerProfessionalResponse();
  final TextEditingController _examDate = TextEditingController();
  bool _isLoading = false;

  Future<List<JobSeekerProfessionalResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getProfessional(id!);
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
    if (_request.type == null ||
        _request.mark == null ||
        _examDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_request.type!.length > 30) {
      errorToast('The certificate name must be less then 30 characters');
      return;
    }
    if (_request.mark!.length > 3) {
      errorToast('The mark must be less then 100 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _request.jobSeekerProfile = profileId;
    _request.examDate = dateFormat.parse(_examDate.text);
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postProfessional(_request).then((response) {
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
    if (_response.type == null ||
        _response.mark == null ||
        _examDate.text.isEmpty) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_response.type!.length > 30) {
      errorToast('The certificate name must be less then 30 characters');
      return;
    }
    if (_response.mark!.length > 3) {
      errorToast('The mark must be less then 3 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _response.examDate = dateFormat.parse(_examDate.text);
    _response.createdBy = id;
    _response.modifiedBy = id;
    _response.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.patchProfessional(_response.id!, _response).then((response) {
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
    _api.deleteProfessional(id).then((response) {
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
    _examDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<JobSeekerProfessionalResponse>> snapshot,
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
          return _professionalBody(context, data);
        }
      },
    );
  }

  SingleChildScrollView _professionalBody(
      BuildContext context, List<JobSeekerProfessionalResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 275,
              child: BtnWidget(
                btnName: "New Professional Certificate",
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
              return JobSeekerProfessionalCardWidget(
                voidCallbackDelete: () => deleteData(data[index].id!),
                voidCallbackUpdate: () {
                  _openDialog(
                    context: context,
                    isPost: false,
                    obj: data[index],
                  );
                },
                type: data[index].type ?? '',
                mark: data[index].mark ?? '',
                examDate: data[index].examDate.toString(),
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
    JobSeekerProfessionalResponse? obj,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (!isPost) {
          _response = obj!;
          _examDate.text = obj.examDate.toString();
        } else {
          _request.clear();
          _examDate.clear();
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
            'Certificate Name',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.type : _response.type,
            textInputType: TextInputType.name,
            onChanged: (type) => isPost
                ? _request = _request.copyWith(type: type)
                : _response = _response.copyWith(type: type),
          ),
          const SizedBox(height: 10),
          const Text(
            'Mark',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.mark : _response.mark,
            textInputType: TextInputType.number,
            onChanged: (mark) => isPost
                ? _request = _request.copyWith(mark: mark)
                : _response = _response.copyWith(mark: mark),
          ),
          const SizedBox(height: 20),
          DateFieldWidget(
            controller: _examDate,
            labelText: 'End Date',
            now: isPost ? _request.examDate : _response.examDate,
          ),
        ],
      ),
    );
  }
}
