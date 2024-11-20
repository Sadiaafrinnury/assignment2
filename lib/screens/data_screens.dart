import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controllers.dart';


class DataScreen extends StatelessWidget {
  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
            'Data From Api',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.items.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Card(
              child: ListTile(
                title: Text(
                    item.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                subtitle: Text(item.body),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
