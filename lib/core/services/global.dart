import 'dart:convert';
import 'package:dashboard_manga_easy/core/interfaces/service.dart';

enum StatusBuild { done, loading, erro }

class Global extends IService {
  String? user;
  static Map header = json.decode(
    '{"User-Agent":"Mozilla/5.0 (Linux; Android 11; sdk_gphone_x86_arm Build/RSR1.201013.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36","Sec-CH-UA-Arch":"x86","Sec-CH-UA-Model":"sdk_gphone_x86_arm","Sec-CH-UA-Platform":"Android","Sec-CH-UA-Platform-Version":"11","Sec-CH-UA":"Google Chrome; v=0.5.2","Sec-CH-UA-Full-Version":"0.5.2","Sec-CH-UA-Mobile":"?1"}',
  );
  @override
  Future<void> initialise() async {}
}
