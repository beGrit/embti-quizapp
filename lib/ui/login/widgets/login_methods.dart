import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_basic_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginMethods extends StatefulWidget {
  const LoginMethods({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginMethods> createState() => _LoginMethodsState();
}

class _LoginMethodsState extends State<LoginMethods> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loginWithGoogle.addListener(_onGoogleLoginResult);
  }

  @override
  void didUpdateWidget(covariant LoginMethods oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginWithGoogle.removeListener(_onGoogleLoginResult);
    widget.viewModel.loginWithGoogle.addListener(_onGoogleLoginResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginWithGoogle.removeListener(_onGoogleLoginResult);
    super.dispose();
  }

  void _onGoogleLoginResult() {
    if (widget.viewModel.loginWithGoogle.error) {
      widget.viewModel.loginWithGoogle.clearResult();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Google Login Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: widget.viewModel.loginWithGoogle,
            builder: (context, child) => _buildLoginButton(
              icon: SvgPicture.asset('assets/images/google.svg'),
              label: "Sign in with Google",
              backgroundColor: theme.colorScheme.primaryContainer,
              textColor: theme.colorScheme.onPrimaryContainer,
              onPressed: widget.viewModel.loginWithGoogle.execute,
              isLoading: widget.viewModel.loginWithGoogle.running,
            ),
          ),

          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: widget.viewModel.loginWithAccountAndPassword,
            builder: (context, child) {
              return _buildLoginButton(
                icon: const Icon(Icons.email, size: 32),
                label: "Sign in with Email",
                backgroundColor: theme.colorScheme.surfaceContainer,
                textColor: theme.colorScheme.onSurface,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        extendBodyBehindAppBar: true,
                        backgroundColor: theme.colorScheme.surface,
                        appBar: AppBar(
                          // backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        body: LoginForm(viewModel: widget.viewModel),
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required Widget icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? CircularProgressIndicator(strokeWidth: 2, color: textColor)
            : icon,
        label: Text(
          isLoading ? "Logging in..." : label,
          style: TextStyle(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
