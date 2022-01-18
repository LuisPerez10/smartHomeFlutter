import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsService {
  TtsState ttsState = TtsState.stopped;
  late FlutterTts flutterTts;

  String language = "es-ES";
  late String engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  // TtsService() {}

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  initTts() {
    this.flutterTts = FlutterTts();

    _getDefaultEngine();

    flutterTts.setStartHandler(() {
      // setState(() {
      print("Playing");
      ttsState = TtsState.playing;
      // });
    });

    flutterTts.setCompletionHandler(() {
      // setState(() {
      print("Complete");
      ttsState = TtsState.stopped;
      // });
    });

    flutterTts.setCancelHandler(() {
      // setState(() {
      print("Cancel");
      ttsState = TtsState.stopped;
      // });
    });

    flutterTts.setErrorHandler((msg) {
      // setState(() {
      print("error: $msg");
      ttsState = TtsState.stopped;
      // });
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future speak(_newVoiceText) async {
    // await flutterTts.setVolume(volume);
    // await flutterTts.setSpeechRate(rate);
    // await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      // setState(() => ttsState = TtsState.stopped);
      ttsState = TtsState.stopped;
    }
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) ttsState = TtsState.paused;
    //  setState(() => ttsState = TtsState.paused);
  }

  dispose() {
    flutterTts.stop();
  }
}
