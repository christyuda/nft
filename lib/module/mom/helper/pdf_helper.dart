import 'package:barcode/barcode.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:webordernft/module/mom/service/model/list_audiences_response.dart';

class PDFHelper {
  static Future<pw.Document> generateDynamicPDFWithSignature({
    required String title,
    required Map<String, String> meetingDetails,
    required List<Map<String, String>> notes,
    required List<Map<String, dynamic>> attendanceData,
    String? logoPath,
  }) async {
    final pdf = pw.Document();

    // Load logo if path is provided
    pw.ImageProvider? logoImage;
    if (logoPath != null) {
      final logoBytes = await rootBundle.load(logoPath);
      logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());
    }
    final absentees = attendanceData
        .where((attendee) =>
            attendee['status'] == 0 && attendee['is_present'] == 0)
        .toList();

    print("Filtered Absentees: $absentees");

    // Add meeting details with structure
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logoImage != null)
                  pw.Container(
                    child: pw.Image(logoImage, width: 60, height: 60),
                  ),
                pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Meeting details table
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Row for Author and Nested Table for Date, Time, Place
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child:
                          pw.Text("Author: ${meetingDetails['Author'] ?? ''}"),
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
                              child: pw.Text(meetingDetails['Date'] ?? ''),
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
                              child: pw.Text(meetingDetails['Time'] ?? ''),
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
                              child: pw.Text(meetingDetails['Place'] ?? ''),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // Materi Pembahasan Section

                // Row for Agenda
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        "Agenda",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(meetingDetails['Agenda'] ?? ''),
                    ),
                  ],
                ),
                // Row for Participants
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        "Peserta Rapat",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: attendanceData.map((attendee) {
                          return pw.Text(attendee['name'] ?? 'N/A');
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Row for Absentees

// Add "Berhalangan Hadir" row to the PDF
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        "Berhalangan Hadir",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: absentees.map((absentee) {
                          return pw.Text(absentee['name'] ?? 'N/A');
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 16),

            // Finalized notes section
            pw.Text(
              "Kesimpulan",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16),

            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FixedColumnWidth(40),
                1: pw.FlexColumnWidth(),
                2: pw.FixedColumnWidth(50),
                3: pw.FixedColumnWidth(70),
              },
              children: [
                // Header row
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
                // Data rows
                ...notes.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  final note = entry.value;
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(index.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note['note'] ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note['pic'] ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(note['dueDate'] ?? ''),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            pw.SizedBox(height: 16),

            pw.Text(
              "Diperiksa Oleh",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: attendanceData
                  .where((attendee) =>
                      attendee['representative_signer'] == '0' ||
                      attendee['representative_signer'] == '1')
                  .map((attendee) => pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Text("Diperiksa Oleh,",
                                style: pw.TextStyle(fontSize: 10)),
                            pw.Text(attendee['position'] ?? '',
                                style: pw.TextStyle(fontSize: 10)),
                            pw.SizedBox(height: 24),
                            pw.Text(
                              attendee['name'] ?? '',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 10),
                            ),
                            pw.Text("NIK: ${attendee['nik'] ?? ''}",
                                style: pw.TextStyle(fontSize: 10)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            pw.SizedBox(height: 16),

            // Attendance section
          ],
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Daftar Hadir Peserta",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10), // Tambahkan jarak
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FixedColumnWidth(40),
                1: pw.FlexColumnWidth(),
                2: pw.FixedColumnWidth(100),
                3: pw.FlexColumnWidth(),
                4: pw.FixedColumnWidth(80),
              },
              children: [
                // Header row
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("No",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Nama",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("NIK",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("Stakeholder",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text("TTD",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                // Data rows
                ...attendanceData.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  final attendee = entry.value;

                  // Ambil nilai signing dan status
                  final signing = attendee['signing'];
                  final status = attendee['status'];

                  // Generate QR Data
                  final String currentDate =
                      DateFormat('dd-MM-yyyy', 'id_ID').format(DateTime.now());
                  final String qrData = """
                    --- Tanda Tangan QR ---
                    Nama       : ${attendee['name']}
                    NIK        : ${attendee['nik']}
                    Posisi     : ${attendee['position']}
                    Stakeholder: ${attendee['stakeholder']}
                    Status     : Tertandatangani
                    Tanggal    : $currentDate
                    """;

                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(index.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(attendee['name'] ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(attendee['nik'] ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(attendee['stakeholder'] ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: attendee['signatureData'] != null
                            ? (status == 1
                                ? pw.Center(
                                    child: pw.Image(
                                      pw.MemoryImage(attendee['signatureData']),
// Tampilkan gambar TTD
                                      width: 150,
                                      height: 150,
                                    ),
                                  )
                                : (status == 2
                                    ? pw.Center(
                                        child: pw.BarcodeWidget(
                                          barcode: Barcode.qrCode(),
                                          data: qrData, // Data untuk QR code
                                          width: 150,
                                          height: 150,
                                        ),
                                      )
                                    : pw.Text(
                                        '...'))) // Placeholder jika status tidak sesuai
                            : pw.Text('...'), // Placeholder jika signing null
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
