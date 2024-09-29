import 'package:direction/services/inn_app_purchase/waiting_inn_app_purchase.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'complete_inn_app_purchase.dart';
import 'fail_inn_app_purchase.dart';

class InAppPurchaseHandler {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _available = true;
  late Stream<List<PurchaseDetails>> purchaseStream;
  final BuildContext context;

  InAppPurchaseHandler({required this.context}) {
    purchaseStream = _inAppPurchase.purchaseStream;
    _initialize();
  }

  Future<void> _initialize() async {
    _available = await _inAppPurchase.isAvailable();
    if (!_available) {
      print('In-app purchases are not available.');
    }
  }

  Future<void> makePurchase(String productId) async {
    if (_available) {
      // Show waiting screen
      Navigator.push(context, MaterialPageRoute(builder: (_) => WaitingScreen()));

      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: await _getProductDetails(productId),
      );
      _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);

      listenToPurchaseUpdates((purchaseDetailsList) {
        for (var purchase in purchaseDetailsList) {
          if (purchase.status == PurchaseStatus.purchased) {
            // Navigate to the success screen
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CompleteScreen()));
          } else if (purchase.status == PurchaseStatus.error) {
            // Navigate to the failure screen
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FailScreen()));
          }
        }
      });
    } else {
      print('In-app purchases are not available.');
    }
  }

  Future<ProductDetails> _getProductDetails(String productId) async {
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails({productId});
    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Product ID not found.');
    }
    return response.productDetails.first;
  }

  void listenToPurchaseUpdates(void Function(List<PurchaseDetails>) onPurchaseUpdate) {
    purchaseStream.listen(onPurchaseUpdate);
  }
}
