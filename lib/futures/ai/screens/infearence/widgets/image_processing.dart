import 'package:flutter/material.dart';

class ImageProcessingWidget extends StatelessWidget {
  final Future<String> Function() processImageFuture;
  final void Function(String data) onDataReceived;

  const ImageProcessingWidget({
    required this.processImageFuture,
    Key? key,
    required this.onDataReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: processImageFuture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          onDataReceived(snapshot.data!);
          return const SizedBox();
        }
      },
    );
  }
}
