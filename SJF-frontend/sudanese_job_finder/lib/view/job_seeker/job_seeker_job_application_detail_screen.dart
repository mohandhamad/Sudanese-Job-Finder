import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/model/job_seeker_job_application_detail_response.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';

class JobSeekerJobApplicationDetailScreen extends StatefulWidget {
  final JobSeekerJobApplicationDetailResponse data;
  const JobSeekerJobApplicationDetailScreen({super.key, required this.data});

  @override
  State<JobSeekerJobApplicationDetailScreen> createState() =>
      _JobSeekerJobApplicationDetailScreenState();
}

class _JobSeekerJobApplicationDetailScreenState
    extends State<JobSeekerJobApplicationDetailScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(isHome: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildCompanyInfoCard(),
                  const SizedBox(height: 16),
                  _buildJobDetailsCard(),
                  const SizedBox(height: 16),
                  _buildJobMetaChips(),
                  const SizedBox(height: 16),
                  _buildSkillsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildImageSlider(),
        Positioned(
          bottom: -30,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCompanyLogo(),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                child: Text(
                  widget.data.companyProfile?.companyName ?? 'Company Name',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return widget.data.companyImages!.isEmpty
        ? Container(
            height: 200,
            color: AppColor.appPrimaryColor,
            child: const Center(
              child: Icon(
                Icons.photo_library,
                size: 50,
                color: AppColor.appPrimaryColor,
              ),
            ),
          )
        : CarouselSlider.builder(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemCount: widget.data.companyImages?.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = widget.data.companyImages?[index].image ?? '';
              return CachedNetworkImage(
                imageUrl: urlImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: AppColor.appPrimaryColor),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColor.appPrimaryColor,
                  child: const Icon(
                    Icons.error_outline,
                    color: AppColor.appPrimaryColor,
                    size: 40,
                  ),
                ),
              );
            },
          );
  }

  Widget _buildCompanyLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColor.appPrimaryColor,
        shape: BoxShape.circle,
        boxShadow: AppColor.shadow,
      ),
      child: ClipOval(
        child: widget.data.companyProfile?.image?.isNotEmpty ?? false
            ? CachedNetworkImage(
                imageUrl: widget.data.companyProfile!.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: AppColor.appPrimaryColor),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.business,
                  color: AppColor.appPrimaryColor,
                  size: 40,
                ),
              )
            : const Icon(
                Icons.business,
                color: AppColor.appPrimaryColor,
                size: 40,
              ),
      ),
    );
  }

  Widget _buildCompanyInfoCard() {
    return _buildInfoCard(
      icon: Icons.business,
      title: 'Company Overview',
      content: widget.data.companyProfile?.description ?? 'No description provided',
      children: [
        _InfoRow(
          icon: CupertinoIcons.phone,
          title: 'Contact',
          value: widget.data.companyProfile?.mobile ?? 'Not available',
        ),
        _InfoRow(
          icon: CupertinoIcons.globe,
          title: 'Website',
          value: widget.data.companyProfile?.webSite ?? 'Not available',
        ),
      ],
    );
  }

  Widget _buildJobDetailsCard() {
    return _buildInfoCard(
      icon: Icons.work_outline,
      title: widget.data.companyJob?.jobTitle ?? 'Position',
      content: widget.data.companyJob?.jobDescription ?? 'No job description provided',
      children: [
        _InfoRow(
          icon: CupertinoIcons.money_dollar,
          title: 'Salary',
          value: widget.data.companyJob?.salary ?? 'Not specified',
        ),
      ],
    );
  }

  Widget _buildJobMetaChips() {
    return _buildInfoCard(
      icon: Icons.info_outline,
      title: 'Job Details',
      content: '',
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _InfoChip(
              icon: Icons.schedule,
              label: widget.data.companyJob?.jobType ?? 'Full-time',
              color: AppColor.appPrimaryColor,
            ),
            _InfoChip(
              icon: Icons.engineering,
              label: widget.data.companyJob?.jobField ?? 'General',
              color: AppColor.appSecondaryColor,
            ),
            _InfoChip(
              icon: Icons.star,
              label: widget.data.companyJob?.expLevel ?? 'Entry Level',
              color: AppColor.appPrimaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsCard() {
    return _buildInfoCard(
      icon: Icons.code,
      title: 'Required Skills',
      content: widget.data.companyJob?.skills ?? 'No specific skills required',
      children: const [],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final cardColor = theme.brightness == Brightness.light
        ? Colors.white
        : Colors.grey[900];
    final textColor = theme.brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Card(
      color: cardColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColor.appPrimaryColor),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                color: textColor,
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColor.appPrimaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(0.2),
      avatar: Icon(icon, color: color),
      label: Text(
        label,
        style: const TextStyle(color: AppColor.appPrimaryColor),
      ),
    );
  }
}
