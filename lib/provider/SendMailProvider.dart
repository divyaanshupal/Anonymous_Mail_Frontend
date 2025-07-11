import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> sendMail({
  required String to,
  required String message,
  required String nickname,
}) async {
  try {
    final url = Uri.parse("https://anonymousmailbackend-production.up.railway.app/send");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'to': to,
        'message': message,
        'nickname': nickname,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode == 200;
  } catch (e) {
    print('Error sending mail: $e');
    return false;
  }
}

//deploy