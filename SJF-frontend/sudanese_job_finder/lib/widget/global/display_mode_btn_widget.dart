import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudanese_job_finder/Provider/theme_provider.dart';

class DisplayModeBtnWidget extends StatelessWidget {
  const DisplayModeBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (val) {
          final provider =
              Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(val);
        });
  }
}