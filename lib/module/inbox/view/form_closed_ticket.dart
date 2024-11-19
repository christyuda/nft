import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/inbox/provider/inbox_provider.dart';
import 'package:webordernft/module/inbox/service/model/ticket_pagination.dart';

import '../../../common/provider/general_provider.dart';
import '../../../common/utils/date_indonesia.dart';
import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../../../config/sizeconf.dart';
import '../../ticket/service/model/tindakan.dart';

class FormClosedTicket extends StatefulWidget {
  final DatumTicket dataTicket;

  FormClosedTicket({required this.dataTicket});

  @override
  State<FormClosedTicket> createState() => _FormClosedTicketState();
}

class _FormClosedTicketState extends State<FormClosedTicket> {
  final _formKeyClosedTicket = GlobalKey<FormBuilderState>();
  List _listTindakan = [
    Tindakan(id: 2, namatindakan: 'Diteruskan'),
    Tindakan(id: 9, namatindakan: 'Selesai'),
    Tindakan(id: -1, namatindakan: 'Batalkan'),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<InboxProvider>(
      builder: (context, tkt, _) => Card(
          elevation: 1.5,
          child: FormBuilder(
            key: _formKeyClosedTicket,
            child: Container(
              padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Sz.headline5(
                      context,
                      'Tiket Pengaduan : ${widget.dataTicket.ticketId}',
                      TextAlign.left,
                      Palette.blackClr),
                  SizedBox(height: Sz.hpfactor(context, 20)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Nama Pelanggan',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 200),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${widget.dataTicket.customerName}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'No Handphone',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 200),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${widget.dataTicket.mobilePhone}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Kategori Aduan',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 300),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${widget.dataTicket.kategori}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Masalah', TextAlign.left,
                              Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Sz.title(
                                      context,
                                      '${widget.dataTicket.keterangan}',
                                      TextAlign.left,
                                      Palette.blackClr),
                                ),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Status', TextAlign.left,
                              Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 200),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${widget.dataTicket.statusname}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Tanggal Ticket',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 200),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${FormatDateINA.convertdateINA(widget.dataTicket.createdAt.toString())}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(
                              context, 'SLA', TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 80),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Sz.title(
                                    context,
                                    '${widget.dataTicket.sla}',
                                    TextAlign.left,
                                    Palette.blackClr),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Solusi *', TextAlign.left,
                              Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: FormBuilderTextField(
                              // autovalidateMode: AutovalidateMode.always,
                              maxLines: 3,
                              name: 'solusi',
                              maxLength: 800,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Deskripsi Tidak boleh Kosong'),
                              ]),
                              decoration: InputDecoration(
                                counterText: '',
                                // suffixIcon: _ageHasError
                                //     ? const Icon(Icons.error, color: Colors.red)
                                //     : const Icon(Icons.check, color: Colors.green),
                                labelStyle: TextStyle(
                                    color: Palette.white,
                                    fontSize: titleSz,
                                    fontFamily: sfProFnt),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.primary,
                                      width: 1.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(radiusVal)),
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
                              onChanged: (val) {
                                tkt.solusi = val as String;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Kompensasi', TextAlign.left,
                              Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: FormBuilderTextField(
                              // autovalidateMode: AutovalidateMode.always,
                              maxLines: 3,
                              name: 'kompensasi',
                              maxLength: 800,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Deskripsi Tidak boleh Kosong'),
                              ]),
                              decoration: InputDecoration(
                                counterText: '',
                                // suffixIcon: _ageHasError
                                //     ? const Icon(Icons.error, color: Colors.red)
                                //     : const Icon(Icons.check, color: Colors.green),
                                labelStyle: TextStyle(
                                    color: Palette.white,
                                    fontSize: titleSz,
                                    fontFamily: sfProFnt),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.primary,
                                      width: 1.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(radiusVal)),
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
                              onChanged: (val) {
                                tkt.kompensasi = val as String;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 20)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Action / Tindakan',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: FormBuilderDropdown(
                              // key: _dropDownKeySA,
                              name: 'tindakan',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText:
                                        'Tindakan / Action  Tidak boleh Kosong'),
                              ]),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Pilih Tindakan',
                                labelStyle: TextStyle(
                                    color: Palette.white,
                                    fontSize: titleSz,
                                    fontFamily: sfProFnt),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Palette.primary,
                                      width: 1.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(radiusVal)),
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
                              onChanged: (val) {
                                tkt.tindakanInbx = val as int;
                                tkt.isDisableInbox = false;
                              },
                              items: _listTindakan
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.namatindakan ?? ''),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 20)),
                  Container(
                    margin: EdgeInsets.only(right: Sz.hpfactor(context, 5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: tkt.isDisableInbox == true
                              ? null
                              : () {
                                  if (_formKeyClosedTicket.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    Navigator.pop(context);
                                    Provider.of<GeneralProv>(context,
                                            listen: false)
                                        .isLoading();
                                    tkt.submitTicket(
                                        context, widget.dataTicket);
                                  } else {
                                    debugPrint(_formKeyClosedTicket
                                        .currentState?.value
                                        .toString());
                                    debugPrint('validation failed');
                                  }
                                },
                          child: Sz.buttonText(
                            context,
                            'SUBMIT',
                            TextAlign.center,
                            Palette.white,
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                tkt.isDisableInbox == true
                                    ? Palette.labelClr
                                    : Palette.primary2,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(radiusVal),
                                ),
                              )),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            tkt.isDisableInbox = true;
                            _formKeyClosedTicket.currentState!.reset();

                            Navigator.pop(context);
                          },
                          child: Sz.buttonText(
                            context,
                            'Batal',
                            TextAlign.center,
                            Palette.blackClr,
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(radiusVal),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
