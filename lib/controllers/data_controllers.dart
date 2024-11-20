import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/item_model.dart';
import '../services/hive_service.dart';

class DataController extends GetxController {
  var items = <Item>[].obs;
  var isLoading = true.obs;

  final HiveService _hiveService = HiveService();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        items.value = data.map((json) => Item.fromJson(json)).toList();

        // Save to local storage
        _hiveService.saveItems(items);
      } else {
        Get.snackbar('Error', 'Failed to fetch data from server');
        loadCachedData();
      }
    } catch (e) {
      Get.snackbar('Message', 'No Internet Connection');
      loadCachedData();
    } finally {
      isLoading.value = false;
    }
  }

  void loadCachedData() {
    items.value = _hiveService.getCachedItems();
  }
}
