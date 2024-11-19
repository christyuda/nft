import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../provider/dashboard_provider.dart';

class DashboardPengguna extends StatefulWidget {
  const DashboardPengguna({Key? key}) : super(key: key);

  @override
  State<DashboardPengguna> createState() => _DashboardPenggunaState();
}

class _DashboardPenggunaState extends State<DashboardPengguna> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false)
        .initDashboardUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (context, dsh, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Sz.hpfactor(context, 10)),
            Sz.title(context, 'Dashboard Pengguna', TextAlign.left,
                Palette.blackClr),
            SizedBox(height: Sz.hpfactor(context, 10)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 3,
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
                                'Pertumbuhan Pengguna sejak februari 2023',
                                TextAlign.left,
                                Palette.blackClr),
                            // Sz.title(context, 'Bulan April', TextAlign.left,
                            //     Palette.blackClr),
                          ],
                        ),
                        Divider(),
                        // Expanded(
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Expanded(
                        //         child: DChartLineN(
                        //           // includeArea: true,
                        //           animate: true,
                        //           // includePoints: true,
                        //           // lineColor: (lineData, index, id) {
                        //           //   return id == 'user'
                        //           //       ? Colors.blue
                        //           //       : Colors.amber;
                        //           // },
                        //           groupList: dsh.totalUserMonthly,
                        //         ),
                        //       ),
                        //       Sz.title(context, 'Bulan', TextAlign.center,
                        //           Palette.blackClr)
                        //     ],
                        //   ),
                        // ),
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
                        Sz.title(context, 'Total Pengguna', TextAlign.left,
                            Palette.blackClr),
                        Divider(),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Palette.bordercolor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.people_alt_outlined,
                                      color: Palette.primary, size: 25),
                                  Sz.title(context, 'Total Pengguna',
                                      TextAlign.left, Palette.blackClr),
                                  Expanded(
                                    child: Sz.headline4(
                                        context,
                                        '${dsh.totalUser}',
                                        TextAlign.center,
                                        Palette.blackClr),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: Sz.hpfactor(context, 10)),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Palette.bordercolor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Sz.title(context, 'Jenis Akun Pengguna',
                                      TextAlign.left, Palette.blackClr),
                                  // Expanded(
                                  //   child: DChartPie(
                                  //     data: [
                                  //       {'domain': 'LitePlus', 'measure': 25},
                                  //       {'domain': 'Reguler', 'measure': 75},
                                  //     ],
                                  //     fillColor: (pieData, index) {
                                  //       switch (pieData['domain']) {
                                  //         case 'LitePlus':
                                  //           return Palette.primary2;
                                  //         case 'Reguler':
                                  //           return Palette.primary1;
                                  //
                                  //         default:
                                  //           return Colors.purple.shade900;
                                  //       }
                                  //     },
                                  //     pieLabel: (pieData, index) {
                                  //       return "${pieData['domain']}\n${pieData['measure']}%";
                                  //     },
                                  //     labelPosition: PieLabelPosition.outside,
                                  //     labelColor: Palette.primary1,
                                  //     labelFontSize: 10,
                                  //     labelLineColor: Palette.blackClr,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                )
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
                                Sz.title(context, 'Pertumbuhan Per Negara',
                                    TextAlign.left, Palette.blackClr),
                                Sz.title(context, 'Bulan April', TextAlign.left,
                                    Palette.blackClr),
                              ],
                            ),
                            // Expanded(
                            //   child: DChartBar(
                            //     data: dsh.totalUserCountryMonthly,
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
                            //     barColor: (barData, index, id) => id == 'Bar 1'
                            //         ? Palette.primary1
                            //         : Palette.primary2,
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
                                Sz.title(context, 'Monthly Active User',
                                    TextAlign.left, Palette.blackClr),
                                Sz.title(context, 'Bulan April', TextAlign.left,
                                    Palette.blackClr),
                              ],
                            ),
                            // Expanded(
                            //   child: DChartBar(
                            //     data: [
                            //       {
                            //         'id': 'Bar 1',
                            //         'data': [
                            //           {'domain': 'Taiwan', 'measure': 1000},
                            //           {'domain': 'Hongkong', 'measure': 750},
                            //           {'domain': 'Arab', 'measure': 500},
                            //           {'domain': 'Malaysia', 'measure': 300},
                            //           {'domain': 'Brunei', 'measure': 120},
                            //         ],
                            //       },
                            //     ],
                            //     yAxisTitle: 'Negara',
                            //     xAxisTitle: 'Jumlah',
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
                            //     barColor: (barData, index, id) => id == 'Bar 1'
                            //         ? Palette.primary1
                            //         : Palette.primary2,
                            //     barValue: (barData, index) =>
                            //         '${barData['measure']}',
                            //     showBarValue: true,
                            //     barValuePosition: BarValuePosition.auto,
                            //     barValueColor: Palette.whiteClr,
                            //     verticalDirection: true,
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
