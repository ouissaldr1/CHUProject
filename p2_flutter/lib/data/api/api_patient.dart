import 'package:get/get.dart';

class ApiPatient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  ApiPatient({ required this.appBaseUrl}){
    baseUrl=appBaseUrl;
    timeout=Duration(seconds: 30);
  }
}