import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../controllers/create_invoice_controller.dart';
import 'payment_webview_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice(
        Get.find<AuthController>().token ?? "",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: GetBuilder<CreateInvoiceController>(builder: (createInvoiceController) {
        if (createInvoiceController.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        final invoiceWrapper = createInvoiceController.paymentMethodListModel.data!.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Payable: ${invoiceWrapper.payable}'),
                Text('VAT: ${invoiceWrapper.vat}'),
                Text('Total: ${invoiceWrapper.total}'),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: invoiceWrapper.paymentMethodList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => PaymentWebViewScreen(url: invoiceWrapper.paymentMethodList![index].redirectGatewayURL!));
                      },
                      leading: Image.network(invoiceWrapper.paymentMethodList![index].logo ?? ''),
                      title: Text(invoiceWrapper.paymentMethodList![index].name ?? ''),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
