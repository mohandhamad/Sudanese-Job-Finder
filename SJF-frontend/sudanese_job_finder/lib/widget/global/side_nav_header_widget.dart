import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class SideNavHeaderWidget extends StatelessWidget {
  final String email;
  final String username;
  final String? image;
  const SideNavHeaderWidget({
    super.key,
    required this.email,
    required this.username,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3,0,0,0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          image != null && image != ''
              ? buildImage()
              : Icon(
                  CupertinoIcons.person_alt_circle,
                  size: height * 0.05,
                  color: Colors.white,
                ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: image != null && image != ''
              ? CachedNetworkImage(
                  imageUrl: image!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 43,
                    width: 43,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                        color: AppColor.appPrimaryColor,
                      ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 70),
                )
              : const Icon(
                  CupertinoIcons.person_alt_circle,
                  size: 70,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
