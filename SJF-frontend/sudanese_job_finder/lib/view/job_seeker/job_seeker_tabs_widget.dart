import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_attachment_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_contact_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_experience_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_professional_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_profile_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_qualifications_screen.dart';
import 'package:sudanese_job_finder/view/job_seeker/job_seeker_skills_screen.dart';
import 'package:sudanese_job_finder/widget/job_seeker_widget/tab_widget.dart';

class JobSeekerTabsWidget extends StatefulWidget {
  const JobSeekerTabsWidget({super.key});

  @override
  State<JobSeekerTabsWidget> createState() => _JobSeekerTabsState();
}

class _JobSeekerTabsState extends State<JobSeekerTabsWidget> {
  List<Tab> tabs = [
    const Tab(
        child: TabWidget(icon: Icons.person, name: 'Personal Information')),
    const Tab(child: TabWidget(icon: Icons.phone, name: 'Contact')),
    const Tab(
        child:
            TabWidget(icon: Icons.file_copy, name: 'Academic Qualifications')),
    const Tab(child: TabWidget(icon: Icons.build, name: 'Skills')),
    const Tab(
        child:
            TabWidget(icon: Icons.file_copy, name: 'Professional Certificate')),
    const Tab(
        child:
            TabWidget(icon: Icons.file_copy, name: 'Experience Certificate')),
    const Tab(
        child: TabWidget(icon: Icons.file_upload_outlined, name: 'Attachment')),
  ];
  List<Widget> tabsContent = [
    const JobSeekerProfileScreen(),
    const JobSeekerContactScreen(),
    const JobSeekerQualificationsScreen(),
    const JobSeekerSkillsScreen(),
    const JobSeekerProfessionalScreen(),
    const JobSeekerExperienceScreen(),
    const JobSeekerAttchment(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Profile'),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              indicatorColor: Theme.of(context).focusColor,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(children: tabsContent),
      ),
    );
  }
}
