import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/ui/core/ui/widgets/policy.dart';
import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_basic_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginMethods extends StatefulWidget {
  const LoginMethods({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginMethods> createState() => _LoginMethodsState();
}

class _LoginMethodsState extends State<LoginMethods> {
  bool isPolicyAgreed = false;

  bool showTipsForPolicyAgree = false;

  late final GlobalKey<TooltipState> tooltipKey;

  @override
  void initState() {
    super.initState();
    widget.viewModel.loginWithGoogle.addListener(_onGoogleLoginResult);
    widget.viewModel.loginWithAppleId.addListener(_onAppleIdLoginResult);
    tooltipKey = GlobalKey<TooltipState>();
  }

  @override
  void dispose() {
    widget.viewModel.loginWithGoogle.removeListener(_onGoogleLoginResult);
    widget.viewModel.loginWithAppleId.removeListener(_onAppleIdLoginResult);
    super.dispose();
  }

  void _ensureTooltipVisible() {
    final TooltipState? tooltipState = tooltipKey.currentState;
    tooltipState?.ensureTooltipVisible();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Tooltip.dismissAllToolTips();
      }
    });
  }

  void _onGoogleLoginResult() {
    if (widget.viewModel.loginWithGoogle.error) {
      widget.viewModel.loginWithGoogle.clearResult();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Google Sign In Failed')));
      }
    }
  }

  void _onAppleIdLoginResult() {
    if (widget.viewModel.loginWithAppleId.error) {
      widget.viewModel.loginWithAppleId.clearResult();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Apple Sign In Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListenableBuilder(
                listenable: widget.viewModel.loginWithGoogle,
                builder: (context, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FilledButton.icon(
                            onPressed: widget.viewModel.isSigning
                                ? null
                                : () {
                                    if (!isPolicyAgreed) {
                                      setState(() {
                                        showTipsForPolicyAgree = true;
                                      });
                                      _ensureTooltipVisible();
                                      return;
                                    }
                                    widget.viewModel.loginWithGoogle.execute();
                                  },
                            iconAlignment: IconAlignment.start,
                            icon: const Icon(Icons.login, size: 32),
                            label: const Text('Google Sign In'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              if (theme.platform == TargetPlatform.iOS)
                ListenableBuilder(
                  listenable: widget.viewModel.loginWithAppleId,
                  builder: (context, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: widget.viewModel.isSigning
                                ? null
                                : FilledButton.icon(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Color(0xFF1A1A1A),
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          Colors.grey.shade300,
                                      disabledForegroundColor:
                                          Colors.grey.shade600,
                                    ),
                                    onPressed: () {
                                      if (!isPolicyAgreed) {
                                        setState(() {
                                          showTipsForPolicyAgree = true;
                                        });
                                        _ensureTooltipVisible();
                                        return;
                                      }
                                      widget.viewModel.loginWithAppleId
                                          .execute();
                                    },
                                    icon: const Icon(Icons.apple, size: 32),
                                    label: const Text('Apple Sign In'),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              SizedBox(height: 16),
              ListenableBuilder(
                listenable: widget.viewModel.loginWithAccountAndPassword,
                builder: (context, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: widget.viewModel.isSigning
                              ? null
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    if (!isPolicyAgreed) {
                                      setState(() {
                                        showTipsForPolicyAgree = true;
                                      });
                                      _ensureTooltipVisible();
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          extendBodyBehindAppBar: true,
                                          backgroundColor:
                                              theme.colorScheme.surface,
                                          appBar: AppBar(
                                            // backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          body: LoginForm(
                                            viewModel: widget.viewModel,
                                          ),
                                        ),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.email, size: 32),
                                  label: const Text('Email Sign In'),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              _buildLoginPolicy(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginPolicy(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              key: tooltipKey,
              message: 'Please accept the terms to continue',
              triggerMode: TooltipTriggerMode.manual,
              child: Checkbox(
                side: BorderSide(
                  color: showTipsForPolicyAgree
                      ? theme.colorScheme.error
                      : theme.colorScheme.outline,
                  width: 2.0,
                ),
                checkColor: theme.colorScheme.onPrimary,
                fillColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return theme.colorScheme.primary;
                  }
                  return Colors.transparent;
                }),
                visualDensity: VisualDensity.compact,
                value: isPolicyAgreed,
                onChanged: (value) => setState(() {
                  showTipsForPolicyAgree = value ?? false;
                  isPolicyAgreed = value ?? false;
                }),
              ),
            ),
            Flexible(
              child: Text.rich(
                TextSpan(
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  children: [
                    const TextSpan(text: 'By logging in, you agree to our '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () => _showPolicyModal(context, 'terms'),
                        child: Text('Terms', style: theme.textTheme.bodySmall),
                      ),
                    ),
                    const TextSpan(text: ' & '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () => _showPolicyModal(context, 'privacy'),
                        child: Text(
                          'Privacy',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPolicyModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              type == 'privacy' ? 'Privacy Policy' : 'Terms of Service',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Expanded(
              child: PolicyNativeView(
                policyType: type,
                contentRepository: context.read<ContentRepository>(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
