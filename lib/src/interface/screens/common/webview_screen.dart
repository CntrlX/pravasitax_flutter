import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({
    Key? key,
    required this.url,
    this.title = '',
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize the platform-specific WebView implementation
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);

    // Configure the WebViewController
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
            // Inject CSS to immediately remove headers
            _injectHeaderRemovalCSS();
          },
          onPageFinished: (String url) {
            // Double-ensure header removal with JavaScript
            _removePageHeader();
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web Resource Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // Inject CSS to immediately hide headers
  void _injectHeaderRemovalCSS() {
    controller.runJavaScript('''
      var style = document.createElement('style');
      style.innerHTML = `
        header, nav, .header, .navigation, #header, #nav, 
        .site-header, .main-header, .page-header {
          display: none !important;
          visibility: hidden !important;
          height: 0 !important;
          max-height: 0 !important;
          margin: 0 !important;
          padding: 0 !important;
        }
        body {
          margin-top: 0 !important;
          padding-top: 0 !important;
        }
      `;
      document.head.appendChild(style);
    ''');
  }

  // Additional method to remove page headers
  void _removePageHeader() {
    controller.runJavaScript('''
      // Additional removal method as a fallback
      var headers = document.querySelectorAll('header, nav, .header, .navigation, #header, #nav, .site-header, .main-header, .page-header');
      headers.forEach(function(header) {
        header.remove(); // Completely remove the element
      });
      
      // Ensure no top spacing
      if (document.body) {
        document.body.style.paddingTop = '0px';
        document.body.style.marginTop = '0px';
      }
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
