import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_route.dart';
import 'package:sudanese_job_finder/model/account_data_response.dart';
import 'package:sudanese_job_finder/model/company_profile_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/pick_image_dialog_body_widget.dart';
import 'package:sudanese_job_finder/widget/global/profile_card_widget.dart';
import 'package:sudanese_job_finder/widget/global/profile_header_widget.dart';
import 'package:sudanese_job_finder/widget/global/require_label_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  CompanyProfileResponse _profileOBJ = CompanyProfileResponse();
  final _api = CompanyServices();
  bool _isLoading = false;
  bool _isNotFill = false;
  File? _file;

  void patchData() {
    if (_profileOBJ.companyName == null ||
        _profileOBJ.mobile == null ||
        _profileOBJ.description == null) {
      setState(() => _isNotFill = true);
      errorToast('Plz, Fill all fields');
      return;
    }
    if (_profileOBJ.companyName!.length > 50) {
      errorToast('The Company name length must be less then 50 characters');
      return;
    }
    if (_profileOBJ.description!.length > 200) {
      errorToast(
          'The Company description length must be less then 200 characters');
      return;
    }
    if (_profileOBJ.webSite!.length > 200) {
      errorToast(
          'The Company web site length must be less then 200 characters');
      return;
    }
    // if (!isValidMobileNumber(_profileOBJ.mobile!)) {
    //   errorToast('mobile number start with\n +(code) xxxxxxxx');
    //   return;
    // }
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
    Provider.of<CompanyProfileProvider>(context, listen: false)
        .getCompanyProfile();
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountData =
        Provider.of<AccountDataProvider>(context).accountDataList[0];
    _profileOBJ =
        Provider.of<CompanyProfileProvider>(context).companyProfileList[0];
    return Scaffold(
      appBar: const AppBarWidget(isHome: false, title: 'Profile'),
      body: _profileBody(accountData, context),
    );
  }

  SingleChildScrollView _profileBody(
      AccountDataResponse accountData, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            ProfileCardWidget(
              voidCallback: () => GoRouter.of(context)
                  .pushNamed(AppRoute.companyGalleryRouteName),
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
            label: 'Company Name',
            isNotFill: _isNotFill,
          ),
          UpdateTxtFieldWidget(
            value: _profileOBJ.companyName,
            textInputType: TextInputType.name,
            icon: CupertinoIcons.building_2_fill,
            onChanged: (companyName) =>
                _profileOBJ = _profileOBJ.copyWith(companyName: companyName),
          ),
          const SizedBox(height: 10),
          RequireLabelWidget(
            label: 'Phone',
            isNotFill: _isNotFill,
          ),
          UpdateTxtFieldWidget(
            value: _profileOBJ.mobile,
            textInputType: TextInputType.phone,
            icon: CupertinoIcons.phone,
            onChanged: (mobile) =>
                _profileOBJ = _profileOBJ.copyWith(mobile: mobile),
          ),
          const SizedBox(height: 10),
          const Text('Web Site'),
          UpdateTxtFieldWidget(
            value: _profileOBJ.webSite,
            textInputType: TextInputType.name,
            icon: Icons.web,
            onChanged: (webSite) =>
                _profileOBJ = _profileOBJ.copyWith(webSite: webSite),
          ),
          const SizedBox(height: 10),
          RequireLabelWidget(
            label: 'Description',
            isNotFill: _isNotFill,
          ),
          UpdateTxtFieldWidget(
            value: _profileOBJ.description,
            textInputType: TextInputType.text,
            onChanged: (description) =>
                _profileOBJ = _profileOBJ.copyWith(description: description),
            maxLine: 3,
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
