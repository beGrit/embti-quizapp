import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_basic_form.dart';
import 'package:flutter/material.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: viewModel.loginWithWechat,
            builder: (context, child) => _buildLoginButton(
              icon: Icons.wechat,
              label: "Login use Wechat",
              backgroundColor: const Color(0xFF07C160),
              textColor: colorScheme.onSurface,
              onPressed: viewModel.loginWithWechat.execute,
            ),
          ),

          const SizedBox(height: 16),
          _buildLoginButton(
            icon: Icons.password,
            label: "Login use Password",
            backgroundColor: Colors.white,
            textColor: Colors.black87,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    body: LoginForm(viewModel: viewModel),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor, size: 24),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: backgroundColor == Colors.white
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
