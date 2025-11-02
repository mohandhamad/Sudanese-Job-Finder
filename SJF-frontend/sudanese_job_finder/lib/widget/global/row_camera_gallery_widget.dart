import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowCameraGalleryWidget extends StatelessWidget {
  final VoidCallback voidCallbackGallery;
  final VoidCallback voidCallbackCamera;
  const RowCameraGalleryWidget(
      {super.key,
      required this.voidCallbackGallery,
      required this.voidCallbackCamera});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: voidCallbackGallery,
              icon: const Icon(
                CupertinoIcons.photo_fill,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const Text('Gallery')
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: voidCallbackCamera,
              icon: const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const Text('Camera')
          ],
        ),
      ],
    );
  }
}
