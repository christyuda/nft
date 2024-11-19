import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/widget/progress_line.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/dashboard/provider/dashboard_provider.dart';

import '../../../common/utils/status_color.dart';

class DashboardTicket extends StatefulWidget {
  const DashboardTicket({Key? key}) : super(key: key);

  @override
  State<DashboardTicket> createState() => _DashboardTicketState();
}

class _DashboardTicketState extends State<DashboardTicket> {
  var initialDateval = DateFormat('M').format(new DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<DashboardProvider>(context, listen: false)
        .getDailyTicket(context);
    Provider.of<DashboardProvider>(context, listen: false)
        .getticketstatusmontly(context);
    Provider.of<DashboardProvider>(context, listen: false)
        .getTicketSourceMontly(context);
    Provider.of<DashboardProvider>(context, listen: false)
        .getticketIssueMontly(context);
    Provider.of<DashboardProvider>(context, listen: false)
        .getticketformonth(context);
    Provider.of<DashboardProvider>(context, listen: false)
        .getticketformonthall(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (context, dsh, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Sz.title(context, 'Status Pengaduan', TextAlign.left,
                          Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      // Expanded(
                      //     child: Container(
                      //   padding: EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Palette.bordercolor),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 3,
                      //         child: Center(
                      //           child: Container(
                      //             child: DChartPie(
                      //               animate: true,
                      //               labelFontSize: 10,
                      //               labelLineThickness: 2,
                      //               data: dsh.collection,
                      //               fillColor: (pieData, index) {
                      //                 switch (pieData['domain']) {
                      //                   case 'Baru':
                      //                     return Palette.openClr;
                      //                   case 'Dalam Proses':
                      //                     return Palette.inprogressClr;
                      //                   // case 'canceled':
                      //                   //   return Palette.cancelClr;
                      //                   case 'Selesai':
                      //                     return Palette.completedClr;
                      //                   default:
                      //                     return Colors.orange;
                      //                 }
                      //               },
                      //               pieLabel: (pieData, index) {
                      //                 return "${pieData['domain']}";
                      //                 // return "${pieData['domain']}:\n${pieData['measure']}%";
                      //               },
                      //               labelPosition: PieLabelPosition.auto,
                      //               donutWidth: 50,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Container(
                      //           child: SingleChildScrollView(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Container(
                      //                   child: Row(
                      //                     children: [
                      //                       Expanded(
                      //                         flex: 1,
                      //                         child: Sz.title(
                      //                             context,
                      //                             'Status',
                      //                             TextAlign.left,
                      //                             Palette.blackClr),
                      //                       ),
                      //                       Expanded(
                      //                         flex: 3,
                      //                         child: Container(
                      //                           child: FormBuilderDropdown(
                      //                             initialValue: initialDateval,
                      //                             name: 'bln',
                      //                             elevation: 1,
                      //                             isDense: true,
                      //                             focusColor:
                      //                                 Colors.transparent,
                      //                             decoration: InputDecoration(
                      //                               contentPadding:
                      //                                   EdgeInsets.symmetric(
                      //                                       vertical: 5,
                      //                                       horizontal: 10),
                      //                               fillColor: Colors.white,
                      //                               hintText: 'Bulan',
                      //                               hintStyle: TextStyle(
                      //                                 color: Palette.blackClr,
                      //                                 fontSize: 12,
                      //                                 fontFamily:
                      //                                     SFProSemiBoldFnt,
                      //                               ),
                      //                               labelStyle: TextStyle(
                      //                                 color: Palette.white,
                      //                                 fontSize: 10,
                      //                                 fontFamily:
                      //                                     SFProSemiBoldFnt,
                      //                               ),
                      //                               enabledBorder:
                      //                                   OutlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                                   color:
                      //                                       Colors.transparent,
                      //                                   width: 0.0,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             items: dsh.listmonth
                      //                                 .map(
                      //                                   (e) => DropdownMenuItem(
                      //                                       value: e.kodebulan,
                      //                                       child: Sz.subtitle(
                      //                                           context,
                      //                                           e.namabulan,
                      //                                           TextAlign
                      //                                               .center,
                      //                                           Palette
                      //                                               .blackClr)),
                      //                                 )
                      //                                 .toList(),
                      //
                      //                             onChanged: (val) {
                      //                               dsh.bulanStatus =
                      //                                   val.toString();
                      //                               dsh.getticketstatusmontly(
                      //                                   context);
                      //                             },
                      //                             // valueTransformer: (val) =>
                      //                             //     val?.toString(),
                      //                           ),
                      //                         ),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 ListView.builder(
                      //                     shrinkWrap: true,
                      //                     itemCount: dsh.collection.length,
                      //                     itemBuilder: (context, index) {
                      //                       return Container(
                      //                         margin: EdgeInsets.symmetric(
                      //                             horizontal: 15, vertical: 5),
                      //                         child: Row(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment
                      //                                   .spaceBetween,
                      //                           children: [
                      //                             Container(
                      //                               child: Row(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .center,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .center,
                      //                                 children: [
                      //                                   Icon(
                      //                                       size: 15,
                      //                                       Icons
                      //                                           .circle_rounded,
                      //                                       color: Switcher().ticket(
                      //                                           dsh.collection[
                      //                                                   index][
                      //                                               'domain'])),
                      //                                   SizedBox(width: 10),
                      //                                   Sz.subtitle(
                      //                                       context,
                      //                                       '${dsh.collection[index]['domain']}',
                      //                                       TextAlign.left,
                      //                                       Switcher().ticket(
                      //                                           dsh.collection[
                      //                                                   index][
                      //                                               'domain'])),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             Sz.subtitle(
                      //                                 context,
                      //                                 '${dsh.collection[index]['measure']}',
                      //                                 TextAlign.right,
                      //                                 Switcher().ticket(
                      //                                     dsh.collection[index]
                      //                                         ['domain'])),
                      //                           ],
                      //                         ),
                      //                       );
                      //                     }),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ))
                    ],
                  )),
                  SizedBox(width: Sz.hpfactor(context, 20)),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Sz.title(context, 'Top 5 Pengaduan', TextAlign.left,
                          Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Palette.bordercolor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          // padding: EdgeInsets.all(9),
                          // shrinkWrap: true,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Sz.title(context, 'Issue',
                                        TextAlign.left, Palette.primary2),
                                  ),
                                  // Expanded(
                                  //   child: Container(
                                  //     child: FormBuilderDropdown(
                                  //       name: 'issue',
                                  //       initialValue: initialDateval,
                                  //       elevation: 1,
                                  //       isDense: true,
                                  //       focusColor: Colors.transparent,
                                  //       decoration: InputDecoration(
                                  //         contentPadding:
                                  //             EdgeInsets.symmetric(vertical: 2),
                                  //         fillColor: Colors.white,
                                  //         hintText: 'Bulan',
                                  //         hintStyle: TextStyle(
                                  //           color: Palette.blackClr,
                                  //           fontSize: 12,
                                  //           fontFamily: SFProSemiBoldFnt,
                                  //         ),
                                  //         labelStyle: TextStyle(
                                  //           color: Palette.white,
                                  //           fontSize: 10,
                                  //           fontFamily: SFProSemiBoldFnt,
                                  //         ),
                                  //         enabledBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //             color: Colors.transparent,
                                  //             width: 0.0,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       items: dsh.listmonth
                                  //           .map(
                                  //             (e) => DropdownMenuItem(
                                  //                 value: e.kodebulan,
                                  //                 child: Sz.subtitle(
                                  //                     context,
                                  //                     e.namabulan,
                                  //                     TextAlign.center,
                                  //                     Palette.blackClr)),
                                  //           )
                                  //           .toList(),
                                  //
                                  //       onChanged: (val) {
                                  //         dsh.bulanStatus = val.toString();
                                  //       },
                                  //       // valueTransformer: (val) =>
                                  //       //     val?.toString(),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dsh.ticketissuemontly.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Sz.subtitle(
                                                  context,
                                                  '${dsh.ticketissuemontly[index].issue}',
                                                  TextAlign.left,
                                                  Palette.blackClr)),
                                          Expanded(
                                              flex: 5,
                                              child: ProgressLine(
                                                  percentage: int.parse(dsh
                                                      .ticketissuemontly[index]
                                                      .jumlah!))),
                                          Expanded(
                                              flex: 1,
                                              child: Sz.title(
                                                  context,
                                                  '${dsh.ticketissuemontly[index].jumlah}',
                                                  TextAlign.right,
                                                  Palette.blackClr)),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ))
                    ],
                  )),
                  SizedBox(width: Sz.hpfactor(context, 20)),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Sz.title(context, 'Sumber Aduan Terbanyak',
                          TextAlign.left, Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      // Expanded(
                      //     child: Container(
                      //   padding: EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Palette.bordercolor),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: ListView(
                      //     // padding: EdgeInsets.all(9),
                      //     shrinkWrap: true,
                      //     children: [
                      //       Container(
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             SizedBox(width: Sz.hpfactor(context, 8)),
                      //             Expanded(
                      //               child: Sz.title(context, 'Sumber',
                      //                   TextAlign.left, Palette.primary2),
                      //             ),
                      //             Expanded(
                      //               child: Container(
                      //                 child: FormBuilderDropdown(
                      //                   name: 'sumber',
                      //                   initialValue: initialDateval,
                      //                   elevation: 1,
                      //                   isDense: true,
                      //                   focusColor: Colors.transparent,
                      //                   decoration: InputDecoration(
                      //                     contentPadding:
                      //                         EdgeInsets.symmetric(vertical: 2),
                      //                     fillColor: Colors.white,
                      //                     hintText: 'Bulan',
                      //                     hintStyle: TextStyle(
                      //                       color: Palette.blackClr,
                      //                       fontSize: 12,
                      //                       fontFamily: SFProSemiBoldFnt,
                      //                     ),
                      //                     labelStyle: TextStyle(
                      //                       color: Palette.white,
                      //                       fontSize: 10,
                      //                       fontFamily: SFProSemiBoldFnt,
                      //                     ),
                      //                     enabledBorder: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                         color: Colors.transparent,
                      //                         width: 0.0,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   items: dsh.listmonth
                      //                       .map(
                      //                         (e) => DropdownMenuItem(
                      //                             value: e.kodebulan,
                      //                             child: Sz.subtitle(
                      //                                 context,
                      //                                 e.namabulan,
                      //                                 TextAlign.center,
                      //                                 Palette.blackClr)),
                      //                       )
                      //                       .toList(),
                      //
                      //                   onChanged: (val) {
                      //                     dsh.bulanStatus = val.toString();
                      //                   },
                      //                   // valueTransformer: (val) =>
                      //                   //     val?.toString(),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         child: ListView.builder(
                      //             shrinkWrap: true,
                      //             itemCount: dsh.ticketSourcemontly.length,
                      //             itemBuilder: (context, index) {
                      //               return Container(
                      //                 padding: EdgeInsets.all(10),
                      //                 child: Row(
                      //                   children: [
                      //                     Expanded(
                      //                         flex: 3,
                      //                         child: Sz.subtitle(
                      //                             context,
                      //                             '${dsh.ticketSourcemontly[index].issue}',
                      //                             TextAlign.left,
                      //                             Palette.blackClr)),
                      //                     Expanded(
                      //                         flex: 5,
                      //                         child: ProgressLine(
                      //                             percentage: int.parse(dsh
                      //                                 .ticketSourcemontly[index]
                      //                                 .jumlah!))),
                      //                     Expanded(
                      //                         flex: 1,
                      //                         child: Sz.title(
                      //                             context,
                      //                             '${dsh.ticketSourcemontly[index].jumlah}',
                      //                             TextAlign.right,
                      //                             Palette.blackClr)),
                      //                   ],
                      //                 ),
                      //               );
                      //             }),
                      //       ),
                      //     ],
                      //   ),
                      // ))
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: Sz.hpfactor(context, 20)),
            Sz.title(
                context, 'Tiket Hari ini', TextAlign.left, Palette.blackClr),
            SizedBox(height: Sz.hpfactor(context, 20)),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Sz.wpfactor(context, 270),
                        childAspectRatio: 0.54,
                        crossAxisSpacing: 200,
                        mainAxisSpacing: Sz.wpfactor(context, 25),
                      ),
                      shrinkWrap: true,

                      scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: Sz.wpfactor(context, 50)),
                      itemCount: dsh.ticketDaily.length == 0
                          ? 3
                          : dsh.ticketDaily.length,
                      itemBuilder: (context, index) {
                        // DailyTicket item = dsh.ticketDaily[index];
                        return dsh.ticketDaily.length == 0
                            ? CardDailyTicketEmpty(index: index)
                            : CardDailyTicket(
                                status: dsh.ticketDaily[index].status,
                                total: dsh.ticketDaily[index].jumlah,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Sz.hpfactor(context, 20)),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Sz.title(context, 'Status Pengaduan Bulan Berjalan',
                          TextAlign.left, Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      // Expanded(
                      //   child: Container(
                      //     padding: EdgeInsets.all(5),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(color: Palette.bordercolor),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Column(
                      //       children: [
                      //         Expanded(
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Container(
                      //                   padding: EdgeInsets.all(12),
                      //                   child: DChartBar(
                      //                     data: dsh.collectionTicketMontly,
                      //                     yAxisTitle: 'Jumlah',
                      //                     xAxisTitle: 'Status Tiket',
                      //                     // measureMin: 0,
                      //                     // measureMax: 8,
                      //                     minimumPaddingBetweenLabel: 1,
                      //                     domainLabelPaddingToAxisLine: 16,
                      //                     axisLineTick: 2,
                      //                     axisLinePointTick: 2,
                      //                     axisLinePointWidth: 10,
                      //                     axisLineColor: Colors.green,
                      //                     measureLabelPaddingToAxisLine: 16,
                      //                     barColor: (barData, index, id) =>
                      //                         Switcher().ticket(id),
                      //                     barValue: (barData, index) =>
                      //                         '${barData['measure']}',
                      //                     showBarValue: true,
                      //                     barValuePosition:
                      //                         BarValuePosition.outside,
                      //                     verticalDirection: true,
                      //                   ),
                      //                   // child: DChartBar(
                      //                   //   includeArea: true,
                      //                   //
                      //                   //   animate: true,
                      //                   //   includePoints: true,
                      //                   //   data: dsh.collectionTicketMontly,
                      //                   //
                      //                   //   lineColor: (lineData, index, id) {
                      //                   //     return Switcher()
                      //                   //         .ticketBerjalan(id);
                      //                   //   },
                      //                   //
                      //                   //   // areaColor: (){},
                      //                   //   // lineColor: (lineData, index, id) =>
                      //                   //   //     Colors.blueAccent,
                      //                   // ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  )),
                  SizedBox(width: Sz.hpfactor(context, 20)),
                  // Expanded(
                  //     child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(height: Sz.hpfactor(context, 10)),
                  //     Sz.title(context, 'Status Pengaduan tahun berjalan',
                  //         TextAlign.left, Palette.blackClr),
                  //     SizedBox(height: Sz.hpfactor(context, 10)),
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.all(5),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Palette.bordercolor),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Container(
                  //                 padding: EdgeInsets.all(12),
                  //                 child: DChartBar(
                  //                   data: dsh.collectionTicketMontlyAll,
                  //                   yAxisTitle: 'Jumlah',
                  //                   xAxisTitle: 'Status Tiket',
                  //                   // measureMin: 0,
                  //                   // measureMax: 8,
                  //                   minimumPaddingBetweenLabel: 1,
                  //                   domainLabelPaddingToAxisLine: 16,
                  //                   axisLineTick: 2,
                  //                   axisLinePointTick: 2,
                  //                   axisLinePointWidth: 10,
                  //                   axisLineColor: Colors.green,
                  //                   measureLabelPaddingToAxisLine: 16,
                  //                   barColor: (barData, index, id) =>
                  //                       Switcher().ticket(id),
                  //                   barValue: (barData, index) =>
                  //                       '${barData['measure']}',
                  //                   showBarValue: true,
                  //                   barValuePosition: BarValuePosition.outside,
                  //                   verticalDirection: true,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDailyTicket extends StatelessWidget {
  final status;
  final total;

  const CardDailyTicket({
    super.key,
    required this.status,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.bordercolor),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: Switcher().ticket(status),
                      radius: 50,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Palette.white,
                        child: Center(
                          child: Sz.headline4(context, '${total}',
                              TextAlign.center, Switcher().ticket(status)),
                        ),
                      )),
                  SizedBox(width: Sz.hpfactor(context, 25)),
                  Sz.headline(context, '${status}', TextAlign.center,
                      Switcher().ticket(status)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardDailyTicketEmpty extends StatelessWidget {
  final index;

  CardDailyTicketEmpty({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.bordercolor),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: Palette.labelClr,
                      radius: 50,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Palette.white,
                        child: Center(
                          child: Sz.headline4(
                              context, '0', TextAlign.center, Palette.labelClr),
                        ),
                      )),
                  SizedBox(width: Sz.hpfactor(context, 25)),
                  Sz.headline(
                    context,
                    Switcher().labelStatus(context, index),
                    TextAlign.center,
                    Palette.labelClr,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
