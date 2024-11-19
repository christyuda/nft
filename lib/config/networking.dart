import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import '../common/provider/general_provider.dart';
import '../module/login/provider/login_provider.dart';

class NetworkHelper {
  NetworkHelper(this.url, this.jsonInput, this.token);

  final String url;
  final String jsonInput;
  final String token;

  String maskingErrorText =
      'Sedang ada gangguan di jaringan atau sistem. Mohon coba kembali beberapa saat lagi.';

  bool isSecure = false;

  Future postRequestHttp(context) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);
    final env = Provider.of<LoginProvider>(context, listen: false);

    bool statconn = await await InternetConnection().hasInternetAccess;
    Map<String, String> headersGet = await headerGeneral();
    print(jsonInput);
    print(env.apiEndPoint! + url);

    if (statconn) {
      try {
        // var response = await http.post(Uri.parse(serverUrl + url));

        Response response = await http.post(
          Uri.parse(env.apiEndPoint! + url),
          headers: headersGet,
          body: jsonInput,
        );

        print(headersGet);
        print(response.statusCode);
        print(response.body);
        return response;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        print(e);
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }

  Future putRequestHttp(context) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);
    final env = Provider.of<LoginProvider>(context, listen: false);
    // EnvArgument env = Provider.of<EnvSet>(context, listen: false).getEnv();

    bool statconn = await InternetConnection().hasInternetAccess;
    ;
    Map<String, String> headersGet = await headerGeneral();
    print(env.apiEndPoint! + url);
    if (statconn) {
      try {
        // var response = await http.post(Uri.parse(serverUrl + url));

        Response response = await http.put(Uri.parse(env.apiEndPoint! + url),
            headers: headersGet, body: jsonInput);

        print(headersGet);
        print(response.body);
        return response;

        // var decodedData = jsonDecode(response.toString());
        //
        // return decodedData;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }

  Future getRequest(context, url) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);
    final env = Provider.of<LoginProvider>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;
    ;
    Map<String, String> headersGet = await headerGeneral();
    print(env.apiEndPoint! + url);

    if (statconn) {
      try {
        Response responseget = await http.get(
          Uri.parse(env.apiEndPoint! + url),
          // Uri.parse(env.apiEndPoint!),
          headers: headersGet,
        );
        // print(headersGet);
        print(responseget.body);
        return responseget;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }

  Future<Uint8List?> loadSignatureFromUrl(String signingPath) async {
    try {
      final url =
          'https://apinft.posfin.id/storage/signatures/manual/$signingPath';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to load signature: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error loading signature: $e");
      return null;
    }
  }

  Future<http.Response> postRequestSign(
    context,
    Map<String, String> fields, {
    Uint8List? fileData,
    required String fileFieldName,
  }) async {
    final env = Provider.of<LoginProvider>(context, listen: false);
    final prov = Provider.of<GeneralProv>(context, listen: false);

    final apiUrl = '${env.apiEndPoint!}$url';
    final statconn = await InternetConnection().hasInternetAccess;

    if (!statconn) {
      return _handleNoInternet(prov);
    }

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields.addAll(fields);

    // Attach the file data if available
    if (fileData != null) {
      request.files.add(http.MultipartFile.fromBytes(
        fileFieldName,
        fileData,
        filename: 'signature.png',
        contentType: MediaType('image', 'png'),
      ));
    }

    // Set headers
    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    try {
      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print('Error during multipart POST request: $e');
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return http.Response(jsonEncode({'error': e.toString()}), 500);
    }
  }

  Future<http.Response> postRequestSignMultipart(
    BuildContext context,
    Map<String, String> fields, {
    Uint8List? fileData,
    required String fileFieldName,
  }) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);
    final env = Provider.of<LoginProvider>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;

    if (!statconn) {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return http.Response(
        jsonEncode(response),
        500,
      );
    }

    try {
      Map<String, String> headersGet = await headerMultipartMomsigning();
      var request =
          http.MultipartRequest('POST', Uri.parse(env.apiEndPoint! + url))
            ..headers.addAll(headersGet)
            ..fields.addAll(fields);

      if (fileData != null) {
        request.files.add(http.MultipartFile.fromBytes(
          fileFieldName,
          fileData,
          filename: 'uploadedfile.png',
          contentType: MediaType('image', 'png'),
        ));
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      print('Error during multipart POST request: $e');
      return Response(jsonEncode({'error': e.toString()}), 500);
    }
  }

  Future<Response> _handleNoInternet(GeneralProv prov) async {
    final response = NetworkResponse(
      code: 500,
      data: Data(),
      message: 'Tidak ada jaringan internet. Ulangi beberapa saat lagi',
    ).toJson();
    prov.showspinner = false;
    prov.message = maskingErrorText;
    prov.genSendMessage();
    return http.Response(jsonEncode(response), 500);
  }

  Future getRequestExtend(context, url) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;
    ;
    Map<String, String> headersGet = await headerGeneral();

    if (statconn) {
      try {
        Response responseget = await http.get(
          Uri.parse(url),
          // Uri.parse(env.apiEndPoint!),
          headers: headersGet,
        );
        // print(headersGet);
        // print(responseget.body);
        return responseget;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }

  Future postForLogin(context) async {
    final env = Provider.of<LoginProvider>(context, listen: false);
    final prov = Provider.of<GeneralProv>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;
    Map<String, String> headersGet = await headerUrlEncoded();
    print(jsonInput);
    print(env.apiEndPoint! + url);
    if (statconn) {
      try {
        Response response = await http.post(
          Uri.parse(env.apiEndPoint! + url),
          headers: headersGet,
          body: jsonInput,
        );

        print(response.body);

        return response;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      // prov.showspinner = false;
      prov.message = 'Tidak ada jaringan internet Ulangi beberapa saat lagi';
      prov.showspinner = false;
      prov.genSendMessage();
      return response;
    }
  }

  Future<Map<String, String>> standardHeader() async {
    String tokens = 'Token';
    // String tokens = tokenManual;

    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $tokens"
    };

    return headersGet;
  }

  Map<String, String> header() {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    return headersGet;
  }

  Future<Map<String, String>> headerGeneral() async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer ${token}',
    };

    return headersGet;
  }

  Future<Map<String, String>> headerMultipart() async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      // "Content-Type": "application/json",
      'content-type': 'multipart/form-data',
      "x-pmi-token": token,
    };

    return headersGet;
  }

  Future<Map<String, String>> headerMultipartMomsigning() async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      // "Content-Type": "application/json",
      'content-type': 'multipart/form-data',
      "Authorization": 'Bearer ' + token,
    };

    return headersGet;
  }

  Future<Map<String, String>> headerMultipartData() async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      // "Content-Type": "application/json",
      'content-type': 'multipart/form-data',
      "Authorization": token,
    };

    return headersGet;
  }

  Map<String, String> headerUrlEncoded() {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": "Basic ZGV2Y2xpZW50OnNlY3JldFBhc3N3b3Jk"
    };
    return headersGet;
  }

  Future postRequestMultipart(context) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);
    final env = Provider.of<LoginProvider>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;
    ;
    Map<String, String> headersGet = await headerMultipart();
    print(headersGet);
    print(jsonInput);
    print(env.apiEndPoint! + url);

    if (statconn) {
      try {
        var request = await http.MultipartRequest(
          'POST',
          Uri.parse(env.apiEndPoint! + url),
          // headers: headersGet,
          // body: jsonInput,
        );
        request.headers.addAll(headersGet);

        var response = await request.send();

        // print(headersGet);
        // print(response.statusCode);
        // print(response.body);

        return response;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        print(e);
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }

  Future<Map<String, String>> headerGeneralPMI(token) async {
    Map<String, String> headersGet = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer ' + token,
    };
    return headersGet;
  }

  postRequestPMI(context, url, jsonInput, token) async {
    final prov = Provider.of<GeneralProv>(context, listen: false);

    bool statconn = await InternetConnection().hasInternetAccess;
    Map<String, String> headersGet = await headerGeneralPMI(token);

    print(url);
    print(jsonInput);

    if (statconn) {
      try {
        Response response = await http.post(
          Uri.parse(url),
          headers: headersGet,
          body: jsonInput,
        );

        print(headersGet);
        print(response.statusCode);
        print(response.body);
        return response;
      } catch (e) {
        prov.showspinner = false;
        prov.message = maskingErrorText;
        prov.genSendMessage();
        print(e);
        return e;
      }
    } else {
      var response = NetworkResponse(
        code: 500,
        data: Data(),
        message: 'Tidak ada jaringan internet Ulangi beberapa saat lagi',
      ).toJson();
      prov.showspinner = false;
      prov.message = maskingErrorText;
      prov.genSendMessage();
      return response;
    }
  }
}

class NetworkResponse {
  String message;
  Data data;
  int code;

  NetworkResponse({
    required this.message,
    required this.data,
    required this.code,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json) =>
      NetworkResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "code": code,
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

NetworkResponse networkResponseFromJson(String str) =>
    NetworkResponse.fromJson(json.decode(str));

String networkResponseToJson(NetworkResponse data) =>
    json.encode(data.toJson());

/*
 final SecurityContext context = SecurityContext();

    final expireDate = DateTime.parse('2021-12-30 06:59:59')
        .subtract(const Duration(days: 1))
        .isBefore(DateTime.now());

    // Configuration Certificates
    // Di Production pake sertifikat, kalau di embrio tidak pakai
    if (!isStaging && !expireDate) {
      context.setTrustedCertificatesBytes(cert.myCert);
    }

    final HttpClient httpClient = HttpClient(
      context: isStaging && !expireDate ? null : context,
    );

    httpClient.badCertificateCallback = (cert, host, port) {
      return false;
    };

    String responseString = '';
    late HttpClientRequest request;
    HttpClientResponse? response;

    final url =
        Uri.parse(useEndpoint ? env.apiEndPoint! + path : env.baseUrl! + path);
*/
