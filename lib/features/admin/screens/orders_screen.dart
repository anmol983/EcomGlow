// ignore_for_file: unused_element

import 'package:EcomGlow/features/account/widgets/single_product.dart';
import 'package:EcomGlow/features/admin/services/admin_service.dart';
import 'package:EcomGlow/features/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: orderData.products.isNotEmpty
                      ? SingleProduct(
                          image: orderData.products[0].images[0],
                        )
                      : const Placeholder(), // Placeholder for empty product list
                ),
              );
            },
          );
  }
}
