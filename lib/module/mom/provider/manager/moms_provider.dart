import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as quill;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/common/widget/toast_message.dart';
import 'package:webordernft/module/mom/helper/pdf_helper.dart';
import 'package:webordernft/module/mom/helper/toolbar_helper.dart';
import 'package:webordernft/module/mom/service/model/employee_selection.dart';
import 'package:webordernft/module/mom/service/model/pin_addAudiences.dart';
import 'package:webordernft/module/mom/service/model/pin_listmeetings.dart';
import 'package:webordernft/module/mom/service/model/pin_listmom.dart';
import 'package:webordernft/module/mom/service/model/request_meeting.dart';
import 'package:webordernft/module/mom/service/model/response_detaillistmeeting.dart';
import 'package:webordernft/module/mom/service/model/response_listmeetings.dart';
import 'package:webordernft/module/mom/service/model/response_listmom.dart';
import 'package:webordernft/module/mom/service/model/sign_audiences_request.dart';
import 'package:webordernft/module/mom/service/model/sign_audiences_response.dart';
import 'package:webordernft/module/mom/service/mom_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class MomsProvider extends ChangeNotifier {
  // Employee Data
  Map<int, String> qrCodes = {};

  void setQrCode(int audienceId, String qrData) {
    qrCodes[audienceId] = qrData;
    notifyListeners();
  }

  String? getQrCode(int audienceId) {
    return qrCodes[audienceId];
  }

  final Map<String, Uint8List> _employeeSignatures = {};

  final List<String> _allEmployees = [
    "John Doe - Developer",
    "Jane Smith - Designer",
    "Alex Brown - Manager",
    "Sarah Johnson - HR",
    "Tom White - Sales",
    "Anna Lee - Marketing"
  ];
  ListMeetingResponse? _meetingResponse;

  String? _nik = '';
  String? _name = '';
  String? _position = '';
  String? _stakeholder = '';
  String? _signing = '';
  int? _meetingId;
  int? _status = 0;
  String? _author;
  String? _meetingDate;
  String? _time;
  String? _place;
  String? _agenda;
  SignAudienceResponse? signAudienceResponse;
  String? errorMessage;
  bool _isSubmitting = false;
  List<Map<String, String>> _suggestions = [];

  List<Map<String, String>> get suggestions => _suggestions;
  bool get isSubmitting => _isSubmitting;
  List<String> _filteredEmployees = [];
  List<EmployeeSelection> _selectedEmployees = [];
  final List<Map<String, dynamic>> _catatanList = [];

  List<User> _audiences = [];
  bool _isLoading = false;
  List<int> _selectedEmployeeIds =
      []; // Store only the IDs of selected employees

  // Notes Data
  final TextEditingController catatanController = TextEditingController();
  bool _isFinalized = false;
  List<Map<String, dynamic>> _finalizedList = [];
  Map<DateTime, List<String>> meetingDetails = {};

  // Getters for Employees
  String _discussionMaterial = '';

  // Getter for discussionMaterial
  String get discussionMaterial => _discussionMaterial;

  int? get meetingId => _meetingId;
  String? get author => _author;
  String? get meetingDate => _meetingDate;
  String? get time => _time;
  String? get place => _place;
  String? get agenda => _agenda;
  ListMeetingResponse? get meetingResponse => _meetingResponse;
  Uint8List? getSignature(int audienceId) => _signatures[audienceId];
  String? get nik => _nik;
  String? get name => _name;
  String? get position => _position;
  String? get stakeholder => _stakeholder;
  String? get signing => _signing;
  int? get status => _status;
  List<int> get selectedEmployeeIds => _selectedEmployeeIds;
  List<EmployeeSelection> get selectedEmployees => _selectedEmployees;
  Map<int, Uint8List> _signatures = {};

  List<User> get audiences => _audiences;
  bool get isLoading => _isLoading;
  List<String> get filteredEmployees => _filteredEmployees;
  // Getters for Notes
  bool get isSigned => signing != null;

  List<Map<String, dynamic>> get catatanList => _catatanList;
  List<Map<String, dynamic>> get finalizedList => _finalizedList;
  bool get isFinalized => _isFinalized;

  int representativeSigner = 0;
  int isPresent = 0;

  // Setter for discussionMaterial
  set discussionMaterial(String value) {
    _discussionMaterial = value;
    notifyListeners(); // Notify listeners whenever the value changes
  }

  void setRepresentativeSigner(int value) {
    representativeSigner = value;
    notifyListeners();
  }

  void setIsPresent(int value) {
    isPresent = value;
    notifyListeners();
  }

  void setSubmitting(bool submitting) {
    _isSubmitting = submitting;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Employee Methods
  void filterEmployees(String query) {
    _filteredEmployees = _allEmployees
        .where(
            (employee) => employee.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void addEmployee(String name, String position) {
    if (!_selectedEmployees.any(
        (employee) => employee.name == name && employee.position == position)) {
      _selectedEmployees.add(EmployeeSelection(
        name: name,
        position: position,
      ));

      notifyListeners();
    } else {
      print("Data peserta sudah ada");
    }
  }

  void updateCatatan(int index, String field, String newValue) {
    finalizedList[index][field] = newValue;
    notifyListeners();
  }

  void clearQrCodes() {
    qrCodes.clear();
    notifyListeners();
  }

  void clearSignatures() {
    _signatures.clear();
    notifyListeners();
  }

  void clearAll() {
    clearQrCodes();
    clearSignatures();
  }

  set author(String? value) {
    _author = value;
    notifyListeners();
  }

  set meetingDate(String? value) {
    _meetingDate = value;
    notifyListeners();
  }

  set time(String? value) {
    _time = value;
    notifyListeners();
  }

  set place(String? value) {
    _place = value;
    notifyListeners();
  }

  set agenda(String? value) {
    _agenda = value;
    notifyListeners();
  }

  void addEmployeeById(int? id, String? name, String? position, String? nik,
      String? stakeholder) {
    if (_selectedEmployees.any((employee) => employee.id == id)) {
      SnackBar(content: Text("Peserta sudah ada"));
      return;
    }

    _selectedEmployees.add(EmployeeSelection(
      id: id,
      name: name,
      position: position,
      nik: nik,
      stakeholder: stakeholder,
    ));

    notifyListeners();
  }

  void removeEmployeeById(int? id) {
    _selectedEmployees.removeWhere((employee) => employee.id == id);
    notifyListeners();
  }

  void clearSelectedEmployees() {
    _selectedEmployees.clear();
    notifyListeners();
  }

  // Note Methods
  void addCatatan(String note) {
    if (note.isNotEmpty) {
      _catatanList.add({
        'catatan': note,
        'pic': '',
        'dueDate': null,
      });
      catatanController.clear();
      notifyListeners();
    }
  }

  void updatePIC(int index, String pic, {bool isFinalized = false}) {
    if (isFinalized && index < _finalizedList.length) {
      _finalizedList[index]['pic'] = pic;
    } else if (index < _catatanList.length) {
      _catatanList[index]['pic'] = pic;
    }
    notifyListeners();
  }

  void updateDueDate(int index, String dueDate, {bool isFinalized = false}) {
    if (isFinalized && index < _finalizedList.length) {
      _finalizedList[index]['dueDate'] = dueDate;
    } else if (index < _catatanList.length) {
      _catatanList[index]['dueDate'] = dueDate;
    }
    notifyListeners();
  }

  void finalizeNotes() {
    _isFinalized = true;
    notifyListeners();
  }

  void clearNotes() {
    _catatanList.clear();
    _isFinalized = false;
    notifyListeners();
  }

  // Method to move a note from catatanList to finalizedList
  void addToFinalized(int index) {
    if (index >= 0 && index < _catatanList.length) {
      _finalizedList.add(_catatanList[index]);
      _catatanList.removeAt(index);
      notifyListeners();
    }
  }

  // Method to remove a note from catatanList
  void removeCatatan(int index) {
    if (index >= 0 && index < _catatanList.length) {
      _catatanList.removeAt(index);
      notifyListeners();
    }
  }

  // Method to remove a note from finalizedList
  void removeFromFinalized(int index) {
    if (index >= 0 && index < _finalizedList.length) {
      _finalizedList.removeAt(index);
      notifyListeners();
    }
  }

  // Method to clear all finalized notes
  void clearFinalizedNotes() {
    _finalizedList.clear();
    notifyListeners();
  }

  void addCatatanToFinalized(Map<String, dynamic> catatan) {
    finalizedList.add(catatan);
    _catatanList.remove(catatan);
    notifyListeners();
  }

  void reorderFinalizedList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = finalizedList.removeAt(oldIndex);
    finalizedList.insert(newIndex, item);
    notifyListeners();
  }

  void addAllToFinalized() {
    finalizedList.addAll(catatanList);
    catatanList.clear();
    notifyListeners();
  }

  void updateRepresentativeSigner(int? id, int representativeSigner) {
    final employeeIndex = _selectedEmployees.indexWhere((emp) => emp.id == id);
    if (employeeIndex != -1) {
      _selectedEmployees[employeeIndex].representative_signer =
          representativeSigner;
      notifyListeners();
    }
  }

  void toggleEmployeeSelection(int? id) {
    final employee = _selectedEmployees.firstWhere(
      (emp) => emp.id == id,
      orElse: () => EmployeeSelection(),
    );

    if (employee.id != null) {
      employee.representative_signer =
          (employee.representative_signer == 1) ? 0 : 1;
      notifyListeners();
    }
  }

  // Function to check if an employee is selected
  int isEmployeeSelected(int? id) {
    final employee = _selectedEmployees.firstWhere(
      (emp) => emp.id == id,
      orElse: () => EmployeeSelection(
          representative_signer: 0), // Default to unselected if not found
    );
    return (employee.representative_signer == 1) ? 1 : 0;
  }

  void saveEmployeeSignature(EmployeeSelection employee, Uint8List signature) {
    _employeeSignatures[employee.name ?? ''] = signature;
    notifyListeners();
  }

  Uint8List? getEmployeeSignature(String name) {
    return _employeeSignatures[name];
  }

  int lastPage = 1;
  int totalRow = 0;
  int fromRow = 0;
  int toRow = 0;
  int _currentPage = 1;
  int get currentPage => _currentPage;

  Future<void> submitSelectedEmployees(
      List<EmployeeSelection> employees) async {
    for (var employee in employees) {
      print(
          "Mengirim karyawan: ${employee.name} dengan posisi ${employee.position}" +
              " dengan ID ${employee.id}" +
              " dengan NIK ${employee.nik}" +
              " dengan Stakeholder ${employee.stakeholder}");
      if (employee.representative_signer == 1) {
        print("Sebagai perwakilan MOM ${employee.name}");
      }
    }
    notifyListeners();
  }

  Future<void> fetchUserAudiences(
      BuildContext context, int page, int size, String term) async {
    if (term.isEmpty) {
      clearSuggestions(); // Clear suggestions if no input
      return;
    }
    setLoading(true);

    try {
      UserAudienceRequest request = UserAudienceRequest(
        page: page,
        size: size,
        term: term,
      );

      UserAudienceData result =
          await MomService.getMomServiceList(context, request);
      _audiences = result.audiences;

      _suggestions = _audiences
          .map((audience) => {
                'id': audience.id.toString(),
                'name': audience.name ?? '',
                'position': audience.position ?? '',
                'nik': audience.nik ?? '',
                'stakeholder': audience.stakeholder ?? '',
              })
          .toList();

      lastPage = result.totalRecords;
      _currentPage = result.currentPage;

      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      _suggestions = [];
      print("Error fetching user audiences: $e");
      notifyListeners();
    }
  }

  void clearSuggestions() {
    _suggestions = [];
    notifyListeners();
  }

  Future<void> addUserAudience(BuildContext context, String name, String nik,
      String position, String stakeholder, String signing, int status) async {
    PinAddaudiences formData = PinAddaudiences(
        name: name,
        nik: nik,
        position: position,
        stakeholder: stakeholder,
        signing: signing,
        status: status);

    setSubmitting(true);

    try {
      final response = await MomService.addUserAudience(context, formData);
      if (response['status']) {
        print('User audience added successfully: ${response['message']}');
        notifyListeners();
      } else {
        print('Failed to add user audience: ${response['message']}');
        notifyListeners();
      }
    } catch (e) {
      print('Error adding user audience: $e');
    }
    setSubmitting(false);
  }

  Future<pw.Document> generatePreview(BuildContext context) async {
    final pdf = pw.Document();
    final provider = Provider.of<MomsProvider>(context, listen: false);

    // Get the HTML content from the provider
    final String discussionMaterialHtml = provider.discussionMaterial ?? "";

    // Fallback if discussionMaterial is empty
    if (discussionMaterialHtml.isEmpty) {
      throw Exception("Discussion Material is empty");
    }

    // Parse HTML content using the 'html' package
    final dom.Document htmlDoc = parse(discussionMaterialHtml);

    // Convert parsed HTML to PDF widgets
    List<pw.Widget> parsedWidgets = parseHtmlToPdfWidgets(htmlDoc.body);

    // Load the POSFIN logo image from assets
    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo/logo_company.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header with Logo and Title
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  child: pw.Image(logoImage, width: 60, height: 60),
                ),
                pw.Text(
                  "MINUTES OF MEETING",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Meeting Details Table with outer borders
            pw.Table(
              border: pw.TableBorder.all(), // Outer border for the whole table
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Author: ${provider.author ?? ''}"),
                    ),
                    pw.Table(
                      border:
                          pw.TableBorder.all(), // Inner border for right table
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Hari / Tanggal",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text("${provider.meetingDate ?? ''}"),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Waktu",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text("${provider.time ?? ''}"),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Tempat",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text("${provider.place ?? ''}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Agenda"),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("${provider.agenda ?? ''}"),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Peserta Rapat"),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: provider.selectedEmployees.map((employee) {
                          return pw.Text(employee.name ?? '');
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // MATERI MEETING Section (Render HTML)
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 8),
                      child: pw.Center(
                        child: pw.Text(
                          "MATERI MEETING",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: parsedWidgets.isNotEmpty
                          ? pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: parsedWidgets,
                            )
                          : pw.Text(
                              "Tidak ada materi pembahasan.",
                              style: pw.TextStyle(fontSize: 12),
                            ),
                    ),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 16),

            // Finalized Notes Section
            pw.Text(
              "Kesimpulan",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FixedColumnWidth(40),
                1: pw.FlexColumnWidth(),
                2: pw.FixedColumnWidth(50),
                3: pw.FixedColumnWidth(70),
              },
              children: [
                // Header Row
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'No',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Catatan',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'PIC',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Due Date',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // Data Rows
                ...provider.finalizedList.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  Map<String, dynamic> note = entry.value;
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          index.toString(),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note['catatan'] ?? 'N/A'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          note['pic'] ?? 'N/A',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          note['dueDate'] ?? 'N/A',
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );

    return pdf;
  }

  Future<Uint8List?> getImageBytesFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      print("Error fetching image: $e");
      return null;
    }
  }

  List<DateTime> get meetingDates {
    if (meetingResponse == null || meetingResponse!.data.meetings.isEmpty) {
      return [];
    }

    return meetingResponse!.data.meetings
        .map((meeting) => DateTime.parse(meeting.date))
        .toSet() // Remove duplicates
        .toList();
  }

  void updateAudienceStatus(int audienceId, int newStatus) {
    try {
      for (var meeting in _meetingResponse?.data.meetings ?? []) {
        final audience =
            meeting.audiences.firstWhere((a) => a.id == audienceId);
        audience.status = newStatus;
        notifyListeners();
        break; // Exit once the audience is found and updated
      }
    } catch (e) {
      print("Audience with ID $audienceId not found.");
    }
  }

  // void saveDiscussionMaterial(
  //     quill.QuillController controller, MomsProvider provider) {
  //   final delta = controller.document.toDelta().toJson();
  //   final htmlContent = DeltaToHtmlConverter(delta).convert();
  //   provider.discussionMaterial = htmlContent;
  // }

  Future<pw.Document> generatePdfWithSignature(BuildContext context,
      {required int meetingId}) async {
    final pdf = pw.Document();
    final provider = Provider.of<MomsProvider>(context, listen: false);
    if (_meetingResponse == null || _meetingResponse!.data.meetings.isEmpty) {
      throw Exception(
          "Meeting data is not available. Please ensure it has been fetched.");
    }
    Meeting? meeting;
    for (var item in _meetingResponse!.data.meetings) {
      if (item.id == meetingId) {
        meeting = item;
        break;
      }
    }
    if (meeting == null) {
      throw Exception(
          "No meeting data found for the provided meetingId: $meetingId");
    }
    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo/logo_company.png'))
          .buffer
          .asUint8List(),
    );

    final List<pw.Widget> parsedMaterials = [];
    if (meeting.material != null && meeting.material.isNotEmpty) {
      final cleanedMaterial =
          meeting.material.replaceAll(RegExp(r'["\\]'), '').trim();
      print("Cleaned Material: $cleanedMaterial"); // Log data yang dibersihkan

      final dom.Document htmlDoc = parse(cleanedMaterial);
      print(
          "Parsed HTML: ${htmlDoc.body?.outerHtml}"); // Log hasil parsing HTML

      parsedMaterials.addAll(parseHtmlToPdfWidgets(htmlDoc.body));
    }

    Future<Uint8List?> fetchImageFromUrl(String url) async {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          return response.bodyBytes;
        } else {
          print('Failed to load image, status code: ${response.statusCode}');
          return null;
        }
      } catch (e) {
        print('Error fetching image from URL: $e');
        return null;
      }
    }

