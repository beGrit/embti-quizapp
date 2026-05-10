import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_background.dart';
import 'package:emombti/ui/login/widgets/login_logo.dart';
import 'package:emombti/ui/login/widgets/login_methods.dart';
import 'package:emombti/ui/login/widgets/login_policy.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: LoginScreenLayout(viewModel: viewModel),
    );
  }
}

class LoginScreenLayout extends StatelessWidget {
  const LoginScreenLayout({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    const double borderThickness = 8.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.yellow,
            Colors.red,
            Colors.purple,
            Colors.white,
            Colors.black,
          ],
        ),
      ),
      padding: const EdgeInsets.all(borderThickness),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white, // This is your fallback background
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(child: GravityCanvasBackground()),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedLoginLogo(),
                    LoginMethods(viewModel: viewModel),
                    LoginPolicy(),
                  ],
                ),
              ),
            ],
          ),
          // child: Center(child: GravityCanvasBackground()),
        ),
      ),
    );
  }
}
