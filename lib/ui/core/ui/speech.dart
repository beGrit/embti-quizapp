import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextIconWidget extends StatefulWidget {
  final ValueChanged<String> onResult;

  const SpeechToTextIconWidget({super.key, required this.onResult});

  @override
  State<SpeechToTextIconWidget> createState() => _SpeechToTextIconWidgetState();
}

class _SpeechToTextIconWidgetState extends State<SpeechToTextIconWidget> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app lifetime
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
  }

  /// Manually stop the recognition session
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      widget.onResult(result.recognizedWords);
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening ? Colors.red : Theme.of(context).primaryColor,
      ),
      onPressed: !_speechEnabled
          ? null
          : (_isListening ? _stopListening : _startListening),
      tooltip: 'Listen',
    );
  }
}
