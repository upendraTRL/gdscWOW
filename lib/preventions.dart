import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class MyPrevention extends StatefulWidget {
  @override
  _MyPreventionState createState() => _MyPreventionState();
}

class _MyPreventionState extends State<MyPrevention> {
  var storePrev;

  void getPrev(fetchedPrev){
    storePrev = fetchedPrev;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preventions"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              child: Card(
                margin: EdgeInsets.only(bottom: 10, top: 2),
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
