// menu

import 'package:flutter/material.dart';
import 'package:webordernft/module/menu/view/add_menu.dart';
import 'package:webordernft/module/mom/view/create_mom.dart';
import 'package:webordernft/module/mom/view/create_momV2.dart';
import 'package:webordernft/module/mom/view/list_meeting.dart';
import 'package:webordernft/module/mom/view/list_meetingV2.dart';
import 'package:webordernft/module/order/index_transactions.dart';

import '../module/dashboard/view/dashboard_pengguna.dart';
import '../module/dashboard/view/dashboard_ticket.dart';
import '../module/dashboard/view/dashhboard_transaksi.dart';
import '../module/inbox/view/form_inbox_ticket.dart';
import '../module/menu/view/add_menu_to_role.dart';
import '../module/menu/view/list_menu.dart';
import '../module/person/view/create_new_user.dart';
import '../module/person/view/index_user.dart';
import '../module/role/view/create_role.dart';
import '../module/ticket/view/create_ticket.dart';
import '../module/workflow/view/create_kategori_workflow.dart';
import '../module/workflow/view/create_workflow_node.dart';
import '../module/workflow/view/create_workflow_type.dart';
import '../module/workflow/view/mapping_kategori_workflow.dart';

// const Widget addmenu = FormAddMenu();

final List<PageRoute> pageRoutes = [
  PageRoute(pagename: 'addmenu', routes: FormAddMenu()),
  PageRoute(pagename: 'listmenu', routes: FormListMenu()),
  PageRoute(pagename: 'listUser', routes: FormListUser()),
  PageRoute(pagename: 'listOrders', routes: TransactionsListOrder()),
  PageRoute(pagename: 'createTicket', routes: FormCreateTicket()),
  PageRoute(pagename: 'createUser', routes: FormCreateNewUser()),
  PageRoute(pagename: 'createRole', routes: FormCreateRole()),
  PageRoute(pagename: 'createKategori', routes: FormCreateKategori()),
  PageRoute(pagename: 'createWorkflowType', routes: FormCreateWorkflowType()),
  PageRoute(pagename: 'createWorkflowNode', routes: FormCreateWorkflowNode()),
  PageRoute(pagename: 'inboxTicket', routes: ForminboxTicket()),
  PageRoute(pagename: 'addmenuToRole', routes: FormaddmenuToRole()),
  PageRoute(pagename: 'dashboardTicketing', routes: DashboardTicket()),
  PageRoute(pagename: 'dashboardPengguna', routes: DashboardPengguna()),
  PageRoute(pagename: 'dashboardTransaksi', routes: DashboardTransaksi()),
  // PageRoute(pagename: 'createMom', routes: FormCreateMom()),
  PageRoute(pagename: 'createMom', routes: CreateMomV2()),
  PageRoute(pagename: 'listMom', routes: ListMeetingsMom()),

  // PageRoute(pagename: 'listMom', routes: MeetingListPage()),
  PageRoute(
      pagename: 'createKategoriWorkflow',
      routes: FormMappingKategoriWorkflow()),
];

class PageRoute {
  PageRoute({
    this.pagename,
    this.routes,
  });

  String? pagename;
  Widget? routes;

  factory PageRoute.fromJson(Map<String, dynamic> json) => PageRoute(
        pagename: json["pagename"],
        routes: json["routes"],
      );

  Map<String, dynamic> toJson() => {
        "pagename": pagename,
        "routes": routes,
      };
}
