import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:neostore/order/model/order_model/order_summary_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';



Future<void> generatePdf({required OrderSummaryModel order}) async{
  final pdf = Document();
  pdf.addPage(Page(build: (context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product name',
                    ),
                    Text(
                      'quantity'),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: order.products!.map((e)=>Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [ Text(
                       '${e.name}',
                     ),
                     Text('${e.quantity}')])).toList()
                   )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Ordered on: ',
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              order.createdOn??0)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Delivered To: ',
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${order.user?.firstName} ${order.user?.lastName}',
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: order.address == null
                          ? SizedBox.shrink()
                          : Text(
                        '${order.address?.houseNo}, ${order.address?.firstLine}, ${order.address?.secondLine}, ${order.address?.city}, ${order.address?.state}, ${order.address?.country}, ${order.address?.pinCode}',
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Price Details: ',

                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total: ',
                        ),
                        Text(
                          '${order.subTotal} ',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount price: ',

                        ),
                        Text(
                          '${order.discount} ',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax: ',
                        ),
                        Text(
                          '${order.tax} ',
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price: ',
                        ),
                        Text(
                          'Rs. ${order.total} ',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  },));
 if(kIsWeb){

 } else{
  final root = await getApplicationDocumentsDirectory();
  final file = File('${root.path}/invoice${DateTime.now()}.pdf');
  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(file.path);
 }
}