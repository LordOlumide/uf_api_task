import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> testHive({
    required String username,
    required String password,
  }) async {
    HiveService.store(
      boxName: 'Signup credentials',
      data: {'username': username, 'password': password},
    );

    await Future.delayed(const Duration(seconds: 4));

    HiveService.getData(
      boxName: 'Signup credentials',
      keys: ['username', 'password'],
    );
  }

  static Future<void> store({
    required String boxName,
    required Map<String, dynamic> data,
  }) async {
    Box box = await Hive.openBox(boxName);

    box.putAll(data);
    print('Storing data: $data');

    await Future.delayed(const Duration(seconds: 4));
  }

  static Future<Map<String, dynamic>> getData({
    required String boxName,
    required List<String> keys,
  }) async {
    Box box = await Hive.openBox(boxName);
    Map<String, dynamic> data = {};

    for (String i in keys) {
      data[i] = box.get(i);
    }

    print('getting data: $data');
    return data;
  }
}
