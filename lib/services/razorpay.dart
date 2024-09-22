import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService extends StatefulWidget {
  final int money;
  final Function(String) handlePaymentSuccess; // Accepts payment ID as String
  final Function(PaymentFailureResponse) handlePaymentError; // Accepts PaymentFailureResponse
  final Function(String) handleExternalWallet; // Accepts wallet name as String

  RazorpayService({
    Key? key,
    required this.money,
    required this.handleExternalWallet,
    required this.handlePaymentError,
    required this.handlePaymentSuccess,
  }) : super(key: key);

  @override
  State<RazorpayService> createState() => _RazorpayServiceState();
}

class _RazorpayServiceState extends State<RazorpayService> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (widget.money * 100).toString(), // Amount in paise
      'currency': 'INR', // Specify the currency
      'name': 'Direction',
      'description': 'Recharge Plan Activation',
      'prefill': {
        'contact': '+917993478539',
        'email': 'aarihantaaryan@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    // Setting up event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      widget.handlePaymentSuccess(''); // Call with paymentId
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      widget.handlePaymentError(response); // Call with PaymentFailureResponse
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (String wallet) {
      widget.handleExternalWallet(wallet); // Call with wallet name
    });

    // Open Razorpay payment
    _razorpay.open(options);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear the Razorpay instance
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Processing Payment...')),
    );
  }
}
