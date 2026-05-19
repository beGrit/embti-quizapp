import 'dart:async';

import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Circular progress for the most recently started [SurveyFlow], with tap to resume.
class SurveyFlowProgressFab extends StatefulWidget {
  const SurveyFlowProgressFab({super.key});

  @override
  State<SurveyFlowProgressFab> createState() => _SurveyFlowProgressFabState();
}

class _SurveyFlowProgressFabState extends State<SurveyFlowProgressFab> {
  SurveyFlow? _latest;
  bool _loading = true;
  GoRouter? _router;
  Timer? _debounce;

  Future<void> _load() async {
    final repo = context.read<SurveyFlowRepository>();
    final flows = await repo.getFlows();
    if (!mounted) return;
    setState(() {
      _latest = flows.isEmpty ? null : flows.first;
      _loading = false;
    });
  }

  void _debouncedLoad() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (mounted) _load();
    });
  }

  void _onRouterChanged() {
    if (!mounted) return;
    final path = GoRouterState.of(context).uri.path;
    if (path == Routes.home) {
      debugPrint(path);
      _debouncedLoad();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = GoRouter.maybeOf(context);
    if (router != _router) {
      _router?.routerDelegate.removeListener(_onRouterChanged);
      _router = router;
      _router?.routerDelegate.addListener(_onRouterChanged);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _router?.routerDelegate.removeListener(_onRouterChanged);
    super.dispose();
  }

  Future<void> _openFlow() async {
    final flow = _latest;
    if (flow == null) return;
    await context.push(
      Uri(
        path: Routes.surveyFlow,
        queryParameters: {'flowId': flow.id, 'surveyId': flow.surveyId},
      ).toString(),
    );
    if (mounted) _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox.shrink();
    }
    final flow = _latest;
    if (flow == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final rate = flow.completionRate.clamp(0.0, 1.0);
    final pct = (rate * 100).round();

    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.primaryContainer,
      child: InkWell(
        onTap: _openFlow,
        customBorder: const CircleBorder(),
        child: Tooltip(
          message: 'Resume quiz · $pct% complete',
          child: SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  constraints: BoxConstraints(minHeight: 48, minWidth: 48),
                  value: rate,
                  strokeWidth: 3.5,
                  backgroundColor: theme.colorScheme.surfaceContainer,
                  color: theme.colorScheme.onPrimaryContainer,
                  strokeCap: StrokeCap.round,
                ),
                Text(
                  '$pct%',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
