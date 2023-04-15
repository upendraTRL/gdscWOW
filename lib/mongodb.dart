import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:testflutter/constant.dart';

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
    var neww;
    var dataFetched = [
      {"new": neww}
    ];
    dataFetched =
        await collection.find({"latitude": lat, "longitude": long}).toList();
    print(dataFetched);

    if (dataFetched.isEmpty) {
      print("newwwwwwwwwwww");
      await collection.insertOne({
        "latitude": lat,
        "longitude": long,
      });
    } else {
      final update = modify
        ..set('latitude', '1321')
        ..set('longitude', '-31311');

      await collection.updateMany(
          where.eq('latitude', lat).and(where.eq('longitude', long)), update);
    }
  }
}
