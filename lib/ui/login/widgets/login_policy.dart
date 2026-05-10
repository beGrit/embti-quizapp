import 'package:emombti/ui/core/ui/widgets/policy.dart';
import 'package:flutter/material.dart';

class LoginPolicy extends StatefulWidget {
  const LoginPolicy({super.key});

  @override
  State<LoginPolicy> createState() => _LoginPolicyState();
}

class _LoginPolicyState extends State<LoginPolicy> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          value: _isAgreed,
          onChanged: (value) => setState(() => _isAgreed = value ?? false),
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              style: theme.textTheme.bodySmall,
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
                    child: Text('Privacy', style: theme.textTheme.bodySmall),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
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
            Expanded(child: PolicyWebView(policyType: type)),
          ],
        ),
      ),
    );
  }
}
