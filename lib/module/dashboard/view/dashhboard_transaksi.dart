import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/dashboard/provider/dashboard_provider.dart';

import '../../../common/utils/currency.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';

class DashboardTransaksi extends StatefulWidget {
  const DashboardTransaksi({Key? key}) : super(key: key);

  @override
  State<DashboardTransaksi> createState() => _DashboardTransaksiState();
}

class _DashboardTransaksiState extends State<DashboardTransaksi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false)
        .initDashboardTransaction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (context, dsh, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Sz.hpfactor(context, 10)),
            Sz.title(context, 'Dashboard Transaksi', TextAlign.left,
                Palette.blackClr),
            SizedBox(height: Sz.hpfactor(context, 10)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.bordercolor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Sz.title(context, 'GTV (April)', TextAlign.left,
                                Palette.blackClr),
                            Sz.title(context, '29.000.000.000.000',
                                TextAlign.left, Palette.blackClr),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Palette.bordercolor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Sz.subtitle(context, 'Total GTV',
                                          TextAlign.left, Palette.blackClr),
                                      Expanded(
                                        child: Sz.headline(
                                            context,
                                            '${Currency.idr(dsh.resumeTrx!.length == 0 ? '0' : dsh.resumeTrx![0].totalBillAmount!)}',
                                            TextAlign.center,
                                            Palette.blackClr),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        // Expanded(
                        //     flex: 3,
                        //     child: Container(
                        //       padding: EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //           border:
                        //               Border.all(color: Palette.bordercolor),
                        //           borderRadius: BorderRadius.circular(10)),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Expanded(
                        //             child: DChartPie(
                        //               data: dsh.topGtv,
                        //               fillColor: (pieData, index) {
                        //                 return Switcher()
                        //                     .product(pieData['domain']);
                        //               },
                        //               pieLabel: (pieData, index) {
                        //                 return "${pieData['domain']}\n${pieData['measure']}%";
                        //               },
                        //               labelPosition: PieLabelPosition.outside,
                        //               labelColor: Palette.primary1,
                        //               labelLinelength: 10,
                        //               labelFontSize: 11,
                        //               labelLineColor: Palette.blackClr,
                        //               donutWidth: 30,
                        //             ),
                        //           ),
                        //           Sz.subtitle(context, 'Top 5 Penyumbang GTV',
                        //               TextAlign.center, Palette.blackClr),
                        //         ],
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Sz.hpfactor(context, 20)),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.bordercolor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Sz.title(context, 'Transaksi', TextAlign.left,
                                Palette.blackClr),
                            Sz.subtitle(context, 'Bulan April', TextAlign.left,
                                Palette.blackClr),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Palette.bordercolor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Sz.subtitle(context, 'Total Transaksi',
                                          TextAlign.center, Palette.blackClr),
                                      Expanded(
                                        child: Sz.headline(
                                            context,
                                            '${dsh.resumeTrx!.length == 0 ? '0' : dsh.resumeTrx![0].totalTransaction}',
                                            TextAlign.center,
                                            Palette.blackClr),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        // Expanded(
                        //   flex: 3,
                        //   child: Container(
                        //     padding: EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Palette.bordercolor),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Expanded(
                        //           child: DChartPie(
                        //             data: dsh.topTrx,
                        //             fillColor: (pieData, index) {
                        //               return Switcher()
                        //                   .product(pieData['domain']);
                        //             },
                        //             pieLabel: (pieData, index) {
                        //               return "${pieData['domain']}\n${pieData['measure']} %";
                        //             },
                        //             labelPosition: PieLabelPosition.outside,
                        //             labelColor: Palette.primary1,
                        //             labelFontSize: 11,
                        //             labelLinelength: 7,
                        //             labelLineColor: Palette.blackClr,
                        //             donutWidth: 35,
                        //           ),
                        //         ),
                        //         Sz.subtitle(context, 'Top 5 Transaksi',
                        //             TextAlign.center, Palette.blackClr),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Sz.hpfactor(context, 20)),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.bordercolor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Sz.title(
                                context,
                                'Pertumbuhan Transaksi ( Rupiah )',
                                TextAlign.left,
                                Palette.blackClr),
                            Sz.title(context, '20 April', TextAlign.left,
                                Palette.blackClr),
                          ],
                        ),
                        Divider(),
                        // Expanded(
                        //   child: DChartBar(
                        //     data: dsh.monthlytrxvsgtv,
                        //
                        //     // yAxisTitle: 'Total',
                        //     // xAxisTitle: 'Transaksi VS GTV',
                        //     minimumPaddingBetweenLabel: 1,
                        //     domainLabelPaddingToAxisLine: 16,
                        //     axisLineTick: 2,
                        //     axisLinePointTick: 2,
                        //     axisLinePointWidth: 10,
                        //     axisLineColor: Palette.primary2,
                        //     measureLabelPaddingToAxisLine: 16,
                        //     barColor: (barData, index, id) => id == 'gtv'
                        //         ? Palette.errorColor
                        //         : id == 'trx'
                        //             ? Palette.primary2
                        //             : Palette.primary3,
                        //     barValue: (barData, index) =>
                        //         '${Currency.idr(barData['measure'].toString())}',
                        //     showBarValue: true,
                        //     showDomainLine: true,
                        //     barValueFontSize: 9,
                        //     barValuePosition: BarValuePosition.outside,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: Sz.hpfactor(context, 20)),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Palette.bordercolor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Sz.title(
                                    context,
                                    'Jenis Transaksi dalam rupiah',
                                    TextAlign.left,
                                    Palette.blackClr),
                                Sz.title(context, '2023', TextAlign.left,
                                    Palette.blackClr),
                              ],
                            ),
                            // Expanded(
                            //   child: DChartBar(
                            //     data: dsh.monthlygtvproduct,
                            //
                            //     // yAxisTitle: 'Negara',
                            //     // xAxisTitle: 'Jumlah',
                            //     showDomainLine: true,
                            //     // measureMin: 0,
                            //     // measureMax: 100,
                            //     minimumPaddingBetweenLabel: 1,
                            //     domainLabelPaddingToAxisLine: 16,
                            //     axisLineTick: 2,
                            //     axisLinePointTick: 2,
                            //     axisLinePointWidth: 10,
                            //     axisLineColor: Palette.blackClr,
                            //     measureLabelPaddingToAxisLine: 16,
                            //     barColor: (barData, index, id) {
                            //       return Switcher()
                            //           .product('${barData['domain']}');
                            //     },
                            //     barValue: (barData, index) =>
                            //         '${Currency.idr(barData['measure'].toString())}',
                            //     showBarValue: true,
                            //     barValuePosition: BarValuePosition.auto,
                            //     barValueColor: Palette.whiteClr,
                            //     verticalDirection: false,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Sz.hpfactor(context, 20)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Palette.bordercolor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Sz.title(
                                    context,
                                    'Jenis Transaksi Dalam Rupiah',
                                    TextAlign.left,
                                    Palette.blackClr),
                                Sz.title(context, 'Bulan April', TextAlign.left,
                                    Palette.blackClr),
                              ],
                            ),
                            // Expanded(
                            //   child: DChartBar(
                            //     data: dsh.monthlytrxproduct,
                            //
                            //     showDomainLine: true,
                            //     // measureMin: 0,
                            //     // measureMax: 100,
                            //     minimumPaddingBetweenLabel: 1,
                            //     domainLabelPaddingToAxisLine: 16,
                            //     axisLineTick: 2,
                            //     axisLinePointTick: 2,
                            //     axisLinePointWidth: 10,
                            //     axisLineColor: Palette.blackClr,
                            //     measureLabelPaddingToAxisLine: 16,
                            //     barColor: (barData, index, id) {
                            //       return Switcher()
                            //           .product('${barData['domain']}');
                            //     },
                            //     barValue: (barData, index) =>
                            //         '${barData['measure']}',
                            //     showBarValue: true,
                            //     barValuePosition: BarValuePosition.auto,
                            //     barValueColor: Palette.whiteClr,
                            //     verticalDirection: false,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
