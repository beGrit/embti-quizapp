// lib/data/services/local/local_policy_service.dart

import 'package:flutter/services.dart' show rootBundle;

import 'policy_service.dart';

class LocalPolicyService implements PolicyService {
  @override
  Future<String> getPolicyHtml(String policyType) async {
    try {
      // 假设你的文件放在 assets/policies/privacy.html
      final String path = 'assets/policies/$policyType.html';
      return await Future.delayed(const Duration(seconds: 3), () async {
        return await rootBundle.loadString(path);
      });
    } catch (e) {
      // 容错处理：如果文件找不到，返回一个基础的错误 HTML
      return "<html><body><h1>Error</h1><p>Policy not found.</p></body></html>";
    }
  }
}
