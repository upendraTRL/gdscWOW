import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:testflutter/constant.dart';
import 'package:testflutter/location.dart';

var lat;
var long;

void getLatLong(gLat, gLong) {
  lat = gLat;
  long = gLong;
  print("Latiiiii");
}

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL); //Connection created
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    print(lat);
    var collection = db.collection(COLLECTION_NAME); //Collection specified
    // print(await collection.find().toList());

    final update = modify
      ..set('latitude', '40')
      ..set('longitude', '-100');

    await collection.updateMany(
        where
            .eq('latitude', '37.4219983')
            .and(where.eq('longitude', '-122.084')),
        update);

    // await collection.insertOne({
    //   "latitude": lat,
    //   "longitude": long,
    // });
  }
}
