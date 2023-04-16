import 'package:flutter/material.dart';
import 'package:testflutter/language_page.dart';
import 'package:testflutter/services/notifi_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testflutter/mongodb.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationMessage = "Current location";
  late String lat;
  late String long;

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

  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        title: Text(widget.title),
      ),

      //Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'My App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shield),
              title: const Text('Preventions'),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Precautions'),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Languages'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyLangPage()));
              },
            ),
          ],
        ),
      ),

      //Body
      body: Center(
          child: Column(
        children: [
          Container(
            // padding: EdgeInsets.all(16),
            // color: Colors.grey[200],
            child: Card(
              margin: EdgeInsets.only(bottom: 10, top: 20),
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Sydney', style: TextStyle(fontSize: 32)),
                    SizedBox(height: 15),
                    Text(
                      'Temparature: 35 C \n\nCalamity: Tsunami \n\nPrecautions: Move to amsterdam (Safe Location)',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 400,
            height: 200,
            child: WebViewWidget(controller: controller),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('S.O.S'),
            onPressed: () {
              NotificationService().showNotification(
                  title: 'Alert', body: 'Earthquake started at Nagar!');
            },
          )
        ],
      )),
    );
  }
}










//Notification button

// ElevatedButton(
//         child: const Text('Show notifications'),
//         onPressed: () {
//           NotificationService()
//               .showNotification(title: 'Sample title', body: 'It works!');
//         },
//       )