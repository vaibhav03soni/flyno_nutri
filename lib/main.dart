import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const FynnaWebViewApp());
}

class FynnaWebViewApp extends StatelessWidget {
  const FynnaWebViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fynna Nutri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WebViewScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => debugPrint("Loading: $url"),
          onPageFinished: (url) => debugPrint("Finished: $url"),
        ),
      )
      ..loadRequest(Uri.parse("https://fynna-nutri.kognosinfosystem.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // notch वाले devices पर safe area
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: WebViewWidget(controller: _controller),
            );
          },
        ),
      ),
    );
  }
}
