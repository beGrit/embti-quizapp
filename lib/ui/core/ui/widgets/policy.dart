// lib/ui/core/ui/widgets/policy.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/services/policy_service.dart';

class PolicyWebView extends StatefulWidget {
  final String policyType;
  final VoidCallback? onLoaded;

  const PolicyWebView({super.key, required this.policyType, this.onLoaded});

  @override
  State<PolicyWebView> createState() => _PolicyWebViewState();
}

class _PolicyWebViewState extends State<PolicyWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (mounted) {
              setState(() => _isLoading = false);
              widget.onLoaded?.call();
            }
          },
        ),
      );

    // 在初始化后触发加载
    _loadPolicyContent();
  }

  Future<void> _loadPolicyContent() async {
    // 1. 从 Provider 获取 Service
    final policyService = context.read<PolicyService>();

    // 2. 获取 HTML 源码
    final rawHtml = await policyService.getPolicyHtml(widget.policyType);

    // 3. 构造完整的 HTML 文档（注入适配移动端的 CSS）
    final String styledHtml =
        '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            :root { color-scheme: light dark; }
            body { 
              font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
              padding: 16px;
              line-height: 1.6;
              font-size: 15px;
              word-wrap: break-word;
            }
            h1, h2, h3 { color: #000; margin-top: 24px; }
            p { margin-bottom: 12px; }
            /* 适配深色模式（可选） */
            @media (prefers-color-scheme: dark) {
              body { color: #E0E0E0; }
              h1, h2, h3 { color: #FFFFFF; }
            }
          </style>
        </head>
        <body>$rawHtml</body>
      </html>
    ''';

    await _controller.loadHtmlString(styledHtml);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(child: CircularProgressIndicator.adaptive()),
      ],
    );
  }
}
