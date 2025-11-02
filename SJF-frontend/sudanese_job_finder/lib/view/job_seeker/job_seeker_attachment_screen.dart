import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/job_seeker_attachment_request.dart';
import 'package:sudanese_job_finder/model/job_seeker_attachment_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/job_seeker_attachment_card_widget.dart';

class JobSeekerAttchment extends StatefulWidget {
  const JobSeekerAttchment({super.key});

  @override
  State<JobSeekerAttchment> createState() => _JobSeekerAttchmentState();
}

class _JobSeekerAttchmentState extends State<JobSeekerAttchment> {
  JobSeekerAttachmentRequest _request = JobSeekerAttachmentRequest();
  final _api = JobSeekerServices();
  bool _isLoading = false;
  bool _isFileSelected = false;
  FilePickerResult? _file;

  Future<List<JobSeekerAttachmentResponse>> fetchData() async {
    final id = Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .jobSeekerProfileList[0]
        .id;
    final response = _api.getAttachment(id!);
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
    if (_request.jobSeekerAttachmentType == null) {
      errorToast('Plz, fill attachment type.');
      return;
    }
    if (_file == null) {
      errorToast('Plz select file');
      return;
    }
    _request.jobSeekerProfile = profileId;
    _request.createdBy = id;
    _request.modifiedBy = id;
    _request.isDelete = false;
    setState(() => _isLoading = true);
    Navigator.of(context).pop();
    _api.postAttachment(context, _request).then((response) {
      if (response) {
        successToast("Add successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  void deleteData(int id) {
    setState(() => _isLoading = true);
    _api.deleteAttachment(id).then((response) {
      if (response) {
        successToast("Delete successfuilly");
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLoading = false);
    });
  }

  void selectAndSendFile(StateSetter showDialogState) async {
    _file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (_file != null) {
      PlatformFile platformFile = _file!.files.single;
      String? path = platformFile.path;

      if (path != null) {
        String fileName = p.basename(path);
        String extension = p.extension(fileName);
        if (extension == '.pdf') {
          File file = File(path);
          int fileSize = await file.length();
          int maxSizeInBytes = 2 * 1024 * 1024;
          if (fileSize > maxSizeInBytes) {
            if (mounted) {
              errorToast('The file size must be 2MG');
            }
          } else {
            showDialogState(() {
              _isFileSelected = true;
            });
            _request.fileData = file.path;
          }
        } else {
          if (mounted) {
            _file = null;
            _isFileSelected = false;
            errorToast('The file must be PDF');
          }
        }
      } else {
        if (mounted) {
          errorToast('you have to select file');
        }
      }
    }
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
        AsyncSnapshot<List<JobSeekerAttachmentResponse>> snapshot,
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
          return _attachmentBody(context, data);
        }
      },
    );
  }

  SingleChildScrollView _attachmentBody(
      BuildContext context, List<JobSeekerAttachmentResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 175,
              child: BtnWidget(
                btnName: "New Attachment",
                voidCallback: () => _openDialog(context),
              ),
            ),
          ),
          NonScrollableListViewWidget(
            itemCount: data.length,
            itemBuilder: (BuildContext context, index) {
              return JobSeekerAttachmentCardWidget(
                content: data[index].jobSeekerAttachmentType ?? '',
                voidCallbackDelete: () {
                  deleteData(data[index].id!);
                },
                voidCallbackShow: () {
                  GoRouter.of(context).pushNamed(
                    AppRoute.showPDFRouteName,
                    pathParameters: {
                      'base64String': data[index].fileData ?? ''
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  _openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        _request.clear();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              title: const Text(
                'Attachment',
                style: TextStyle(
                  color: AppColor.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Attachment Type'),
                  const SizedBox(height: 3),
                  UpdateTxtFieldWidget(
                    value: _request.jobSeekerAttachmentType,
                    textInputType: TextInputType.text,
                    onChanged: (jobSeekerAttachmentType) {
                      _request = _request.copyWith(
                        jobSeekerAttachmentType: jobSeekerAttachmentType,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      selectAndSendFile(setState);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isFileSelected
                            ? AppColor.appPrimaryColor
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: AppColor.appPrimaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: AppColor.appPrimaryColor,
                    ),
                  ),
                  onPressed: () {
                    postData();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
