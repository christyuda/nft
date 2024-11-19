import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:webordernft/module/mom/provider/manager/list_meeting_detail_provider.dart';
import 'package:webordernft/module/mom/provider/manager/list_meetings_provider.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
import 'package:webordernft/module/order/provider/order_provider.dart';
import 'package:webordernft/module/order/provider/transaction_provider.dart';

import '../common/provider/general_provider.dart';
import '../common/provider/pagination_provider.dart';
import '../module/dashboard/provider/dashboard_provider.dart';
import '../module/inbox/provider/inbox_provider.dart';
import '../module/login/provider/login_provider.dart';
import '../module/main/provider/main_provider.dart';
import '../module/menu/provider/menu_provider.dart';
import '../module/person/provider/user_provider.dart';
import '../module/role/provider/role_provider.dart';
import '../module/ticket/provider/ticket_provider.dart';
import '../module/workflow/provider/workflow_provider.dart';

List<SingleChildStatelessWidget> providers = [
  ...independentServices,
  ...dependentServices,
];
List<SingleChildStatelessWidget> independentServices = [
  // ChangeNotifierProvider(create: (context) => MainProvider()),
  // ChangeNotifierProvider(create: (context) => GeneralProv()),
  // ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => OrderProvider()),
  ChangeNotifierProvider(create: (context) => MainProvider()),
  ChangeNotifierProvider(create: (context) => GeneralProv()),
  ChangeNotifierProvider(create: (context) => LoginProvider()),
  ChangeNotifierProvider(create: (context) => TicketProvider()),
  ChangeNotifierProvider(create: (context) => UserProvider()),
  ChangeNotifierProvider(create: (context) => RoleProvider()),
  ChangeNotifierProvider(create: (context) => WorkflowProvider()),
  ChangeNotifierProvider(create: (context) => PaginationProvider()),
  ChangeNotifierProvider(create: (context) => InboxProvider()),
  ChangeNotifierProvider(create: (context) => MenuProvider()),
  ChangeNotifierProvider(create: (context) => DashboardProvider()),
  ChangeNotifierProvider(create: (context) => TransactionProvider()),
  ChangeNotifierProvider(create: (context) => MomsProvider()),
  ChangeNotifierProvider(create: (context) => ListMeetingsProvider()),
  ChangeNotifierProvider(create: (context) => MeetingListDetailProvider()),
];

// for proxy manager
List<SingleChildStatelessWidget> dependentServices = [];

abstract class BaseProvider implements SingleChildStatelessWidget {}
