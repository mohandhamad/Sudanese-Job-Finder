import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/account_data_provider.dart';
import 'package:sudanese_job_finder/Provider/company_profile_provider.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/model/company_images_request.dart';
import 'package:sudanese_job_finder/model/company_images_response.dart';
import 'package:sudanese_job_finder/services/company_services.dart';
import 'package:sudanese_job_finder/util/errors.dart';
import 'package:sudanese_job_finder/util/toast.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/gallery_card_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/row_camera_gallery_widget.dart';
import 'package:sudanese_job_finder/widget/global/txt_btn_widget.dart';
import 'package:sudanese_job_finder/widget/global/update_txt_field_widget.dart';

class CompanyGalleryScreen extends StatefulWidget {
  const CompanyGalleryScreen({super.key});

  @override
  State<CompanyGalleryScreen> createState() => _CompanyGalleryScreenState();
}

class _CompanyGalleryScreenState extends State<CompanyGalleryScreen> {
  CompanyImagesRequest _imageOBJ = CompanyImagesRequest();
  bool _isLading = false;
  final _api = CompanyServices();
  File? _file;

  Future<List<CompanyImagesResponse>> fetchData() async {
    final id = Provider.of<CompanyProfileProvider>(context, listen: false)
        .companyProfileList[0]
        .id;
    final response = await _api.getImages(id!);
    return response;
  }

  void postData() {
    final accountData = Provider.of<AccountDataProvider>(context, listen: false)
        .accountDataList[0];
    final profileData =
        Provider.of<CompanyProfileProvider>(context, listen: false)
            .companyProfileList[0];
    if (_file == null ||
        _imageOBJ.title == null ||
        _imageOBJ.description == null) {
      errorToast('Plz, Fill all fields');
      return;
    }
    if (_imageOBJ.title!.length > 25) {
      errorToast('The title must be less then 25 characters.');
      return;
    }
    if (_imageOBJ.description!.length > 50) {
      errorToast('The description must be less then 50 characters.');
      return;
    }
    Navigator.of(context).pop();
    setState(() => _isLading = true);
    _imageOBJ.companyProfile = profileData.id;
    _imageOBJ.createdBy = accountData.id;
    _imageOBJ.image = _file!.path;
    _api.postImage(_imageOBJ).then((response) {
      if (response) {
        successToast('Add successfuilly');
        setState(() => _isLading = false);
        // fetchData();
      } else {
        setState(() => _isLading = false);
        unhandledExceptionMessage(context);
      }
    });
  }

  void deleteData(int id) {
    setState(() => _isLading = true);
    _api.deleteImage(id).then((response) {
      if (response) {
        // fetchData();
        successToast('Deleted successfuilly');
      } else {
        unhandledExceptionMessage(context);
      }
      setState(() => _isLading = false);
    });
  }

  Future _pickImage(ImageSource source, StateSetter showDialogState) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) return;
    showDialogState(() => _file = File(returnedImage.path));
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(isHome: false, title: 'Gallery'),
      body: FutureBuilder(
        future: fetchData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CompanyImagesResponse>> snapshot,
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
            if (_isLading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.appPrimaryColor,
                ),
              );
            }
            return _galleryBody(context, data);
          }
        },
      ),
    );
  }

  SingleChildScrollView _galleryBody(
      BuildContext context, List<CompanyImagesResponse> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
            child: SizedBox(
              width: 150,
              child: BtnWidget(
                btnName: "New Image",
                voidCallback: () => _openDialog(context),
              ),
            ),
          ),
          NonScrollableListViewWidget(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GalleryCardWidget(
                title: data[index].title ?? '',
                description: data[index].description ?? '',
                voidCallback: () => deleteData(data[index].id!),
                child: CachedNetworkImage(
                  imageUrl: data[index].image!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColor.appPrimaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 70),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _openDialog(BuildContext context) {
    _file = null;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              title: const Text(
                'New Image',
                style: TextStyle(
                  color: AppColor.appPrimaryColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
              content: _dialogContent(setState),
              actions: [
                TxtBtnWidget(
                  voidCallback: () => Navigator.of(context).pop(),
                  btnName: 'Cencel',
                ),
                TxtBtnWidget(voidCallback: () => postData(), btnName: 'Add'),
              ],
            );
          },
        );
      },
    );
  }

  SingleChildScrollView _dialogContent(StateSetter setState) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_file != null)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _file!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            RowCameraGalleryWidget(
              voidCallbackCamera: () => _pickImage(
                ImageSource.camera,
                setState,
              ),
              voidCallbackGallery: () => _pickImage(
                ImageSource.gallery,
                setState,
              ),
            ),
          const SizedBox(height: 5),
          const Text('Title'),
          UpdateTxtFieldWidget(
            textInputType: TextInputType.text,
            onChanged: (title) => _imageOBJ = _imageOBJ.copyWith(title: title),
          ),
          const SizedBox(height: 5),
          const Text('Description'),
          UpdateTxtFieldWidget(
            textInputType: TextInputType.text,
            onChanged: (description) =>
                _imageOBJ = _imageOBJ.copyWith(description: description),
          ),
        ],
      ),
    );
  }
}
