import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testflutter/mongodb.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyRescuePage extends StatefulWidget {
  @override
  State<MyRescuePage> createState() => _MyRescuePageState();
}

class _MyRescuePageState extends State<MyRescuePage> {
//Webview
  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
              .startsWith('https://mrprayag077.github.io/gdsc-otherpgs/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://mrprayag077.github.io/gdsc-otherpgs/'));

  @override
  void initState() {
    print("object");
    super.initState();
    _getCurrentLocation().then((value) {
      lat = '${value.latitude}';
      long = '${value.longitude}';
      getLatLong(lat, long);
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Locatoon permission are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        title: Text("Survey Form"),
      ),

      //Body
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 500,
              child: WebViewWidget(controller: controller),
            )
          ],
        ),
      ),
    );
  }
}
