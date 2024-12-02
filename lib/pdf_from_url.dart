import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewerPDF extends StatelessWidget {
  const ViewerPDF({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached PDF From Url'),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
