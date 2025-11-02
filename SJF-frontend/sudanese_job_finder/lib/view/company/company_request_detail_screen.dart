import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_application_seeker_detail_response.dart';
import 'package:sudanese_job_finder/view/company/attachments_screen.dart';
import 'package:sudanese_job_finder/view/company/exp_certificate_screen.dart';
import 'package:sudanese_job_finder/view/company/pro_certificate_screen.dart';
import 'package:sudanese_job_finder/view/company/aca_qualification_screen.dart';
import 'package:sudanese_job_finder/util/regex_pattren.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/non_scrollable_list_view_widget.dart';
import 'package:sudanese_job_finder/widget/global/row_txt_widget.dart';

class CompanyRequestDetailScreen extends StatelessWidget {
  final JobApplicationSeekerDetailResponse data;
  const CompanyRequestDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(isHome: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 175,
                  width: double.infinity,
                  color: AppColor.appPrimaryColor,
                ),
                Positioned(
                  bottom: -30,
                  left: 20,
                  child: Row(
                    children: [
                      buildLogo(),
                      const SizedBox(width: 15),
                      Text(
                        "${capitalizeWords(data.jobSeekerProfile?.firstName ?? '')} ${data.jobSeekerProfile?.middleName?[0].toUpperCase() ?? ''}.${data.jobSeekerProfile?.lastName?[0].toUpperCase() ?? ''}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 133),
                Text(data.jobSeekerProfile?.nationalId ?? '')
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcaQualificationScreen(
                          data: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.wysiwyg,
                      color: AppColor.appPrimaryColor,
                      size: 35,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProCertificateScreen(
                          data: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.add_chart_sharp,
                      color: AppColor.appPrimaryColor,
                      size: 35,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpCertificateScreen(
                          data: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.work,
                      color: AppColor.appPrimaryColor,
                      size: 35,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttachmentScreen(
                          data: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.file_open,
                      color: AppColor.appPrimaryColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: AppColor.shadow,
              ),
              child: Column(
                children: [
                  RowTxtWidget(
                    title: 'First Name:',
                    content: data.jobSeekerProfile?.firstName ?? '',
                  ),
                  RowTxtWidget(
                    title: 'Middle Name:',
                    content: data.jobSeekerProfile?.middleName ?? '',
                  ),
                  RowTxtWidget(
                    title: 'Last Name:',
                    content: data.jobSeekerProfile?.lastName ?? '',
                  ),
                  RowTxtWidget(
                    title: 'Birth Date:',
                    content: data.jobSeekerProfile?.birthDate.toString() ?? '',
                  ),
                  RowTxtWidget(
                    title: 'Gender:',
                    content: data.jobSeekerProfile?.gender == 'M'
                        ? 'Male'
                        : 'Female',
                  ),
                  RowTxtWidget(
                    title: 'Marital Status:',
                    content: data.jobSeekerProfile?.maritalStatus ?? '',
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: AppColor.shadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      'Contact',
                      style: TextStyle(
                        color: AppColor.appPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NonScrollableListViewWidget(
                    itemCount: data.jobSeekerContact!.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          RowTxtWidget(
                            title: 'Type',
                            content: data.jobSeekerContact?[index].type ?? '',
                          ),
                          RowTxtWidget(
                            title: 'Content',
                            content:
                                data.jobSeekerContact?[index].contactNumber ??
                                    '',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: AppColor.appSecondaryColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: data.jobSeekerProfile?.image != null &&
                  data.jobSeekerProfile?.image != ''
              ? CachedNetworkImage(
                  imageUrl: data.jobSeekerProfile!.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 90,
                    width: 90,
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
                  size: 60,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}
