import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:testflutter/constant.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);  //Connection created
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);  //Collection specified
    await collection.insertMany([
      {
        "username": "Ghosty",
        "name": "Chinmay",
      },
      {
        "username": "FatesEnd",
        "name": "Upendra",
      },
    ]);
    print("Hello");
    print(await collection.find().toList());
  }
}
