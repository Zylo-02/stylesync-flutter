import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ColorDisplayWidget extends StatefulWidget {
  final String imagePath;

  ColorDisplayWidget({required this.imagePath});

  @override
  _ColorDisplayWidgetState createState() => _ColorDisplayWidgetState();
}

class _ColorDisplayWidgetState extends State<ColorDisplayWidget> {
  List<List<int>> dominantColors = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _makeApiRequest();
            },
            child: Text('Get Colors'),
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator() // Show loading indicator
              : Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dominantColors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColorCircle(dominantColors[index]),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _makeApiRequest() async {
    setState(() {
      isLoading = true;
    });

    // Replace the API endpoint URL with your actual API endpoint
    String apiUrl = dotenv.env['RAILWAY']!;
    // Read the image file as bytes
    List<int> imageBytes = File(widget.imagePath).readAsBytesSync();

    // Encode the image as base64
    String base64Image = base64Encode(imageBytes);

    // Prepare the JSON payload with the base64-encoded image
    Map<String, dynamic> payload = {'base64_image': base64Image};

    // Make a POST request to the Flask API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    setState(() {
      isLoading = false;
      dominantColors = response.body.isNotEmpty
          ? List<List<int>>.from(jsonDecode(response.body)['dominant_colors']
              .map((color) => List<int>.from(color)))
          : [];
    });
  }
}

class ColorCircle extends StatelessWidget {
  final List<int> color;

  ColorCircle(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(color[0], color[1], color[2], 1),
        shape: BoxShape.circle,
      ),
    );
  }
}
