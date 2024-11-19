import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webordernft/config/networking.dart';
import 'package:webordernft/module/mom/service/model/list_audiences_request.dart';
import 'package:webordernft/module/mom/service/model/list_audiences_response.dart';
import 'package:webordernft/module/mom/service/model/pin_detailistmeeting.dart';
import 'package:webordernft/module/mom/service/model/pin_ticketing_absen.dart';
import 'package:webordernft/module/mom/service/model/pin_validate_ticketing.dart';
import 'package:webordernft/module/mom/service/model/response_detaillistmeeting.dart';
import 'package:webordernft/module/mom/service/model/response_listmeetings.dart';
import 'package:webordernft/module/mom/service/model/response_listmom.dart';
import 'package:webordernft/module/mom/service/model/response_meeting.dart';
import 'package:webordernft/module/mom/service/model/response_ticketing_absen.dart';
import 'package:webordernft/module/mom/service/model/response_validate_ticketing.dart';
import 'package:webordernft/module/mom/service/model/sign_audiences_request.dart';
import 'package:webordernft/module/mom/service/model/sign_audiences_response.dart';

class MomService {
  static getMomServiceList(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/listUserAudiences';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    UserAudienceData result = UserAudienceData.fromJson(decodedData);

    return result;
  }

  static addUserAudience(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/addUserAudience';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    UserAudienceData result = UserAudienceData.fromJson(decodedData);
    return result;
  }

  static createMeetings(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/createMeeting';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    MeetingResponse result = MeetingResponse.fromJson(decodedData);
    return result;
  }

  static listmeetings(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/listMeetings';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    ListMeetingResponse result = ListMeetingResponse.fromJson(decodedData);
    return result;
  }

  static Future<SignAudienceResponse?> signAudience(
      context, SignAudienceRequest request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    String url = 'mom/signAudience';
    Map<String, String> fields = request.toFields();

    NetworkHelper networkHelper = NetworkHelper(url, '', token!);

    // Modify postRequestSignMultipart to accept Uint8List for signatureData
    Response response = await networkHelper.postRequestSign(
      context,
      fields,
      fileData: request.signatureData, // Use Uint8List data
      fileFieldName: 'signature',
    );

    if (response.statusCode == 200) {
      var decodedData =
          SignAudienceResponse.fromJson(json.decode(response.body));
      return decodedData;
    } else {
      print('Failed to sign audience: ${response.statusCode}');
      return null;
    }
  }

  static Future<SignAudienceResponse?> signAudienceOnline(
      context, SignAudienceRequest request, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    String url = 'mom/signAudience';
    Map<String, String> fields = request.toFields();

    NetworkHelper networkHelper = NetworkHelper(url, '', token!);

    // Modify postRequestSignMultipart to accept Uint8List for signatureData
    Response response = await networkHelper.postRequestSignMultipart(
      context,
      fields,
      fileData: request.signatureData, // Use Uint8List data
      fileFieldName: 'signature',
    );

    if (response.statusCode == 200) {
      var decodedData =
          SignAudienceResponse.fromJson(json.decode(response.body));
      return decodedData;
    } else {
      print('Failed to sign audience: ${response.statusCode}');
      return null;
    }
  }

  static getAllAudiencesByMeetingId(context, params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/getAllAudiencesByMeetingId';
    String jsonInput = json.encode(params);

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    ListAudiencesResponse result = ListAudiencesResponse.fromJson(decodedData);
    return result;
  }

  static generateTicket(context, PinTicketingAbsenRequest request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _token = prefs.getString('token');

    String url = 'mom/generateTicket'; // Relative URL
    String jsonInput = json.encode(request.toJson());

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, _token!);

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    PinTicketingAbsenResponse result =
        PinTicketingAbsenResponse.fromJson(decodedData);

    return result;
  }

  static validateTicket(context, PinValidateTicketingRequest request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = 'mom/validateTicket'; // Relative URL
    String jsonInput = json.encode(request.toJson());

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, '');

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    ResponseValidateTicketing result =
        ResponseValidateTicketing.fromJson(decodedData);

    return result;
  }

  static Future<GetMeetingByIdResponse> getMeetingById(
    context,
    GetMeetingByIdRequest request,
  ) async {
    String url = 'mom/getMeetingById'; // Relative URL
    String jsonInput = json.encode(request.toJson());

    print(jsonInput);

    NetworkHelper networkHelper = NetworkHelper(url, jsonInput, '');

    Response response = await networkHelper.postRequestHttp(context);

    var decodedData = json.decode(response.body);
    GetMeetingByIdResponse result =
        GetMeetingByIdResponse.fromJson(decodedData);

    return result;
  }
}
