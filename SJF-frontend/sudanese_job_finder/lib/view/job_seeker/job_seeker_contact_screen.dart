import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_contact_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_contact_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_contact_card_widget.dart';

class JobSeekerContactScreen extends StatefulWidget {
  const JobSeekerContactScreen({super.key});

  @override
  State<JobSeekerContactScreen> createState() => _JobSeekerContactScreenState();
}

class _JobSeekerContactScreenState extends State<JobSeekerContactScreen> {
  final _api = JobSeekerServices();
  JobSeekerContactRequest _request = JobSeekerContactRequest();
  JobSeekerContactResponse _response = JobSeekerContactResponse();
  bool _isLoading = false;

  Future<List<JobSeekerContactResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getContact(id!);
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
    if (_request.type == null || _request.contactNumber == null) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_request.type!.length > 50) {
      errorToast('The contact type must be less then 50 characters');
      return;
    }
    if (_request.contactNumber!.length > 100) {
      errorToast('The contact content must be less then 100 characters');
      return;
    }
    _request.jobSeekerProfile = profileId;
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postContact(_request).then((response) {
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
    if (_response.type == null || _response.contactNumber == null) {
      errorToast('Plz, fill all fields');
      return;
    }
    if (_response.type!.length > 50) {
      errorToast('The contact type must be less then 50 characters');
      return;
    }
    if (_response.contactNumber!.length > 100) {
      errorToast('The contact content must be less then 100 characters');
      return;
    }
    _response.createdBy = id;
    _response.modifiedBy = id;
    _response.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.patchContact(_response.id!, _response).then((response) {
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
    _api.deleteContact(id).then((response) {
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<JobSeekerContactResponse>> snapshot,
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
          return _contactBody(context, data);
        }
      },
    );
  }

  SingleChildScrollView _contactBody(
      BuildContext context, List<JobSeekerContactResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 150,
              child: BtnWidget(
                btnName: "New Contect",
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
              return JobSeekerContactCardWidget(
                type: data[index].type ?? '',
                content: data[index].contactNumber ?? '',
                voidCallbackDelete: () => deleteData(data[index].id!),
                voidCallbackUpdate: () {
                  _openDialog(
                    context: context,
                    isPost: false,
                    obj: data[index],
                  );
                },
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
    JobSeekerContactResponse? obj,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (!isPost) {
          _response = obj!;
        } else {
          _request.clear();
        }
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Contact',
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
            'Contact Type',
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
            'Content',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          const SizedBox(height: 3),
          UpdateTxtFieldWidget(
            value: isPost ? _request.contactNumber : _response.contactNumber,
            textInputType: TextInputType.name,
            onChanged: (contactNumber) => isPost
                ? _request = _request.copyWith(contactNumber: contactNumber)
                : _response = _response.copyWith(contactNumber: contactNumber),
          ),
        ],
      ),
    );
  }
}
