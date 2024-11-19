import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/common/widget/general_response.dart';
import 'package:webordernft/module/inbox/service/inbox_service.dart';

import '../../../common/provider/general_provider.dart';
import '../service/model/pin_ambil_ticket.dart';
import '../service/model/pin_search_inbox.dart';
import '../service/model/pin_submit_tiket.dart';
import '../service/model/ticket_pagination.dart';

class InboxProvider with ChangeNotifier {
  List<DatumTicket> _listInbox = [];

  //paging
  int? _page = 1;
  int? _lastPage = 0;
  int? _totalRow = 0;
  int? _fromRow = 0;
  int? _toRow = 0;
  int? _currentPage = 0;
  int? _tindakanInbx = 0;

  String? _statusTicket = '1';
  String? _ticketID = '';
  String? _userid = '';
  String? _solusi = '';
  String? _kompensasi = '';

  bool? _isDisableInbox = true;

  //getter
  List<DatumTicket> get listInbox => _listInbox;

  //paging
  int? get page => _page;
  int? get lastPage => _lastPage;
  int? get totalRow => _totalRow;
  int? get fromRow => _fromRow;
  int? get toRow => _toRow;
  int? get currentPage => _currentPage;
  int? get tindakanInbx => _tindakanInbx;

  String? get statusTicket => _statusTicket;
  String? get ticketID => _ticketID;
  String? get userid => _userid;
  String? get solusi => _solusi;
  String? get kompensasi => _kompensasi;

  bool? get isDisableInbox => _isDisableInbox;

  //setter

  set listInbox(List<DatumTicket> val) {
    _listInbox = val;
    notifyListeners();
  }

  set currentPage(int? val) {
    _currentPage = val!;
    notifyListeners();
  }

  set isDisableInbox(bool? val) {
    _isDisableInbox = val!;
    notifyListeners();
  }

  set statusTicket(String? val) {
    _statusTicket = val!;
    notifyListeners();
  }

  set kompensasi(String? val) {
    _kompensasi = val!;
    notifyListeners();
  }

  set solusi(String? val) {
    _solusi = val!;
    notifyListeners();
  }

  set userid(String? val) {
    _userid = val!;
    notifyListeners();
  }

  set toRow(int? val) {
    _toRow = val!;
    notifyListeners();
  }

  set fromRow(int? val) {
    _fromRow = val!;
    notifyListeners();
  }

  set totalRow(int? val) {
    _totalRow = val!;
    notifyListeners();
  }

  set page(int? val) {
    _page = val!;
    notifyListeners();
  }

  set lastPage(int? val) {
    _lastPage = val!;
    notifyListeners();
  }

  set tindakanInbx(int? val) {
    _tindakanInbx = val!;
    notifyListeners();
  }

  set ticketID(String? val) {
    _ticketID = val!;
    notifyListeners();
  }

  initFormInbox(context) {
    // statusTicket = '1';
    getlistTicket(context);
  }

  getlistTicket(context) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? roleid = prefs.getInt('roleid');
    final int? uid = prefs.getInt('userid');

    if (statusTicket != 1) {
      userid = uid.toString();
    } else {
      userid = '';
    }

    PinSearchInbox pin = PinSearchInbox(
      roleid: "${roleid}",
      bulan: "",
      status: statusTicket,
      uid: userid,
      ticketid: ticketID,
    );

    TicketPagination _result = await InboxService.getInbox(context, page, pin);
    List<DatumTicket>? _inbox = _result.data!.data;
    listInbox = _inbox!;
    if (_inbox.length > 0) {
      lastPage = _result.data!.lastPage;
      totalRow = _result.data!.total;
      fromRow = _result.data!.from;
      toRow = _result.data!.to;
      currentPage = _result.data!.currentPage;
    }

    notifyListeners();
    genprov.dissmisLoading();
  }

  nextPage(context, String action) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    genprov.isLoading();
    if (action == 'previous') {
      page = (currentPage! - 1);
      notifyListeners();
    }
    if (action == 'next') {
      page = (currentPage! + 1) > num.parse(lastPage.toString())
          ? lastPage
          : (currentPage! + 1);
      notifyListeners();
    }
    getlistTicket(context);
  }

  void ambilTiket(context, DatumTicket e) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? userid = prefs.getInt('userid');
    PinAmbilTiket _pin = PinAmbilTiket(
      userid: userid.toString(),
      ticketid: e.ticketId.toString(),
      tickedetailstid: e.ticketDetailId.toString(),
      nextsequence: e.nextSequence.toString(),
    );

    GeneralResponse result = await InboxService.ambilTiket(context, _pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      getlistTicket(context);
    } else {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  void submitTicket(context, DatumTicket pin) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? userid = prefs.getInt('userid');

    PinSubmitTiket _pin = PinSubmitTiket(
      ticketid: pin.ticketId.toString(),
      userid: userid.toString(),
      desc: solusi,
      compensation: kompensasi,
      wfstatus: tindakanInbx.toString(),
      nextsequence: pin.nextSequence.toString(),
      ticketdetailstid: pin.ticketDetailId.toString(),
      solusi: solusi,
    );

    GeneralResponse result = await InboxService.submitTiket(context, _pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      getlistTicket(context);
    } else {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  void clearFilter() {
    statusTicket = '1';
    ticketID = '';
    userid = '';
    notifyListeners();
  }
}
