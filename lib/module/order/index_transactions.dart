import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/utils/currency.dart';
import 'package:webordernft/common/utils/date_indonesia.dart';
import 'package:webordernft/common/widget/btnwidget.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/constant.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/order/provider/transaction_provider.dart';
import '../../../common/provider/general_provider.dart';

class TransactionsListOrder extends StatefulWidget {
  const TransactionsListOrder({Key? key}) : super(key: key);

  @override
  State<TransactionsListOrder> createState() => _TransactionsListOrderState();
}

class _TransactionsListOrderState extends State<TransactionsListOrder> {
  final _keylistOrder = GlobalKey<FormBuilderState>(); // Form key

  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false)
        .getOrderList(context); // Fetch initial order list
  }

  // Method to apply filter
  void _applyFilter(BuildContext context) {
    if (_keylistOrder.currentState!.validate()) {
      _keylistOrder.currentState!.save();

      final formData = _keylistOrder.currentState!.value;

      Provider.of<TransactionProvider>(context, listen: false)
        ..ordererName = formData['orderer_name'] ?? ''
        ..startDate = formData['start_date'] != null
            ? DateFormat('yyyy-MM-dd').format(formData['start_date'])
            : ''
        ..endDate = formData['end_date'] != null
            ? DateFormat('yyyy-MM-dd').format(formData['end_date'])
            : ''
        ..qty = formData['qty'] ?? null
        ..paymentChanel = formData['payment_channel'] ?? null
        ..paymentStatus = formData['payment_status'] ?? null;

      Provider.of<TransactionProvider>(context, listen: false)
          .getOrderList(context);

      Navigator.pop(context);
    }
  }

  void _showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Filter Orders'),
          content: SingleChildScrollView(
            child: FormBuilder(
              key: _keylistOrder,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'orderer_name',
                    decoration: InputDecoration(
                      labelText: 'Orderer Name',
                      hintText: 'Enter Orderer Name',
                    ),
                  ),
                  SizedBox(height: 10),
                  FormBuilderDateTimePicker(
                    name: 'start_date',
                    inputType: InputType.date,
                    format: DateFormat('dd-MM-yyyy'),
                    decoration: InputDecoration(
                      labelText: 'Start Date (DD-MM-YYYY)',
                      hintText: 'Pick Start Date',
                    ),
                  ),
                  SizedBox(height: 10),
                  FormBuilderDateTimePicker(
                    name: 'end_date',
                    inputType: InputType.date,
                    format: DateFormat('dd-MM-yyyy'),
                    decoration: InputDecoration(
                      labelText: 'End Date (DD-MM-YYYY)',
                      hintText: 'Pick End Date',
                    ),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'qty',
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: 'Enter Quantity',
                    ),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'payment_channel',
                    decoration: InputDecoration(
                      labelText: 'Payment Channel',
                      hintText: 'Enter Payment Channel',
                    ),
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'payment_status',
                    decoration: InputDecoration(
                      labelText: 'Payment Status',
                      hintText: 'Enter Payment Status',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CancelButton(
              onPressed: () {
                Navigator.pop(context);
              },
              labelname: 'Cancel',
            ),
            SpaceVertical(size: 20),
            SubmitButton(
              onPressed: () {
                _applyFilter(context);
              },
              labelname: 'Apply',
              icn: Icons.check,
              clr: Palette.white,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionProvider>(
        builder: (context, orderProvider, _) => Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Sz.headline5(context, 'Kelola Orders', TextAlign.left,
                        Palette.blackClr),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Sz.caption(context, 'Search:', TextAlign.left,
                                Palette.blackClr),
                            SizedBox(width: 10),
                            Container(
                              width: 200,
                              child: FormBuilderTextField(
                                key: Key('search'),
                                name: 'search',
                                decoration: InputDecoration(
                                  hintText: 'Search orders...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onSubmitted: (val) {
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .ordererName = val;
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .getOrderList(context);
                                },
                                onChanged: (val) {
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .ordererName = val;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 150, // Adjust width
                              child: CancelButton(
                                onPressed: () {
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .getOrderList(context); // Clear filter
                                },
                                labelname: 'Cari',
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 150, // Adjust width
                              child: CancelButton(
                                onPressed: () {
                                  _keylistOrder.currentState?.reset();
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .ordererName = '';
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .clearFilter();
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .getOrderList(context); // Clear filter
                                },
                                labelname: 'Reset',
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150, // Adjust width
                              child: SubmitButton(
                                onPressed: () {
                                  _showFilterPopup(
                                      context); // Show filter popup
                                },
                                labelname: 'Filter',
                                icn: Icons.filter_list,
                                clr: Palette.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            // Reset button

                            SizedBox(
                              width: 220, // Adjust width
                              child: CancelButton(
                                onPressed: () {
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .downloadCsv(
                                          context,
                                          orderProvider
                                              .orderList); // Added missing arguments
                                },
                                labelname: 'Download CSV',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Sz.hpfactor(context, 20)),
                  ],
                ),
              ),
              Expanded(
                child: DataTable2(
                  headingRowHeight: 30,
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  headingRowColor:
                      MaterialStateProperty.all<Color>(Palette.primary2),
                  columns: [
                    DataColumn2(
                      fixedWidth: 78,
                      size: ColumnSize.S,
                      label: Sz.headline(
                          context, 'No', TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Tanggal Transaksi',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Nama Pemesan',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(
                          context, 'Email', TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(
                          context, 'Kota', TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Jumlah Barang',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Metode Pembayaran',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Status Pembayaran',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Status Order',
                          TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(
                          context, 'No Resi', TextAlign.left, Palette.white),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Sz.headline(context, 'Total Harga', TextAlign.left,
                          Palette.white),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                      orderProvider.orderList
                          .length, // Generate rows based on the list length
                      (index) {
                    final order = orderProvider.orderList[index];
                    return DataRow(cells: [
                      DataCell(Sz.subtitle(context, '${index + 1}',
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(
                          context,
                          FormatDateINA.formatTglIndo(order.trxDate.toString()),
                          TextAlign.left,
                          Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.ordererName,
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.email, TextAlign.left,
                          Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.city, TextAlign.left,
                          Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.qty.toString(),
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.paymentMethod,
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.paymentStatusText,
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.orderStatusText,
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(context, order.shippingReceiptNumber,
                          TextAlign.left, Palette.blackClr)),
                      DataCell(Sz.subtitle(
                          context,
                          Currency.formatregular(order.orderAmount as double),
                          TextAlign.left,
                          Palette.blackClr)),
                    ]);
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Sz.caption(
                            context,
                            'Showing ${orderProvider.fromRow} to ${orderProvider.toRow} of ${orderProvider.totalRow} entries',
                            TextAlign.start,
                            Palette.primary,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.skip_previous_rounded),
                                onPressed: () {
                                  orderProvider.nextPage(context, 'previous');
                                },
                                color: Palette.primary,
                              ),
                              Sz.caption(
                                context,
                                'Page : ${orderProvider.currentPage} / ${orderProvider.lastPage}',
                                TextAlign.center,
                                Palette.primary,
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next_rounded),
                                onPressed: () {
                                  orderProvider.nextPage(context, 'next');
                                },
                                color: Palette.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
