import 'dart:async';
import 'dart:convert';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openhab_flutter/services/items_service.dart';
import 'package:openhab_flutter/services/tts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class FlaotingButton extends StatefulWidget {
  const FlaotingButton({Key? key}) : super(key: key);

  @override
  _FlaotingButtonState createState() => _FlaotingButtonState();
}

class _FlaotingButtonState extends State<FlaotingButton> {
  bool ttsOn = true;
  final TtsService ttsService = new TtsService();

  final TextEditingController _textController = TextEditingController();

  bool _isRecording = false;

  RecorderStream _recorder = RecorderStream();
  late StreamSubscription _recorderStatus;
  late StreamSubscription<List<int>> _audioStreamSubscription;
  late BehaviorSubject<List<int>> _audioStream;

  late DialogflowGrpcV2Beta1 dialogflow;

  late ItemsService itemsService = new ItemsService();

  @override
  void initState() {
    super.initState();
    iniciarPlugin();
    this.ttsService.initTts();
  }

  @override
  void dispose() {
    _recorderStatus.cancel();
    _audioStreamSubscription.cancel();
    // _recorderStatus?.cancel();
    // _audioStreamSubscription?.cancel();
    this.ttsService.dispose();
    super.dispose();
  }

  Future<void> iniciarPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    await Future.wait([_recorder.initialize()]);

    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/credentials.json'))}');

    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
  }

  void stopStream() async {
    await _recorder.stop();
    await _audioStreamSubscription.cancel();
    await _audioStream.close();
    // await _audioStreamSubscription?.cancel();
    // await _audioStream?.close();
  }

  void manejaSubmitted(text) async {
    if (_textController.text.isEmpty) return;
    _textController.clear();

    // setState(() {
    //   // _messages.insert(0, message);
    // });

    DetectIntentResponse data = await dialogflow.detectIntent(text, 'es-ES');
    // String fulfillmentText = data.queryResult.fulfillmentText;
    String fulfillmentText =
        data.queryResult.fulfillmentMessages[0].text.text[0];
    if (fulfillmentText.isEmpty) {
      ttsService.speak("No hemos podido conectarnos con el Servidor");
      return;
    }

    if (data.queryResult.fulfillmentMessages[1].hasPayload()) {
      // enviar a openHab
      var payload = data.queryResult.fulfillmentMessages[1].payload.fields;

      var item = payload["item"]!.stringValue;
      var commands = payload["commands"]!.stringValue;
      var cdos = json.decode(commands);

      for (var i = 0; i < cdos.length; i++) {
        await itemsService.setItemsState(item, cdos[i]);
      }
    }

    setState(() {
      if (this.ttsOn) ttsService.speak(fulfillmentText);
    });
  }

  void manejaStream() async {
    _recorder.start();

    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((data) {
      _audioStream.add(data);
    });

    var biasList = SpeechContextV2Beta1(phrases: [
      'Dialogflow CX',
      'Dialogflow Essentials',
      'Action Builder',
      'HIPAA'
    ], boost: 20.0);

    var config = InputConfigV2beta1(
        encoding: 'AUDIO_ENCODING_LINEAR_16',
        languageCode: 'es-ES',
        sampleRateHertz: 16000,
        singleUtterance: false,
        speechContexts: [biasList]);

    final responseStream =
        dialogflow.streamingDetectIntent(config, _audioStream);

    responseStream.listen((data) async {
      // setState(() {
      String fulfillmentText = data.queryResult.fulfillmentText;
      var fulfillmentMessage = data.queryResult.fulfillmentMessages;
      if (fulfillmentMessage.length > 0) {
        fulfillmentText = fulfillmentMessage[0].text.text[0];
      }

      if (fulfillmentText.isNotEmpty) {
        if (fulfillmentMessage.length > 1) {
          // enviar a openHab
          var payload = data.queryResult.fulfillmentMessages[1].payload.fields;

          var item = payload["item"]!.stringValue;
          if (!payload.containsKey("commands")) {
            ttsService.speak("No he podido entender el estado");
            return;
          }

          var commands = payload["commands"];
          var cdos;
          if (commands!.hasStringValue()) {
            var command = commands.stringValue;
            cdos = json.decode(command);
            for (var i = 0; i < cdos.length; i++) {
              await itemsService.setItemsState(item, cdos[i].toString());
            }
          } else if (commands.hasListValue()) {
            cdos = payload["commands"]!.listValue.values.toList();
            for (var i = 0; i < cdos.length; i++) {
              var value = cdos[i].hasStringValue()
                  ? cdos[i].stringValue
                  : cdos[i].numberValue;
              await itemsService.setItemsState(item, value.toString());
            }
          } else if (commands.hasNullValue()) {
            var estado = await itemsService.getItemState(item);
            fulfillmentText +=
                (int.parse(estado) < 500) ? "iluninado" : "Oscuro";
          }

          setState(() {
            if (this.ttsOn) ttsService.speak(fulfillmentText);
          });
        } else {
          ttsService.speak(fulfillmentText);
        }
      }
      ;
    }, onError: (e) {
      ttsService.speak("No hemos podido conectarnos");
    }, onDone: () {});
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return FloatingActionButton(
        backgroundColor: _isRecording ? Colors.orange : primaryColor,
        child: GestureDetector(
          child: Icon(_isRecording ? Icons.record_voice_over : Icons.mic),
          onLongPress: () => {
            if (!_isRecording)
              {
                print("manejaStream"),
                manejaStream(),
              },
          },
          onLongPressEnd: (abc) => {
            if (_isRecording)
              {
                print("stopStream"),
                stopStream(),
              }
          },
        ),
        onPressed: null // () => {
        // _textController.text = "Encende la luz",
        // manejaSubmitted(_textController.text)
        // },
        );
  }
}
