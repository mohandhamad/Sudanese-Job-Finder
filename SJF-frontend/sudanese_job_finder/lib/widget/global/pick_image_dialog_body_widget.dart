import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/row_camera_gallery_widget.dart';

class PickImageDialogBodyWidget extends StatelessWidget {
  final VoidCallback voidCallbackCamera;
  final VoidCallback voidCallbackGallery;
  const PickImageDialogBodyWidget({
    super.key,
    required this.voidCallbackCamera,
    required this.voidCallbackGallery,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Pick Image',
        style: TextStyle(
          color: AppColor.appPrimaryColor,
          fontWeight: FontWeight.w200,
        ),
      ),
      content: RowCameraGalleryWidget(
        voidCallbackCamera: voidCallbackCamera,
        voidCallbackGallery: voidCallbackGallery,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(
              color: AppColor.appPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
