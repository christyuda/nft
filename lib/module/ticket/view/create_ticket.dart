import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/ticket/provider/ticket_provider.dart';

import '../../../config/constant.dart';
import '../../../config/palette.dart';
import '../service/model/list_kategori.dart';
import '../service/model/list_sumber_aduan.dart';
import '../service/model/tindakan.dart';

class FormCreateTicket extends StatefulWidget {
  const FormCreateTicket({Key? key}) : super(key: key);

  @override
  State<FormCreateTicket> createState() => _FormCreateTicketState();
}

class _FormCreateTicketState extends State<FormCreateTicket> {
  String defaultValue = '-';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TicketProvider>(context, listen: false)
        .getListKategori(context);
    Provider.of<TicketProvider>(context, listen: false)
        .getListSumberAduan(context);

    Timer(Duration(seconds: 1), () {
      Provider.of<TicketProvider>(context, listen: false).clearMsg();
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: DataInputAduan(),
          ),
          SizedBox(width: Sz.hpfactor(context, 10)),
          Expanded(
              flex: 1,
              child: Consumer<TicketProvider>(
                builder: (context, ch, _) => Card(
                  elevation: 1.5,
                  child: ch.datapassport == null || ch.isDisable == true
                      ? Column(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding:
                                      EdgeInsets.all(Sz.hpfactor(context, 20)),
                                  child: Sz.headline5(context, 'Data Pengguna',
                                      TextAlign.left, Palette.blackClr),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ch.isDisable == true
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.all(
                                          Sz.hpfactor(context, 20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Sz.headline5(context, 'Data Pengguna',
                                              TextAlign.left, Palette.blackClr),
                                          SizedBox(
                                              height: Sz.hpfactor(context, 20)),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Nama',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                Sz.subtitle(
                                                    context,
                                                    '${ch.datapassport!.data!.fullName ?? ''}',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'No Passport',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                Sz.subtitle(
                                                    context,
                                                    '${ch.datapassport!.data!.passportId}XXXX',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Jenis Akun',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                Sz.subtitle(
                                                    context,
                                                    '${ch.datapassport!.data!.userKindName}',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'No Handphone',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                Sz.subtitle(
                                                    context,
                                                    '${ch.datapassport!.data!.identityNumber}',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Jenis Kelamin',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                // Sz.subtitle(context, 'Laki-laki',
                                                //     TextAlign.left, Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Pekerjaan',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                // Sz.subtitle(context, '-',
                                                //     TextAlign.left, Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Negara',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                Sz.subtitle(
                                                    context,
                                                    '${ch.datapassport!.data!.countryName}',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Sz.title(
                                                    context,
                                                    'Distrik',
                                                    TextAlign.left,
                                                    Palette.blackClr),
                                                // Sz.subtitle(context, 'Tai-san',
                                                //     TextAlign.left, Palette.blackClr),
                                                SizedBox(
                                                    height: Sz.hpfactor(
                                                        context, 15)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
              ))
        ],
      ),
    );
  }
}

class DataInputAduan extends StatelessWidget {
  DataInputAduan({super.key});

  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  final _dropDownKeySA = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  List _listTindakan = [
    Tindakan(id: 1, namatindakan: 'Diteruskan'),
    Tindakan(id: 9, namatindakan: 'Selesai'),
  ];

  var completeColor = Color(0xff5e6172);
  var inProgressColor = Color(0xff5ec792);
  var todoColor = Color(0xffd1d2d7);

  int _processIndex = 2;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(
      builder: (context, ch, _) => Card(
          elevation: 1.5,
          child: FormBuilder(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(Sz.hpfactor(context, 20)),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Sz.headline5(context, 'Tiket Pengaduan', TextAlign.left,
                      Palette.blackClr),
                  SizedBox(height: Sz.hpfactor(context, 20)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Nomor Identitas',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Container(
                                width: Sz.hpfactor(context, 200),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: FormBuilderTextField(
                                  autovalidateMode: AutovalidateMode.always,
                                  maxLength: 15,
                                  name: 'nohandphone',
                                  decoration: InputDecoration(
                                    // suffixIcon: const Icon(Icons.error,
                                    //     color: Colors.red),
                                    counterText: '',
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
                                        color: Palette.primary,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    Provider.of<TicketProvider>(context,
                                            listen: false)
                                        .notelpassport = val;
                                  },
                                  // valueTransformer: (text) => num.tryParse(text),
                                  // validator: FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(),
                                  //   FormBuilderValidators.numeric(),
                                  //   FormBuilderValidators.max(70),
                                  // ]),
                                  // initialValue: '12',
                                  // keyboardType: TextInputType.text,
                                  // textInputAction: TextInputAction.next,
                                ),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<GeneralProv>(context,
                                          listen: false)
                                      .isLoading();
                                  Provider.of<TicketProvider>(context,
                                          listen: false)
                                      .clearMsg();
                                  Provider.of<TicketProvider>(context,
                                          listen: false)
                                      .validasiNotelPassport(context);
                                },
                                child: Sz.buttonText(
                                  context,
                                  'Cek',
                                  TextAlign.center,
                                  Palette.white,
                                ),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(25)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Palette.primary2,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(radiusVal),
                                      ),
                                    )),
                              ),
                              SizedBox(width: Sz.hpfactor(context, 10)),
                              ch.isValid == true
                                  ? Container()
                                  : Sz.title(context, ch.errormessage,
                                      TextAlign.left, Palette.labelClr)
                            ],
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
                          child: Sz.title(context, 'Kategori', TextAlign.left,
                              Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: FormBuilderDropdown(
                              name: 'Kategori',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Kategori Tidak boleh Kosong'),
                              ]),
                              decoration: InputDecoration(
                                // labelText: 'Kategori TIcket',
                                fillColor: Colors.white,
                                hintText: 'Pilih Kategori',
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
                              items: ch.listkategori == null
                                  ? []
                                  : ch.listkategori!
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Text(
                                              e.name == null ? '' : e.name!),
                                        ),
                                      )
                                      .toList(),

                              onChanged: (val) {
                                Provider.of<TicketProvider>(context,
                                        listen: false)
                                    .listNodes!
                                    .clear();
                                _dropDownKey.currentState!.reset();
                                _dropDownKey.currentState!.setValue(null);
                                Provider.of<TicketProvider>(context,
                                        listen: false)
                                    .getSubkategori(context, val);
                                ch.kategoriId = val as int;
                              },
                              // valueTransformer: (val) =>
                              //     val?.toString(),
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
                          child: Sz.title(context, 'Sub Kategori',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: FormBuilderDropdown(
                                key: _dropDownKey,
                                name: 'sub kategori',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          'sub Kategori Tidak boleh Kosong'),
                                ]),
                                decoration: InputDecoration(
                                  // labelText: 'Kategori TIcket',
                                  fillColor: Colors.white,
                                  hintText: 'Pilih sub Kategori',
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
                                  Provider.of<TicketProvider>(context,
                                          listen: false)
                                      .listNodes!
                                      .clear();
                                  Provider.of<TicketProvider>(context,
                                          listen: false)
                                      .subkategori = val as int;

                                  Provider.of<TicketProvider>(context,
                                          listen: false)
                                      .getWorkflowNode(context);
                                },
                                items: Provider.of<TicketProvider>(context,
                                                listen: true)
                                            .listSubkategori ==
                                        null
                                    ? [
                                        DropdownMenuItem(
                                          value: 99,
                                          child: Text(''),
                                        )
                                      ]
                                    : Provider.of<TicketProvider>(context,
                                            listen: true)
                                        .listSubkategori!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id == null
                                                ? List<ListKategori>
                                                : e.id,
                                            child: Text(e.name ?? ''),
                                          ),
                                        )
                                        .toList()),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Sz.hpfactor(context, 15)),
                  ch.listNodes!.length > 0
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Sz.title(context, 'Alur Kerja ( Workflow )',
                                  TextAlign.left, Palette.blackClr),
                              SizedBox(height: Sz.hpfactor(context, 10)),
                              Container(
                                height: 100,
                                child: Timeline.tileBuilder(
                                  theme: TimelineThemeData(
                                    direction: Axis.horizontal,
                                    connectorTheme: ConnectorThemeData(
                                      space: 35.0,
                                      thickness: 5.0,
                                      color: Palette.primary2,
                                    ),
                                  ),
                                  builder: TimelineTileBuilder.fromStyle(
                                    contentsAlign: ContentsAlign.basic,
                                    contentsBuilder: (context, index) =>
                                        Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Sz.hpfactor(context, 20)),
                                      child: TimelineNode(
                                        direction: Axis.horizontal,
                                        indicator: Card(
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Sz.caption(
                                              context,
                                              '${ch.listNodes![index].rolename}',
                                              TextAlign.center,
                                              Palette.blackClr,
                                            ),
                                          ),
                                        ),
                                        startConnector: DashedLineConnector(),
                                        endConnector: SolidLineConnector(),
                                      ),
                                    ),
                                    itemCount: ch.listNodes!.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: Sz.hpfactor(context, 20)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Sumber Aduan',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: FormBuilderDropdown(
                              key: _dropDownKeySA,
                              name: 'sumberaduan',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText:
                                        'sumber aduan Tidak boleh Kosong'),
                              ]),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Pilih Sumber Aduan',
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
                                ch.sumberaduanId = val as int;
                              },
                              items: ch.listsumberaduan!
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id == null
                                          ? List<ListSumberAduan>
                                          : e.id,
                                      child: Text(e.sumber ?? ''),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Sz.title(context, 'Deskripsi *',
                              TextAlign.left, Palette.blackClr),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: FormBuilderTextField(
                              // autovalidateMode: AutovalidateMode.always,
                              maxLines: 3,
                              name: 'Deskripsi',
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
                                ch.deskripsiAduan = val as String;
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
                                borderRadius: BorderRadius.circular(10)),
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
                                ch.tindakan = val as int;
                                ch.isDisable = false;
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
                          onPressed: ch.isDisable == true
                              ? null
                              : () {
                                  if (_formKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    Provider.of<GeneralProv>(context,
                                            listen: false)
                                        .isLoading();
                                    ch.submitTicket(context, _formKey);
                                  } else {
                                    debugPrint(_formKey.currentState?.value
                                        .toString());
                                    debugPrint('validation failed');
                                  }
                                },
                          child: Sz.buttonText(
                            context,
                            'SUBMIT TIKET',
                            TextAlign.center,
                            Palette.white,
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                ch.isDisable == true
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
                            _formKey.currentState!.reset();
                            ch.isDisable = true;
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
