import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/inbox/provider/inbox_provider.dart';

import '../../../common/provider/general_provider.dart';
import '../../../common/utils/date_indonesia.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import 'form_closed_ticket.dart';

class ForminboxTicket extends StatefulWidget {
  const ForminboxTicket({Key? key}) : super(key: key);

  @override
  State<ForminboxTicket> createState() => _ForminboxTicketState();
}

class _ForminboxTicketState extends State<ForminboxTicket> {
  final _keyInbox = GlobalKey<FormBuilderState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<InboxProvider>(context, listen: false).initFormInbox(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InboxProvider>(
        builder: (context, inbx, _) => Card(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sz.headline5(context, 'Inbox Ticket', TextAlign.left,
                          Palette.blackClr),
                      SizedBox(height: Sz.hpfactor(context, 10)),
                      Row(
                        children: [
                          FormBuilder(
                            key: _keyInbox,
                            child: Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: Sz.hpfactor(context, 200),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(radiusVal),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) {
                                        inbx.ticketID = val;
                                      },
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Palette.bgtexfield,
                                            fontSize: 12.0,
                                            fontFamily: 'Poppins'),
                                        hintText: 'ID Ticket',
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.bordercolor,
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 2.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: Sz.hpfactor(context, 200),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FormBuilderDropdown(
                                      name: 'Status',
                                      decoration: InputDecoration(
                                        // labelText: 'Kategori TIcket',
                                        fillColor: Colors.white,
                                        hintText: 'Pilih Status Ticket',
                                        labelStyle: TextStyle(
                                            color: Palette.white,
                                            fontSize: titleSz,
                                            fontFamily: sfProFnt),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.primary,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                radiusVal)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.bordercolor,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                          borderSide: BorderSide(
                                            color: Palette.errorColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: '1',
                                          child: Text('Open'),
                                        ),
                                        DropdownMenuItem(
                                          value: '3',
                                          child: Text('Inprogress'),
                                        ),
                                        DropdownMenuItem(
                                          value: '9',
                                          child: Text('Completed'),
                                        ),
                                      ],

                                      onChanged: (val) {
                                        inbx.statusTicket = val!;
                                      },
                                      // valueTransformer: (val) =>
                                      //     val?.toString(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: Sz.wpfactor(context, 49),
                                    width: Sz.hpfactor(context, 100),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_keyInbox.currentState!
                                            .validate()) {
                                          _keyInbox.currentState!.save();
                                          Provider.of<GeneralProv>(context,
                                                  listen: false)
                                              .isLoading();
                                          Provider.of<InboxProvider>(context,
                                                  listen: false)
                                              .page = 1;
                                          Provider.of<InboxProvider>(context,
                                                  listen: false)
                                              .getlistTicket(context);
                                        }
                                      },
                                      child: Sz.buttonText(
                                        context,
                                        'Filter',
                                        TextAlign.center,
                                        Palette.white,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Palette.primary,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radiusVal),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    // color: Colors.white,
                                    height: Sz.wpfactor(context, 49),
                                    width: Sz.hpfactor(context, 100),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _keyInbox.currentState!.reset();
                                        inbx.clearFilter();
                                      },
                                      child: Sz.buttonText(
                                        context,
                                        'Reset',
                                        TextAlign.center,
                                        Palette.blackClr,
                                      ),
                                      style: ButtonStyle(
                                          // backgroundColor:
                                          //     MaterialStateProperty.all<Color>(
                                          //         Colors.white),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(radiusVal),
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(top: 15),
                                child: DataTable2(
                                    columnSpacing: 12,
                                    headingRowHeight: 30,
                                    horizontalMargin: 12,
                                    minWidth: 600,
                                    headingRowColor:
                                        MaterialStateProperty.all<Color>(
                                      Palette.primary3,
                                    ),
                                    columns: [
                                      DataColumn2(
                                        label: Sz.headline(context, 'No',
                                            TextAlign.left, Palette.white),
                                        fixedWidth: 35,
                                      ),
                                      DataColumn2(
                                        // fixedWidth: 78,
                                        label: Sz.headline(context, 'Tanggal',
                                            TextAlign.left, Palette.white),
                                        size: ColumnSize.S,
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.L,
                                        label: Sz.headline(context, 'Kategori',
                                            TextAlign.left, Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.L,
                                        label: Sz.headline(
                                            context,
                                            'Nama Pelanggan',
                                            TextAlign.left,
                                            Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.M,
                                        label: Sz.headline(
                                            context,
                                            'No Handphone',
                                            TextAlign.left,
                                            Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.L,
                                        label: Sz.headline(
                                            context,
                                            'Keterangan',
                                            TextAlign.left,
                                            Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.M,
                                        label: Sz.headline(context, 'Tiket ID',
                                            TextAlign.left, Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.M,
                                        label: Sz.headline(context, 'Status',
                                            TextAlign.left, Palette.white),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.M,
                                        label: Sz.headline(context, 'Action',
                                            TextAlign.left, Palette.white),
                                      ),
                                    ],
                                    rows: inbx.listInbox.map((e) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Sz.subtitle(context, e.rownum,
                                              TextAlign.left, Palette.blackClr),
                                        ),
                                        DataCell(
                                          Sz.subtitle(
                                              context,
                                              '${FormatDateINA.convertdateINA(e.createdAt.toString())}',
                                              TextAlign.left,
                                              Palette.blackClr),
                                        ),
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<GeneralProv>(context,
                                                      listen: false)
                                                  .instantSendMessage(
                                                      'User profile Segera hadir, sedang dalam tahap pengembangan');
                                            },
                                            child: Container(
                                              child: Sz.title(
                                                  context,
                                                  '${e.kategori}',
                                                  TextAlign.left,
                                                  Palette.primary2),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Sz.subtitle(
                                              context,
                                              '${e.customerName}',
                                              TextAlign.left,
                                              Palette.blackClr),
                                        ),
                                        DataCell(
                                          Sz.subtitle(context, e.mobilePhone,
                                              TextAlign.left, Palette.blackClr),
                                        ),
                                        DataCell(
                                          Sz.subtitle(
                                            context,
                                            e.keterangan,
                                            TextAlign.center,
                                            Palette.blackClr,
                                          ),
                                        ),
                                        DataCell(
                                          Sz.subtitle(
                                            context,
                                            e.ticketId,
                                            TextAlign.center,
                                            Palette.blackClr,
                                          ),
                                        ),
                                        DataCell(Container(
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radiusVal),
                                              border: Border.all(
                                                color: e.statusId == 1
                                                    ? Palette.successColor
                                                    : Palette.openClr,
                                              )),
                                          child: Sz.subtitle(
                                            context,
                                            e.statusname!.toUpperCase(),
                                            TextAlign.center,
                                            Palette.blackClr,
                                          ),
                                        )),
                                        e.statusId == 9 || e.statusId == -1
                                            ? DataCell(Container())
                                            : DataCell(e.statusId == 1
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      confirmAmbilTiket(
                                                          context, e);
                                                    },
                                                    child: Sz.subtitle(
                                                      context,
                                                      'Ambil Ticket',
                                                      TextAlign.center,
                                                      Palette.white,
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Palette.cancelClr,
                                                        ),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        radiusVal),
                                                          ),
                                                        )),
                                                  )
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      prosesTiket(context, e);
                                                    },
                                                    child: Sz.subtitle(
                                                      context,
                                                      'Close tiket',
                                                      TextAlign.center,
                                                      Palette.white,
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Palette.cancelClr,
                                                        ),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        radiusVal),
                                                          ),
                                                        )),
                                                  )),
                                      ]);
                                    }).toList()),
                              ),
                            )
                          ],
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
                                        'Showing ${inbx.fromRow} to ${inbx.toRow} of ${inbx.totalRow} entries',
                                        TextAlign.start,
                                        Palette.primary)),
                                Expanded(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.skip_previous_rounded),
                                        onPressed: () {
                                          inbx.nextPage(context, 'previous');
                                        },
                                        color: Palette.primary),
                                    Sz.caption(
                                        context,
                                        'Page : ${inbx.currentPage} / ${inbx.lastPage}',
                                        TextAlign.center,
                                        Palette.primary),
                                    IconButton(
                                      icon: Icon(Icons.skip_next_rounded),
                                      onPressed: () {
                                        inbx.nextPage(context, 'next');
                                      },
                                      color: Palette.primary,
                                    )
                                  ],
                                ))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  confirmAmbilTiket(context, e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Sz.headline5(
                context,
                'Konfirmasi',
                TextAlign.left,
                Palette.blackClr,
              ),
              SizedBox(height: Sz.wpfactor(context, 25)),
              Sz.title(
                  context,
                  'Ambil Tiket ini ${e.ticketId} dari ${e.customerName} ?',
                  TextAlign.left,
                  Palette.textClr),
              SizedBox(height: Sz.wpfactor(context, 20)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<GeneralProv>(context, listen: false)
                    .instantSendMessage(
                        'Proses Pengambilan tiket.. harap menunggu');
                Provider.of<InboxProvider>(context, listen: false)
                    .ambilTiket(context, e);
                Timer(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              },
              child: Sz.buttonText(
                context,
                'Ya, Ambil',
                TextAlign.center,
                Palette.white,
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Palette.primary,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Sz.buttonText(
                context,
                'Batal',
                TextAlign.center,
                Palette.blackClr,
              ),
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(
                  //   Palette.whiteClr,
                  // ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: BorderSide(
                  //     color: Palette.primary, width: 1.0),
                ),
              )),
            ),
          ],
        );
      },

      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20),
      //   ),
      // ),
    );
  }

  prosesTiket(context, e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
              height: Sz.hpfactor(context, 650),
              width: Sz.wpfactor(context, 900),
              child: FormClosedTicket(dataTicket: e)),
        );
      },

      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20),
      //   ),
      // ),
    );
  }
}
