abstract class PolicyService {
  /// 获取条款内容的 HTML 字符串
  /// [policyType] 可以是 'privacy' 或 'terms'
  Future<String> getPolicyHtml(String policyType);
}
