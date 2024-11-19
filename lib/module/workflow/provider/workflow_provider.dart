import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/role/service/model/list_role.dart';
import 'package:webordernft/module/workflow/service/wf_service.dart';

import '../../../common/provider/general_provider.dart';
import '../../../common/widget/general_response.dart';
import '../../person/service/user_service.dart';
import '../../ticket/service/model/list_kategori.dart';
import '../service/model/node.dart';
import '../service/model/nodes.dart';
import '../service/model/pin_add_nodes.dart';
import '../service/model/pin_kategori.dart';
import '../service/model/pin_submit_mapping.dart';
import '../service/model/pin_workflow_type.dart';

class WorkflowProvider with ChangeNotifier {
  bool? _isDisableCrtRole = true;
  String? _namakategori;
  String? _workflowname;
  String? _kategoriid;
  String? _subkategoriId;
  String? _jobdesk;
  String? _kode;
  String? _parentid;
  String? _type;
  String? _desc;

  String? _roleid;
  String? _rolename;
  String? _workflowtypeid;
  int? _sla;

  int? _slg;
  List<ListKategori>? _parentList = [];
  List<ListKategori>? _subkategori = [];
  List<Nodes>? _listnodes = [];
  List<Role>? _listroles = [];
  List<NodeLocal>? _listlocalnodes = [];

  // getter
  String? get roleid => _roleid;
  String? get rolename => _rolename;
  String? get workflowtypeid => _workflowtypeid;
  int? get sla => _sla;

  bool? get isDisableCrtRole => _isDisableCrtRole;
  String? get namakategori => _namakategori;
  String? get jobdesk => _jobdesk;
  String? get kode => _kode;
  String? get parentid => _parentid;
  String? get type => _type;
  String? get workflowname => _workflowname;
  String? get kategoriId => _kategoriid;
  String? get subkategoriId => _subkategoriId;
  String? get desc => _desc;
  int? get slg => _slg;
  List<ListKategori>? get parentList => _parentList;
  List<ListKategori>? get listsubkategori => _subkategori;
  List<Nodes>? get listnodes => _listnodes;
  List<Role>? get listroles => _listroles;
  List<NodeLocal>? get listlocalnodes => _listlocalnodes;

  // setter
  set roleid(String? val) {
    _roleid = val!;
    notifyListeners();
  }

  set workflowtypeid(String? val) {
    _workflowtypeid = val!;
    notifyListeners();
  }

  set rolename(String? val) {
    _rolename = val!;
    notifyListeners();
  }

  set sla(int? val) {
    _sla = val!;
    notifyListeners();
  }

  set listlocalnodes(List<NodeLocal>? val) {
    _listlocalnodes = val!;
    notifyListeners();
  }

  set listroles(List<Role>? val) {
    _listroles = val!;
    notifyListeners();
  }

  set listnodes(List<Nodes>? val) {
    _listnodes = val!;
    notifyListeners();
  }

  set listsubkategori(List<ListKategori>? val) {
    _subkategori = val!;
    notifyListeners();
  }

  set parentList(List<ListKategori>? val) {
    _parentList = val!;
    notifyListeners();
  }

  set slg(int? val) {
    _slg = val!;
    notifyListeners();
  }

  set desc(String? val) {
    _desc = val!;
    notifyListeners();
  }

  set subkategoriId(String? val) {
    _subkategoriId = val!;
    notifyListeners();
  }

  set kategoriId(String? val) {
    _kategoriid = val!;
    notifyListeners();
  }

  set workflowname(String? val) {
    _workflowname = val!;
    notifyListeners();
  }

  set type(String? val) {
    _type = val!;
    notifyListeners();
  }

  set parentid(String? val) {
    _parentid = val!;
    notifyListeners();
  }

  set kode(String? val) {
    _kode = val!;
    notifyListeners();
  }

  set jobdesk(String? val) {
    _jobdesk = val!;
    notifyListeners();
  }

  set namakategori(String? val) {
    _namakategori = val!;
    notifyListeners();
  }

  set isDisableCrtRole(bool? val) {
    _isDisableCrtRole = val!;
    notifyListeners();
  }

  // function

  submitCreateKategori(context, key) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    PinKategori pin = PinKategori(
      parentId: parentid,
      code: kode,
      type: parentid == '0' ? 'parent' : 'sub',
      namaSubkategori: namakategori,
      description: _desc,
    );

    GeneralResponse result = await WorkflowService.submitKategori(context, pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      key.currentState.reset();
      // isDisableCrtRole = true;
    } else {
      // isDisableCrtRole = true;
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  submitWorkflowType(context, key) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    PinWorkflowType pin = PinWorkflowType(
      workflowName: workflowname,
      kategoriId: kategoriId,
      subkategoriId: subkategoriId,
      desc: desc,
      slg: slg.toString(),
    );

    GeneralResponse result =
        await WorkflowService.submitWorkflowType(context, pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
      key.currentState.reset();
      // isDisableCrtRole = true;
    } else {
      // isDisableCrtRole = true;
      genprov.dissmisLoading();
      genprov.message = result.message!;
      genprov.genSendMessage();
    }
  }

