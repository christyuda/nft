import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/networking.dart';
import 'model/daily_ticket.dart';
import 'model/monthly_ticket.dart';
import 'model/resume_transaction.dart';
import 'model/ticket_issue.dart';
import 'model/ticket_status_montlhy.dart';
import 'model/topgtv.dart';
import 'model/total_user.dart';
import 'model/total_user_country.dart';
import 'model/total_user_monthly.dart';

class DashboardService {
  static getDailyTicket(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/dailyticket';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<DailyTicket> result =
        collection.map((json) => DailyTicket.fromJson(json)).toList();

    return result;
  }

  static getDataticketSourcemontly(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/sourceticketmontly';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TicketIssueMonthly> result =
        collection.map((json) => TicketIssueMonthly.fromJson(json)).toList();

    return result;
  }

  static getDataticketIssuemontly(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/issueticketmontly';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TicketIssueMonthly> result =
        collection.map((json) => TicketIssueMonthly.fromJson(json)).toList();

    return result;
  }

  static getDataticketstatusmontly(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/ticketstatusmontly';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<Ticketstatusmontly> result =
        collection.map((json) => Ticketstatusmontly.fromJson(json)).toList();

    return result;
  }

  static getticketformonth(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/ticketformonth';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    // Response response = await networkHelper.getRequest(context, url);
    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<MontlyTicket> result =
        collection.map((json) => MontlyTicket.fromJson(json)).toList();

    return result;
  }

  static getticketformonthAll(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/ticketformonthAllstatus';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<MontlyTicket> result =
        collection.map((json) => MontlyTicket.fromJson(json)).toList();

    return result;
  }

  // Service Feeder
  static getfeedTotalUser(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/resumeUser';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUser> result =
        collection.map((json) => TotalUser.fromJson(json)).toList();

    return result;
  }

  static getfeedTotalUserYearly(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/resumeUserMonthly';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUserMontly> result =
        collection.map((json) => TotalUserMontly.fromJson(json)).toList();

    return result;
  }

  static getfeedTotalUserCountry(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/resumeUserCountryMonthly';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUserCountryMontly> result = collection
        .map((json) => TotalUserCountryMontly.fromJson(json))
        .toList();

    return result;
  }

  static getfeedResumeTransaction(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/resumeTransaction';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<ResumeTransaction> result =
        collection.map((json) => ResumeTransaction.fromJson(json)).toList();

    return result;
  }

  static getfeedtopgtv(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/topgtv';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TopGtv> result =
        collection.map((json) => TopGtv.fromJson(json)).toList();

    return result;
  }

  static getfeedtoptrx(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/topTrxProduct';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TopGtv> result =
        collection.map((json) => TopGtv.fromJson(json)).toList();

    return result;
  }

  static getfeedtrxvsgtv(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/trxvsgtv';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUserCountryMontly> result = collection
        .map((json) => TotalUserCountryMontly.fromJson(json))
        .toList();

    return result;
  }

  static getfeedgtvproduct(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mart/feed/gtvperproduct';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUserCountryMontly> result = collection
        .map((json) => TotalUserCountryMontly.fromJson(json))
        .toList();

    return result;
  }

  static getfeedtrxproduct(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    // String url = 'mart/feed/trxperproduct';
    String url = 'mart/feed/gtvperproduct';

    String jsonInput = json.encode(params);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);

    List collection = decodedData['data'];

    List<TotalUserCountryMontly> result = collection
        .map((json) => TotalUserCountryMontly.fromJson(json))
        .toList();

    return result;
  }
}