// Usage in the PDF generation function
    final List<Uint8List?> signingImages = await Future.wait(
      meeting.audiences
          .where((audience) => audience.representativeSigner == 1)
          .map((audience) async {
        if (audience.representativeSign != null &&
            audience.representativeSign!.isNotEmpty) {
          return await fetchImageFromUrl(audience.representativeSign!);
        }
        return null;
      }).toList(),
    );

    // Page 1: Meeting Details and Finalized Notes
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header with Logo and Title
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  child: pw.Image(logoImage, width: 60, height: 60),
                ),
                pw.Text(
                  "MINUTES OF MEETING",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Author: ${meeting!.author}"),
                    ),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Hari / Tanggal",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(meeting.date),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Waktu",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(meeting.time),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                "Tempat",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(meeting.place),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Agenda"),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(meeting.agenda),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Peserta Rapat"),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: meeting.audiences.map((audience) {
                          return pw.Text(audience.name ?? 'N/A');
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            // MATERI MEETING Section
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 8),
                      child: pw.Center(
                        child: pw.Text(
                          "MATERI MEETING",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: parsedMaterials.isNotEmpty
                          ? pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: parsedMaterials,
                            )
                          : pw.Text(
                              "Tidak ada materi pembahasan.",
                              style: pw.TextStyle(fontSize: 12),
                            ),
                    ),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 16),

            // Finalized Notes Section
            pw.Text(
              "Kesimpulan",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FixedColumnWidth(40), // Adjusts width of "No" column
                1: pw.FlexColumnWidth(), // Expands to fit "Catatan" content
                2: pw.FixedColumnWidth(50), // Adjusts width for "PIC" column
                3: pw.FixedColumnWidth(
                    70), // Adjusts width for "Due Date" column
              },
              children: [
                // Header Row with consistent layout
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'No',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Catatan',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'PIC',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Due Date',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // Data Rows
                ...meeting.notes.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  final note = entry.value;
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(index.toString(),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note.notes ?? 'N/A'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note.pic ?? 'N/A',
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note.dueDate ?? 'N/A',
                            textAlign: pw.TextAlign.center),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
            pw.SizedBox(height: 16),

            // Representative Signers Section
            pw.Text(
              "Diperiksa Oleh",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),

            if (meeting.audiences
                .any((audience) => audience.representativeSigner == 1))
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: meeting.audiences
                    .where((audience) => audience.representativeSigner == 1)
                    .toList()
                    .asMap()
                    .entries
                    .map((entry) {
                  final audience = entry.value;
                  final signatureData = signingImages[entry.key];

                  return pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Text("Diperiksa Oleh,",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text(audience.position ?? '',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 24),
                        pw.Text(
                          audience.name ?? '',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 10),
                        ),
                        pw.Text("NIK: ${audience.nik ?? ''}",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 8),
                        if (signatureData != null)
                          pw.Container(
                            width: 50,
                            height: 50,
                            child: pw.Image(
                              pw.MemoryImage(signatureData),
                              fit: pw.BoxFit.cover,
                            ),
                          )
                        else
                          pw.Text(
                            '.....................................',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              pw.SizedBox(height: 24),
            // Placeholder if no representative signer
          ],
        ),
      ),
    );
    // Generate Attendance Table Rows
    List<pw.TableRow> attendanceRows = [
      // Header Row
      pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text('No',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text('Nama',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text('NIK',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text('Stakeholder',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text('TTD',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
    ];

    // Add Data Rows
    for (int i = 0; i < meeting.audiences.length; i++) {
      final audience = meeting.audiences[i];
      final index = i + 1;

      // Fetch signature data directly using the signing URL
      Uint8List? signatureData;
      if (audience.signing != null && audience.signing!.isNotEmpty) {
        if (audience.signing != null) {
          signatureData = await getImageBytesFromUrl(audience.signing!);
        }
      }

      final qrCodeData = provider.getQrCode(audience.id);

      attendanceRows.add(
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(index.toString()),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(audience.name ?? ''),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(audience.nik ?? ''),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(audience.stakeholder ?? ''),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: signatureData != null
                  ? pw.Center(
                      child: pw.Image(
                        pw.MemoryImage(signatureData),
                        width: 50,
                        height: 50,
                      ),
                    )
                  : qrCodeData != null
                      ? pw.Center(
                          child: pw.BarcodeWidget(
                            barcode: Barcode.qrCode(),
                            data: qrCodeData,
                            width: 50,
                            height: 50,
                          ),
                        )
                      : pw.Text(
                          '.....................................'), // Placeholder for TTD
            ),
          ],
        ),
      );
    }

    // Add pages to PDF
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text(
                "Daftar Hadir Peserta",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 16),

            // Attendance Table
            pw.Table(
              border: pw.TableBorder.all(),
              children: attendanceRows,
            ),
          ],
        ),
      ),
    );

    return pdf;
  }

  void setMeetingData(MeetingData meeting) {
    _meetings.removeWhere((m) => m.id == meeting.id);
    _meetings.add(meeting);
    notifyListeners();
  }

  List<MeetingData> _meetings = []; // List untuk menyimpan semua meeting
  MeetingData? getMeetingData(int meetingId) {
    try {
      return _meetings.firstWhere((meeting) => meeting.id == meetingId);
    } catch (e) {
      return null;
    }
  }

  void addMeetings(List<MeetingData> meetings) {
    _meetings = meetings;
    notifyListeners();
  }

  Future<pw.Document> generatePDF(BuildContext context, int meetingId) async {
    final provider = Provider.of<MomsProvider>(context, listen: false);
    final meetingData = provider.getMeetingData(meetingId);

    if (meetingData == null) {
      throw Exception("Meeting data not found for ID $meetingId");
    }

    final meetingDetails = {
      'Author': meetingData.author,
      'Date': meetingData.date,
      'Time': meetingData.time,
      'Place': meetingData.place,
      'Agenda': meetingData.agenda,
      'Materials': meetingData.material,
    };

    final notes = meetingData.notes.map((note) {
      return {
        'note': note.notes,
        'pic': note.pic ?? '',
        'dueDate': note.dueDate ?? '',
      };
    }).toList();

    final attendanceData = await Future.wait(
      meetingData.audiences.map((audience) async {
        Uint8List? signatureData;
        if (audience.signing != null && audience.signing!.isNotEmpty) {
          signatureData = await fetchImageFromUrl(audience.signing!);
        }

        return {
          'name': audience.name ?? '',
          'nik': audience.nik ?? '',
          'stakeholder': audience.stakeholder ?? '',
          'signatureData': signatureData, // Data gambar tanda tangan
          'status': audience.status,
          'is_present': audience.isPresent,
        };
      }).toList(),
    );

    return PDFHelper.generateDynamicPDFWithSignature(
      title: "Minutes of Meeting",
      meetingDetails: meetingDetails,
      notes: notes,
      attendanceData: attendanceData,
      logoPath: 'assets/images/logo/logo_company.png',
    );
  }

  Future<void> showPdfPreview(BuildContext context,
      {required int meetingId}) async {
    final pdfDocument = await generatePDF(context, meetingId);
    final pdfBytes = await pdfDocument.save();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PdfPreview(
              build: (format) => pdfBytes,
              allowPrinting: true,
              allowSharing: true,
            ),
          ),
        );
      },
    );
  }

  Future<void> showPdfListPreview(BuildContext context,
      {required int meetingId}) async {
    final pdfDocument =
        await generatePdfWithSignature(context, meetingId: meetingId);
    final pdfBytes = await pdfDocument.save();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PdfPreview(
              build: (format) => pdfBytes,
              allowPrinting: true,
              allowSharing: true,
            ),
          ),
        );
      },
    );
  }

  void resetFormData() {
    quill.QuillController _quillController = quill.QuillController.basic();

    _author = '';
    _meetingDate = null;
    _time = null;
    _place = '';
    _agenda = '';
    _finalizedList.clear();
    _selectedEmployees.clear();
    notifyListeners();

    _quillController = quill.QuillController.basic();
  }

  Future<void> createMeeting(
      BuildContext context, int representativeSigner) async {
    try {
      final meetingRequest = MeetingRequest(
        author: _author ?? '',
        date: _meetingDate ?? '',
        time: _time ?? '',
        place: _place ?? '',
        agenda: _agenda ?? '',
        notes: _finalizedList.map((note) {
          return MeetingNote(
            note: note['catatan'] ?? '',
            pic: note['pic'] ?? '',
            dueDate: note['dueDate'] ?? '',
          );
        }).toList(),
        attendees: _selectedEmployees.map((employee) {
          return Attendee(
            nik: employee.nik ?? '',
            signing: '',
            status: 0,
            isPresent: employee.isPresent ?? 0,
            representativeSigner:
                employee.representative_signer ?? representativeSigner,
          );
        }).toList(),
        materials: [
          MaterialDiscuss(
              material: _discussionMaterial), // Tambahkan data materials
        ],
      );

      final response =
          await MomService.createMeetings(context, meetingRequest.toJson());

      if (response.status) {
        SnackToastMessage(context, "Berhasil Buat Meeting", ToastType.success);
        resetFormData();
      } else {
        SnackToastMessage(context, "Gagal Buat Meeting", ToastType.error);
      }
    } catch (e) {
      SnackToastMessage(context, "Gagal Buat Meeting", ToastType.error);
    }
  }

  void saveSignature(int audienceId, Uint8List signatureData, int status) {
    _signatures[audienceId] = signatureData;

    notifyListeners();
  }

  // void setMeetingData(MeetingData meetingData) {
  //   _meetingId = meetingData.id;
  //   _author = meetingData.author;
  //   _meetingDate = meetingData.date;
  //   _time = meetingData.time;
  //   _place = meetingData.place;
  //   _agenda = meetingData.agenda;

  //   // Set data peserta rapat dan catatan rapat
  //   _pesertaRapat = meetingData.audiences;
  //   _catatanRapat = meetingData.notes;

  //   notifyListeners();
  // }

  Future<void> fetchMeetings(
      BuildContext context, ListMeetingRequest request) async {
    final generalProv = Provider.of<GeneralProv>(context, listen: false);
    try {
      _isLoading = true;
      notifyListeners();

      ListMeetingResponse result =
          await MomService.listmeetings(context, request);
      _meetingResponse = result;
      _currentPage = result.data.pagination.currentPage;

      // Clear previous details
      meetingDetails.clear();

      for (var meeting in meetingResponse!.data.meetings) {
        final meetingDate = DateTime.parse(meeting.date);
        final normalizedDate =
            DateTime(meetingDate.year, meetingDate.month, meetingDate.day);

        if (!meetingDetails.containsKey(normalizedDate)) {
          meetingDetails[normalizedDate] = [];
        }

        // Store formatted meeting details
        String meetingInfo = "Place: ${meeting.place ?? 'No place set'}\n"
            "Time: ${meeting.time ?? 'No time set'}\n"
            "Agenda: ${meeting.agenda ?? 'No agenda'}";

        meetingDetails[normalizedDate]!.add(meetingInfo);
      }

      generalProv.dissmisLoading();
    } catch (e) {
      generalProv.dissmisLoading();
      generalProv.instantSendMessage("Error fetching meetings: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextPage(BuildContext context) {
    if (_meetingResponse?.data.pagination.nextPage != null) {
      _currentPage++;
      fetchMeetings(context, ListMeetingRequest(page: _currentPage, size: 10));
    }
  }

  void previousPage(BuildContext context) {
    if (_meetingResponse?.data.pagination.previousPage != null) {
      _currentPage--;
      fetchMeetings(context, ListMeetingRequest(page: _currentPage, size: 10));
    }
  }

  void clearMeetings() {
    _meetingResponse = null;
    qrCodes.clear();
    _signatures.clear();
    notifyListeners();
  }

  int get totalMeetings {
    return meetingResponse?.data.meetings.length ?? 0;
  }

  int get meetingsThisMonth {
    if (meetingResponse == null) return 0;
    return meetingResponse!.data.meetings
        .where((m) => DateTime.parse(m.date).month == DateTime.now().month)
        .length;
  }

  int get meetingsThisWeek {
    if (meetingResponse == null) return 0;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    return meetingResponse!.data.meetings.where((m) {
      final meetingDate = DateTime.parse(m.date);
      return meetingDate.isAfter(startOfWeek) &&
          meetingDate.isBefore(endOfWeek);
    }).length;
  }

  Future<void> signAudience({
    required BuildContext context,
    required int meetingId,
    required int audienceId,
    required int status,
    required Uint8List signatureData,
    required int isPresent,
  }) async {
    setLoading(true);

    SignAudienceRequest request = SignAudienceRequest(
      meetingId: meetingId,
      audienceId: audienceId,
      status: status,
      signatureData: signatureData,
      isPresent: isPresent,
    );

    try {
      signAudienceResponse = await MomService.signAudience(context, request);

      if (signAudienceResponse == null) {
        errorMessage = "Failed to sign audience.";
      } else {
        errorMessage = null;
      }
    } catch (e) {
      errorMessage = "An error occurred: ${e.toString()}";
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }
}
