import 'dart:convert';

class JsonUtil {
  static String encode(dynamic data) => json.encode(data);
  static dynamic decode(String source) => json.decode(source);
}
