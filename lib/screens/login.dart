import 'package:emombti/models/user.dart';
import 'package:flutter/material.dart';

import '../ui/core/localization/app_localizations.dart';
import '../ui/core/ui/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginForm(
      onPressedStartWithPhone: () => {},
      onPressedStartWithEmail: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const EmailLoginForm())),
      onPressedStartWithGuest: () =>
          Navigator.pushReplacementNamed(context, '/layout'),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.onPressedStartWithPhone,
    required this.onPressedStartWithEmail,
    required this.onPressedStartWithGuest,
  });

  final Function() onPressedStartWithPhone;
  final Function() onPressedStartWithEmail;
  final Function() onPressedStartWithGuest;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RotatingCircle(),
                  const SizedBox(height: 60),
                  FilledButton.icon(
                    onPressed: onPressedStartWithPhone,
                    icon: const Icon(Icons.phone_iphone),
                    label: Text(l10n.startWithPhone),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      elevation: 3,
                      shape: const StadiumBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: onPressedStartWithEmail,
                    icon: const Icon(Icons.email_outlined),
                    label: Text(l10n.startWithEmail),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: const StadiumBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorScheme.outlineVariant,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.or,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorScheme.outlineVariant,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: onPressedStartWithGuest,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Text(l10n.startAsGuest),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RotatingCircle extends StatefulWidget {
  const RotatingCircle({super.key});

  @override
  State<RotatingCircle> createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'assets/images/Cognitive_Functions.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({super.key});

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final UserViewModel viewModel = UserViewModel(UserModel());

  int _currentStep = 1;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void _nextStep() async {
    try {
      EmailLoginStep step;
      switch (_currentStep) {
        case 1:
          step = EmailLoginStep.sendVerification;
        case 2:
          step = EmailLoginStep.verifyCode;
        default:
          throw Exception('Invalid step');
      }
      await viewModel.emailLogin(
        step,
        email: _emailController.text,
        code: _codeController.text,
      );
      if (viewModel.errorMessage == null) {
        setState(() => _currentStep++);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _currentStep > 1
                  ? () => setState(() => _currentStep--)
                  : () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildStepContent(),
                  ),
                ),
                if (viewModel.isLoading) FormLoadingCoverWidget(),
                if (viewModel.errorMessage != null)
                  FormErrorMessageNotificationWidget(
                    errorMessage: viewModel.errorMessage!,
                    onPressed: () => viewModel.clearError(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressedSendVerification(String email) {}

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildEmailStep();
      case 2:
        return _buildVerificationStep();
      case 3:
        return _buildSuccessStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // --- Step 1: Email Input ---
  Widget _buildEmailStep() {
    return Column(
      key: const ValueKey(1),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Enter your email",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
          ),
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextStep,
            child: const Text("Send Verification"),
          ),
        ),
      ],
    );
  }

  // --- Step 2: 4-Digit Code ---
  Widget _buildVerificationStep() {
    return Column(
      key: const ValueKey(2),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.mark_email_read_outlined,
          size: 64,
          color: Colors.green,
        ),
        const SizedBox(height: 20),
        const Text(
          "Code Sent!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text("Please enter the 4-digit code sent to your email."),
        const SizedBox(height: 20),
        TextField(
          controller: _codeController,
          textAlign: TextAlign.center,
          maxLength: 4,
          style: const TextStyle(fontSize: 24, letterSpacing: 10),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _nextStep,
            child: const Text("Verify"),
          ),
        ),
      ],
    );
  }

  // --- Step 3: Thank You ---
  Widget _buildSuccessStep() {
    return Column(
      key: const ValueKey(3),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle_outline, size: 80, color: Colors.indigo),
        const SizedBox(height: 20),
        const Text(
          "Thank You!",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Text("Your email has been verified successfully."),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to your layout route
              Navigator.pushReplacementNamed(context, '/layout');
            },
            child: const Text("Continue"),
          ),
        ),
      ],
    );
  }
}
