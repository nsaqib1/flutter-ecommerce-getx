import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    print(widget.url);
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            LinearProgressIndicator(value: progress / 100);
            setState(() {});
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            print("error");
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.endsWith('success') || request.url.endsWith('success&risk_level=1')) {
              Get.defaultDialog(
                title: "Payment Success",
                middleText: "We have received your payment! We will deliver your products shortly",
                backgroundColor: Colors.green,
                titleStyle: const TextStyle(color: Colors.white),
                middleTextStyle: const TextStyle(color: Colors.white),
              );
              await Future.delayed(const Duration(seconds: 2));
              Get.find<MainBottomNavController>().backToHome();
              Get.offAll(const MainBottomNavScreen());
              return NavigationDecision.prevent;
            } else if (request.url.endsWith('Failed')) {
              Get.defaultDialog(
                title: "Payment Failed",
                middleText: "Something went wrong! Try again!",
                backgroundColor: Colors.red,
                titleStyle: const TextStyle(color: Colors.white),
                middleTextStyle: const TextStyle(color: Colors.white),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
