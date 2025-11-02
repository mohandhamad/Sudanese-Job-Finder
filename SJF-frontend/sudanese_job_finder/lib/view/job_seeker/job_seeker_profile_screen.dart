import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/job_seeker_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/account_data_response.dart';
import 'package:sudanese_job_finder/model/job_seeker_profile_response.dart';
import 'package:sudanese_job_finder/services/job_seeker_services.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/date_widget.dart';
import 'package:sudanese_job_finder/widget/global/dropdown_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/pick_image_dialog_body_widget.dart';
import 'package:sudanese_job_finder/widget/global/profile_header_widget.dart';
import 'package:sudanese_job_finder/widget/global/require_label_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';

class JobSeekerProfileScreen extends StatefulWidget {
  const JobSeekerProfileScreen({super.key});

  @override
  State<JobSeekerProfileScreen> createState() => _JobSeekerProfileScreenState();
}

class _JobSeekerProfileScreenState extends State<JobSeekerProfileScreen> {
  final TextEditingController _controller = TextEditingController();
  JobSeekerProfileResponse _profileOBJ = JobSeekerProfileResponse();
  final _api = JobSeekerServices();
  bool _isLoading = false;
  bool _isNotFill = false;
  File? _file;

  // Default values for JobSeekerProfileResponse to avoid exceptions
  JobSeekerProfileResponse getDefaultProfile() {
    return JobSeekerProfileResponse(
      id: 0,
      nationalId: '',
      firstName: '',
      middleName: '',
      lastName: '',
      birthDate: DateTime.now(),
      gender: '',
      maritalStatus: '',
      skills: [],
      image: '',
      // ... add other required fields with default values
    );
  }

  List gender = [
    {'name': 'Male', 'value': 'M'},
    {'name': 'Female', 'value': 'F'}
  ];

