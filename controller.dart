import 'package:http/http.dart' as http;
import 'form.dart';

class FormController {
  static const String URL =
      "https://script.google.com/macros/s/AKfycbw6a0HeA6NNZlpJle35xImFkGAScTHWM9iHzoC2Lfs397ImCg162BR7KNIWJZxK-sf5/exec";
  static const status_success = "SUCCESS";

  void submitForm(SuForm suForm, void Function(String) callback) async {
    try {
      var response = await http.post(Uri.parse(URL), body: suForm.toJson());
      if (response.statusCode == 200) {
        callback(response.body);
      } else {
        print('Error submitting form. Status code: ${response.statusCode}');
        callback('Error');
      }

      callback(response.body);
    } catch (e) {
      print('Error submitting form: $e');
      callback('Error');
    }
  }
}
