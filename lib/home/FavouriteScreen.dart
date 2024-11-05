import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tezda_task/Controller/ProductController.dart';

class Favouritescreen extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (productController.favoriteProducts.isEmpty) {
          return Center(child: Text("No favorite products"));
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: productController.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = productController.favoriteProducts.toList()[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Image.network(
                  product.image ?? '',
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported),
                ),
                title: Text(product.title ?? 'No Title'),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    productController.toggleFavorite(product);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