  List maritalStatus = [
    {'name': 'Single', 'value': 'Single'},
    {'name': 'Married', 'value': 'Married'}
  ];

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<JobSeekerProfileProvider>(context, listen: false);
    if (profileProvider.jobSeekerProfileList.isNotEmpty) {
      _profileOBJ = profileProvider.jobSeekerProfileList[0];
    } else {
      _profileOBJ = getDefaultProfile();
    }
    if (_profileOBJ.birthDate != null) {
      _controller.text =
          DateFormat('yyyy-MM-dd').format(_profileOBJ.birthDate as DateTime);
    }
  }

  void patchData() {
    if (_profileOBJ.nationalId == null ||
        _profileOBJ.firstName == null ||
        _profileOBJ.middleName == null ||
        _profileOBJ.lastName == null ||
        _controller.text.isEmpty ||
        _profileOBJ.maritalStatus == null) {
      setState(() => _isNotFill = true);
      errorToast('Plz, Fill all fields');
      return;
    }
    if (_profileOBJ.nationalId!.length > 16) {
      errorToast('The national id length must be less then 16 characters');
      return;
    }
    if (_profileOBJ.firstName!.length > 16) {
      errorToast('The first name length must be less then 16 characters');
      return;
    }
    if (_profileOBJ.middleName!.length > 16) {
      errorToast('The middle name length must be less then 16 characters');
      return;
    }
    if (_profileOBJ.lastName!.length > 16) {
      errorToast('The last name length must be less then 16 characters');
      return;
    }
    if (_profileOBJ.maritalStatus!.length > 7) {
      errorToast(
          'The marital status site length must be less then 7 characters');
      return;
    }
    final dateFormat = DateFormat("yyyy-MM-dd");
    _profileOBJ.birthDate = dateFormat.parse(_controller.text);
    setState(() => _isLoading = true);
    _api.patchProfile(context, _profileOBJ, _file).then((response) {
      if (response) {
        getData();
        successToast("Update sccessfuily");
      }
      setState(() {
        _isLoading = false;
        _isNotFill = false;
      });
    });
  }

  void getData() {
    Provider.of<JobSeekerProfileProvider>(context, listen: false)
        .getJobSeekerProfile();
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final accountDataProvider = Provider.of<AccountDataProvider>(context);
    final profileProvider = Provider.of<JobSeekerProfileProvider>(context);

    // Check if account data and profile data are available
    if (accountDataProvider.accountDataList.isEmpty ||
        profileProvider.jobSeekerProfileList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColor.appPrimaryColor,
          ),
        ),
      );
    }

    final accountData = accountDataProvider.accountDataList[0];
    if (profileProvider.jobSeekerProfileList.isNotEmpty) {
      _profileOBJ = profileProvider.jobSeekerProfileList[0];
    } else {
      _profileOBJ = getDefaultProfile();
    }

    return Container(
      child: _profileBody(accountData, context),
    );
  }

  SingleChildScrollView _profileBody(
      AccountDataResponse accountData, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ProfileHeaderWidget(
              username: accountData.username!,
              email: accountData.email!,
              image: _profileOBJ.image ?? '',
              file: _file,
              voidCallback: () => _pickImageDialog(),
            ),
            const SizedBox(height: 15),
            _profileForm(context, accountData),
          ],
        ),
      ),
    );
  }

  Container _profileForm(
      BuildContext context, AccountDataResponse accountData) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColor.shadow,
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequireLabelWidget(
            label: 'National ID',
            isNotFill: _isNotFill,
          ),
          UpdateTxtFieldWidget(
            value: _profileOBJ.nationalId,
            textInputType: TextInputType.number,
            icon: CupertinoIcons.person_crop_rectangle_fill,
            onChanged: (nationalId) =>
                _profileOBJ = _profileOBJ.copyWith(nationalId: nationalId),
          ),
          const SizedBox(height: 10),
          RequireLabelWidget(
            label: 'First Name',
            isNotFill: _isNotFill,
          ),
          UpdateTxtFieldWidget(
            value: _profileOBJ.firstName,
            textInputType: TextInputType.name,
            icon: CupertinoIcons.person_alt_circle,
            onChanged: (firstName) =>
                _profileOBJ = _profileOBJ.copyWith(firstName: firstName),
          ),
          const SizedBox(height: 10),
          const Text('Middle Name'),
          UpdateTxtFieldWidget(
            value: _profileOBJ.middleName,
            textInputType: TextInputType.name,
            icon: CupertinoIcons.person_alt_circle,
            onChanged: (middleName) =>
                _profileOBJ = _profileOBJ.copyWith(middleName: middleName),
          ),
          const SizedBox(height: 10),
          const Text('Last Name'),
          UpdateTxtFieldWidget(
            value: _profileOBJ.lastName,
            textInputType: TextInputType.name,
            icon: CupertinoIcons.person_alt_circle,
            onChanged: (lastName) =>
                _profileOBJ = _profileOBJ.copyWith(lastName: lastName),
          ),
          const SizedBox(height: 20),
          DateFieldWidget(
            controller: _controller,
            labelText: 'Birth Date',
            now: _profileOBJ.birthDate,
          ),
          const SizedBox(height: 20),
          DropdownButtonWidget(
            listData: gender,
            onChanged: (gender) => _profileOBJ = _profileOBJ.copyWith(
              gender: gender,
            ),
            selectedValue: _profileOBJ.gender,
            labelText: 'Gender',
            mapText: 'name',
            mapValue: 'value',
          ),
          const SizedBox(height: 20),
          DropdownButtonWidget(
            listData: maritalStatus,
            onChanged: (maritalStatus) => _profileOBJ = _profileOBJ.copyWith(
              maritalStatus: maritalStatus,
            ),
            selectedValue: _profileOBJ.maritalStatus,
            labelText: 'Marital Status',
            mapText: 'name',
            mapValue: 'value',
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColor.appPrimaryColor,
              ),
            )
          else
            BtnWidget(
              btnName: 'Update',
              voidCallback: () {
                _profileOBJ.createdBy = accountData.id;
                _profileOBJ.modifiedBy = accountData.id;
                _profileOBJ.isDelete = false;
                patchData();
              },
            ),
        ],
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) return;
    setState(() => _file = File(returnedImage.path));
    if (mounted) Navigator.of(context).pop();
  }

  void _pickImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PickImageDialogBodyWidget(
          voidCallbackCamera: () => _pickImage(ImageSource.camera),
          voidCallbackGallery: () => _pickImage(ImageSource.gallery),
        );
      },
    );
  }
}
