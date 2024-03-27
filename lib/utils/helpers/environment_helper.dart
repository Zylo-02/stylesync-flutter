import 'package:flutter_dotenv/flutter_dotenv.dart';

class TEnvironmentHelperFunctions {
  Future<String?> getFlaskApiUrl() async {
    return dotenv.env['FLASK_API_URL'];
  }
}