  addNodesToLocal(context, key) {
    final genprov = Provider.of<GeneralProv>(context, listen: false);
    String _rl = roleid!.split('|').elementAt(0).toString();
    String _wfid = workflowtypeid!.split('|').elementAt(0);

    NodeLocal _input = NodeLocal(
      roleid: roleid!.split('|').elementAt(0).toString(),
      rolename: roleid!.split('|').elementAt(1).toString(),
      jobdesc: jobdesk,
      sla: sla.toString(),
      workflowtypeid: workflowtypeid!.split('|').elementAt(0),
    );

    print(jsonEncode(listlocalnodes));
    print(_wfid);

    int rowWfid =
        listlocalnodes!.where((e) => e.workflowtypeid == _wfid).length;

    print(rowWfid);

    if (rowWfid == 0 && listlocalnodes!.length > 0) {
      genprov.dissmisLoading();
      genprov.message = 'Workflowtype harus sama dengan sebelumnya';
      genprov.genSendMessage();
    } else {
      int row = listlocalnodes!.where((e) => e.roleid == _rl).length;

      if (row > 0) {
        genprov.dissmisLoading();
        genprov.message = 'Node / Role sudah ada untuk Workflow type ini';
        genprov.genSendMessage();
      } else {
        listlocalnodes!.add(_input);
        notifyListeners();
        key.currentState.reset();
        genprov.dissmisLoading();
      }
    }
  }

  simpanNodes(context, key) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    if (listlocalnodes!.length > 0) {
      for (final i in listlocalnodes!) {
        try {
          PinAddNodes pin = PinAddNodes(
            roleid: i.roleid,
            jobdesc: i.jobdesc,
            sla: i.sla,
            workflowtypeid: i.workflowtypeid,
          );
          await WorkflowService.addNodes(context, pin);
        } catch (e) {
          genprov.dissmisLoading();
          genprov.message =
              'Terjadi gangguan, silahkan ulangi beberapa saat lagi';
          genprov.genSendMessage();
        }
      }
      listlocalnodes!.clear();
      workflowname = '';
      workflowtypeid = '';
      genprov.dissmisLoading();
      genprov.message = 'Simpan Nodes Berhasil';
      genprov.genSendMessage();
      key.currentState.reset();
      notifyListeners();
    } else {
      genprov.dissmisLoading();
      genprov.message = 'Tidak ada node yang dapat disimpan';
      genprov.genSendMessage();
      key.currentState.reset();
      listlocalnodes!.clear();
      workflowname = '';
      workflowtypeid = '';
      notifyListeners();
    }
  }

  submitMappingKategoriWf(context) async {
    final genprov = Provider.of<GeneralProv>(context, listen: false);

    PinSubmitMapping pin = PinSubmitMapping(
      categoryid: subkategoriId,
      workflowtypeid: workflowtypeid,
    );

    GeneralResponse result = await WorkflowService.submitMapping(context, pin);

    if (result.status == true) {
      genprov.dissmisLoading();
      genprov.message = 'Mapping Berhasil';
      genprov.genSendMessage();
    } else {
      genprov.dissmisLoading();
      genprov.message = 'Tidak ada Workflow yang dapat disimpan';
      genprov.genSendMessage();
    }
  }

  //get
  getParentKategori(context, param) async {
    List<ListKategori> _lists = [];

    List<ListKategori> _parentList = await WorkflowService.getKategori(context);

    ListKategori _inject = ListKategori(
      id: 0,
      desc: 'Tanpa Parent Kategori',
      code: '0',
      name: 'Tanpa Induk / Parent Kategori',
      parentId: 0,
    );

    if (param == 1) {
      _lists.addAll(_parentList);
      _lists.add(_inject);
      parentList = _lists;
      notifyListeners();
    } else {
      _lists.addAll(_parentList);
      parentList = _lists;
      notifyListeners();
    }
  }

  getSubKategori(context) async {
    PinSubKategori pin = PinSubKategori(
      parentid: parentid,
    );

    List<ListKategori> _parentList =
        await WorkflowService.getsubKategori(context, pin);

    listsubkategori = _parentList;
    notifyListeners();
  }

  getWorkflowtype(context) async {
    List<Nodes> _nodesList = await WorkflowService.getWorkflowtype(context);

    listnodes = _nodesList;
    notifyListeners();
  }

  getRole(context) async {
    List<Role> _roleList = await UserService.getRole(context);

    listroles = _roleList;
    notifyListeners();
  }
}

class PinSubKategori {
  PinSubKategori({
    this.parentid,
  });

  String? parentid;

  factory PinSubKategori.fromJson(Map<String, dynamic> json) => PinSubKategori(
        parentid: json["parentid"],
      );

  Map<String, dynamic> toJson() => {
        "parentid": parentid,
      };
}
