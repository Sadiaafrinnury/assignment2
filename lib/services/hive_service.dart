import 'package:hive/hive.dart';
import '../models/item_model.dart';

class HiveService {
  final _box = Hive.box('cacheBox');

  void saveItems(List<Item> items) {
    List<Map<String, dynamic>> itemsJson = items.map((item) => item.toJson()).toList();
    _box.put('items', itemsJson);
  }

  List<Item> getCachedItems() {
    final data = _box.get('items', defaultValue: []);
    if (data != null) {
      return (data as List).map((json) => Item.fromJson(json)).toList();
    }
    return [];
  }
}
