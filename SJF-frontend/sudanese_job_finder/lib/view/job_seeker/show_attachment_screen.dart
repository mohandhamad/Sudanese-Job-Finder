import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:sudanese_job_finder/constant/app_color.dart';
import 'package:sudanese_job_finder/widget/global/app_bar_widget.dart';

class ShowAttachmentScreen extends StatefulWidget {
  final String? base64String;
  const ShowAttachmentScreen(
      {super.key, this.base64String});

  @override
  State<ShowAttachmentScreen> createState() => _ShowAttachmentScreenState();
}

class _ShowAttachmentScreenState extends State<ShowAttachmentScreen> {
  late Future<File> fileFuture;

  @override
  void initState() {
    super.initState();
    fileFuture = createTemporaryFile();
  }

  Future<File> createTemporaryFile() async {
    final content = base64.decode(widget.base64String ?? "");
    final directory = await Directory.systemTemp.create();
    final file = File('${directory.path}/temp.pdf');
    await file.writeAsBytes(content);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(isHome: false),
      body: FutureBuilder<File>(
        future: fileFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filePath = snapshot.data!.path;
            return PDFView(filePath: filePath);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading PDF'));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColor.appPrimaryColor,
            ));
          }
        },
      ),
    );
  }
}
