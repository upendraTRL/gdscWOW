import 'package:flutter/material.dart';
import 'package:testflutter/services/notifi_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
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
              onTap: () {},
            ),
          ],
        ),
      ),

      //Body
      body: Center(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('S.O.S'),
        onPressed: () {
          NotificationService().showNotification(
              title: 'Alert', body: 'Earthquake started at Nagar!');
        },
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