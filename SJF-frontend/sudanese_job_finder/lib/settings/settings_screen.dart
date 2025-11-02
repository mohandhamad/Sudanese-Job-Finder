import 'package:flutter/material.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';
import 'package:sudanese_job_finder/widget/global/display_mode_btn_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Setting', isHome: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.settings_display_rounded),
              title: Text('Display Mode'),
              trailing: DisplayModeBtnWidget(),
            ),
            ListTile(
              leading: const Icon(Icons.feed),
              title: const Text('About As'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.feed),
              title: const Text('terms and provinces'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Account'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text('Change Password'),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}