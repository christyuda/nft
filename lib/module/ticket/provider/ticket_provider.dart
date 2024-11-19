import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/common/provider/general_provider.dart';

import '../service/model/list_kategori.dart';
import '../service/model/list_sumber_aduan.dart';
import '../service/model/pin_cek_pasport.dart';
import '../service/model/pin_create_ticket.dart';
import '../service/model/pin_getnodes.dart';
import '../service/model/response_cek_pasport.dart';
import '../service/model/response_create_ticket.dart';
import '../service/model/response_getnode.dart';
import '../service/ticket_service.dart';

class TicketProvider with ChangeNotifier {
  List<ListKategori> _listSubkategori = [ListKategori()];
  List<ListKategori> _listkategori = [ListKategori()];
  List<ListSumberAduan> _listsumberaduan = [];
  List<Node> _listNodes = [];

  String? _notelpassport;
  String? _custName;
  String? _deskripsiAduan;
  String? _errormessage;
  int? _kategoriId;
  int? _subkategori;
  int? _sumberaduanId;
  int? _workflowid;
  int? _tindakan;

  ResponseCheckPasport? _datapassport;
  bool? _isDisable = true;
  bool? _isValid = true;

  //getter

  List<ListKategori>? get listkategori => _listkategori;
  List<ListKategori>? get listSubkategori => _listSubkategori;
  List<ListSumberAduan>? get listsumberaduan => _listsumberaduan;
  List<Node>? get listNodes => _listNodes;

  int? get subkategori => _subkategori;
  int? get kategoriId => _kategoriId;
  int? get sumberaduanId => _sumberaduanId;
  int? get workflowid => _workflowid;
  int? get tindakan => _tindakan;
  String? get notelpassport => _notelpassport;
  String? get deskripsiAduan => _deskripsiAduan;
  String? get custName => _custName;
  String? get errormessage => _errormessage;
  bool? get isDisable => _isDisable;
  bool? get isValid => _isValid;

  ResponseCheckPasport? get datapassport => _datapassport;

  //setter

  set tindakan(int? val) {
    _tindakan = val!;
    notifyListeners();
  }

  set custName(String? val) {
    _custName = val!;
    notifyListeners();
  }

  set errormessage(String? val) {
    _errormessage = val!;
    notifyListeners();
  }

  set deskripsiAduan(String? val) {
    _deskripsiAduan = val!;
    notifyListeners();
  }

  set workflowid(int? val) {
    _workflowid = val!;
    notifyListeners();
  }

  set sumberaduanId(int? val) {
    _sumberaduanId = val!;
    notifyListeners();
  }

  set kategoriId(int? val) {
    _kategoriId = val!;
    notifyListeners();
  }

  set listsumberaduan(List<ListSumberAduan>? val) {
    _listsumberaduan = val!;
    notifyListeners();
  }

  set datapassport(ResponseCheckPasport? val) {
    _datapassport = val!;
    notifyListeners();
  }

  set isDisable(bool? val) {
    _isDisable = val!;
    notifyListeners();
  }

  set isValid(bool? val) {
    _isValid = val!;
    notifyListeners();
  }

  set notelpassport(String? val) {
    _notelpassport = val!;
    notifyListeners();
  }

  set subkategori(int? val) {
    _subkategori = val!;
    notifyListeners();
  }

  set listkategori(List<ListKategori>? val) {
    _listkategori = val!;
    notifyListeners();
  }

  set listSubkategori(List<ListKategori>? val) {
    _listSubkategori = val!;
    notifyListeners();
  }

  set listNodes(List<Node>? val) {
    _listNodes = val!;
    notifyListeners();
  }

  //function

  submitTicket(context, _formkey) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userid = prefs.getInt('userid');

    PinCreateTicket _pin = PinCreateTicket(
      workflowid: workflowid!.toString(),
      categoryid: kategoriId.toString(),
      subcategoryid: subkategori.toString(),
      mobilephone: notelpassport,
      customername: custName,
      srccomplaintid: sumberaduanId,
      keterangan: deskripsiAduan,
      tindakan: tindakan,
      userid: userid,
      customerid: datapassport!.data!.userId,
    );
    ResponseCreateTicket result =
        await TicketService.submitCreateTicket(context, _pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      isDisable = true;
      _formkey.currentState.reset();
    } else {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  validasiNotelPassport(context) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    PinCheckPasport _pin = PinCheckPasport(
      passportId: notelpassport,
    );
    ResponseCheckPasport result =
        await TicketService.validasiPassport(context, _pin);

    if (result.code == '000') {
      genprov.dissmisLoading();
      isDisable = false;
      isValid = result.status;
      datapassport = result;
      custName = result.data!.fullName;
      notifyListeners();
    } else {
      genprov.dissmisLoading();
      isDisable = true;
      datapassport = null;
      isValid = result.status;
      errormessage = result.message!;
      notifyListeners();
    }
  }

  getListSumberAduan(context) async {
    List<ListSumberAduan> _sumberaduan =
        await TicketService.getSumberAduan(context);
    listsumberaduan = _sumberaduan;
    notifyListeners();
  }

  getListKategori(context) async {
    // Future<List<ListKategori>> getListKategori(context) async {
    List<ListKategori> _kategori = await TicketService.getListKategori(context);
    listkategori = _kategori;
    notifyListeners();
    // return _kategori;
  }

  getSubkategori(context, parentId) async {
    List<ListKategori>? _kategori =
        await TicketService.getListSubKategori(context, parentId);

    listSubkategori = _kategori;
    notifyListeners();
  }

  getWorkflowNode(context) async {
    PinGetNodes _params = PinGetNodes(subkategoriId: subkategori);

    ResponseGetNodes _result =
        await TicketService.getWorkflowNode(context, _params);

    workflowid = _result.data!.wokflowid;
    listNodes = _result.data!.nodes!;
    notifyListeners();
  }

  clearMsg() {
    errormessage = '';
    notifyListeners();
  }
}
