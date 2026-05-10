import 'dart:ui';

import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_models/login_viewmodel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    widget.viewModel.loginWithAccountAndPassword.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginWithAccountAndPassword.removeListener(_onResult);
    widget.viewModel.loginWithAccountAndPassword.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginWithAccountAndPassword.removeListener(_onResult);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.viewModel.loginWithAccountAndPassword.execute((
        _emailController.value.text,
        _passwordController.value.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final l10n = AppLocalizations.of(context)!; // 如果需要多语言请取消注释

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 毛玻璃效果
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Login",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // Email 输入框
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              filled: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? 'Enter email'
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Password 输入框
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              filled: true,
                            ),
                            obscureText: true,
                            validator: (value) =>
                                (value == null || value.length < 6)
                                ? 'Password too short'
                                : null,
                          ),
                          const SizedBox(height: 24),

                          // 登录按钮
                          FilledButton.icon(
                            onPressed: _handleLogin,
                            icon: const Icon(Icons.login),
                            label: const Text('Login'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.loginWithAccountAndPassword.completed) {
      widget.viewModel.loginWithAccountAndPassword.clearResult();
      context.go(Routes.home);
    }

    if (widget.viewModel.loginWithAccountAndPassword.error) {
      widget.viewModel.loginWithAccountAndPassword.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed.'),
          action: SnackBarAction(
            label: 'Try Again',
            onPressed: () =>
                widget.viewModel.loginWithAccountAndPassword.execute((
                  _emailController.value.text,
                  _passwordController.value.text,
                )),
          ),
        ),
      );
    }
  }
}
