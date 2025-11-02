// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';

class JobSeekerJPCardWidget extends StatelessWidget {
  final String companyName;
  final String endDate;
  final String? logo;
  final String jobRole;
  final String jobDes;
  final String salary;
  final VoidCallback voidCallback;

  const JobSeekerJPCardWidget({
    super.key,
    required this.companyName,
    required this.endDate,
    this.logo,
    required this.jobRole,
    required this.jobDes,
    required this.salary,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColor.shadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyLogo(context),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.appPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jobRole,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.appSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '⏳ Closes: $endDate',
                style: const TextStyle(
                  color: Color.fromARGB(255, 248, 121, 57),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              jobDes,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  context,
                  icon: Icons.work_outline,
                  text: 'Full-time',
                  color: AppColor.appPrimaryColor,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: voidCallback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.appPrimaryColor,
                    foregroundColor: colors.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        shape: BoxShape.circle,
        boxShadow: AppColor.shadow,
      ),
      child: ClipOval(
        child: logo != null && logo!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: logo!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColor.appPrimaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: colors.surfaceContainerHighest,
                  child: Icon(
                    Icons.business,
                    color: colors.onSurfaceVariant,
                    size: 28,
                  ),
                ),
              )
            : Icon(
                Icons.business,
                color: colors.onSurfaceVariant,
                size: 28,
              ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}