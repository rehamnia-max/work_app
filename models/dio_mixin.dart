import 'package:dio/dio.dart';

mixin ApiDioMixin {
  static final BaseOptions _options = BaseOptions(
    baseUrl: "http://192.168.210.246:8000/", //192.168.1.104
    validateStatus: (status) => true,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
  );
  static BaseOptions get options => _options;

  static Dio dio = Dio(_options);
}
