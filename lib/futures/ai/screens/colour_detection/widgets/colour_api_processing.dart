import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:stylesync/futures/ai/controllers/api.controllers/api_controller.dart';
import 'package:stylesync/futures/ai/controllers/inference.controllers/inference_controller.dart';

class TColourAPI extends StatelessWidget {
  const TColourAPI({
    super.key,
    required InferenceController controller,
    required this.imageData,
    required this.apiController,
  }) : _controller = controller;

  final InferenceController _controller;
  final String imageData;
  final ApiController apiController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _controller.setImagePath(imageData);
      debugPrint(imageData);
      if (apiController.responseData.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Text(apiController.responseData);
      }
    });
  }
}
