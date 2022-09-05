
import 'package:dating_app/api/http_client/dio_client.dart';
import 'package:flutter/material.dart';

abstract class BaseNotifier extends ChangeNotifier {
  final DioClient dioClient = DioClient();
}
