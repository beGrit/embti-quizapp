import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../state/robot.dart';

class ChatBot extends StatefulWidget {
  final ChatBotViewModel viewModel;

  const ChatBot({super.key, required this.viewModel});

  @override
  State<ChatBot> createState() => ChatBotState();
}

class ChatBotState extends State<ChatBot> with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.viewModel.currentState == BotState.clicked) {
        widget.viewModel.switchToState(BotState.idle);
      }
    });

    widget.viewModel.addListener(_handleStateChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_handleStateChange);
    _lottieController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatBot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel != oldWidget.viewModel) {
      oldWidget.viewModel.removeListener(_handleStateChange);
      widget.viewModel.addListener(_handleStateChange);
    }
  }

  void _handleStateChange() {
    if (!mounted) return;
    switch (widget.viewModel.currentState) {
      case BotState.idle:
        _lottieController.repeat(min: 0.1, max: 0.2);
        break;
      case BotState.thinking:
        _lottieController.repeat(min: 0.3, max: 0.6);
        break;
      case BotState.speaking:
        _lottieController.repeat(min: 0.6, max: 0.8);
        break;
      case BotState.clicked:
        _lottieController.forward(from: 0.8);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => widget.viewModel.switchToState(BotState.clicked),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Lottie.asset(
                      'assets/json/chatbot_v2.json',
                      fit: BoxFit.contain,
                      controller: _lottieController,
                      onLoaded: (composition) {
                        _lottieController.duration = composition.duration;
                        // Initialize the idle animation once the composition is loaded
                        _handleStateChange();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.viewModel.currentState == BotState.thinking
                      ? 'Thinking...'
                      : widget.viewModel.currentState == BotState.speaking
                      ? 'Speaking...'
                      : widget.viewModel.currentState == BotState.clicked
                      ? 'Ouch!'
                      : 'Active',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.2,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Analyze MBTI'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.2,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Chat with AI Expert'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
