import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarWidget extends StatelessWidget {
  final File? file;
  final String? imagePath;
  final VoidCallback onClicked;

  const AvatarWidget({
    super.key,
    this.imagePath,
    required this.onClicked,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = file != null
        ? Image.file(
            file!,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          )
        : imagePath != null && imagePath != ''
            ? CachedNetworkImage(
                imageUrl: imagePath!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 70),
              )
            : const Icon(
                CupertinoIcons.person_alt_circle,
                size: 70,
                color: Colors.grey,
              );

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClicked,
            child: image,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
        all: 2,
        child: buildCircle(
          all: 4,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 14,
          ),
          color: AppColor.appPrimaryColor,
        ),
        color: Colors.white,
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          color: color,
          padding: EdgeInsets.all(all),
          child: child,
        ),
      );
}
