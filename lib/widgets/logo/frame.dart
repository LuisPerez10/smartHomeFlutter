import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FrameAsWidget extends StatefulWidget {
  final url;
  const FrameAsWidget({Key? key, @required this.url}) : super(key: key);

  @override
  _FrameAsWidgetState createState() => _FrameAsWidgetState();
}

class _FrameAsWidgetState extends State<FrameAsWidget>
    with AutomaticKeepAliveClientMixin<FrameAsWidget> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    return Stack(
      children: [
        WebView(
          initialUrl: this.widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
