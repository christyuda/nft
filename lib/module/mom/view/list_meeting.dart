// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:barcode/barcode.dart';
// import 'package:flutter/material.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:provider/provider.dart';
// import 'package:signature/signature.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:webordernft/config/palette.dart';
// import 'package:webordernft/config/sizeconf.dart';
// import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
// import 'package:webordernft/module/mom/service/model/pin_listmeetings.dart';
// import 'package:webordernft/module/mom/service/model/response_listmeetings.dart';
// import 'package:barcode_widget/barcode_widget.dart';

// class MeetingListPage extends StatefulWidget {
//   const MeetingListPage({Key? key}) : super(key: key);

//   @override
//   State<MeetingListPage> createState() => _MeetingListPageState();
// }

// class _MeetingListPageState extends State<MeetingListPage> {
//   final _keyListMeeting = GlobalKey<FormBuilderState>();

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<MomsProvider>(context, listen: false).fetchMeetings(
//       context,
//       ListMeetingRequest(page: 1, size: 10),
//     );
//   }

//   void _showSelectedEmployeesDrawerSign(List<Audience> audiences) {
//     final provider = Provider.of<MomsProvider>(context, listen: false);

//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return GestureDetector(
//             onTap: () {
//               provider.clearAll(); // Clear QR codes and signatures on close
//               Navigator.pop(context);
//             },
//             child: Stack(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       color: Colors.white,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Peserta Rapat Terpilih",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.close),
//                                   onPressed: () => Navigator.pop(context),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: audiences.length,
//                               itemBuilder: (context, index) {
//                                 final audience = audiences[index];
//                                 Color buttonColor;
//                                 String buttonText;

//                                 // Determine button color and text based on status
//                                 if (audience.status == 1) {
//                                   buttonColor = Colors.green;
//                                   buttonText = "Sudah Ditandatangani";
//                                 } else if (audience.status == 2) {
//                                   buttonColor = Colors.green;
//                                   buttonText = "Ditandatangani QR Code";
//                                 } else {
//                                   buttonColor = Palette.primary;
//                                   buttonText = "Tanda Tangani";
//                                 }

//                                 // Generate QR Data if status is 2
//                                 String qrData = '';
//                                 if (audience.status == 2) {
//                                   String currentDate = DateFormat('dd-MM-yyyy')
//                                       .format(DateTime.now());
//                                   qrData = """
//                                   --- Tanda Tangan QR ---
//                                   Nama       : ${audience.name}
//                                   NIK        : ${audience.nik}
//                                   Posisi     : ${audience.position}
//                                   Stakeholder: ${audience.stakeholder}
//                                   Status     : Tertandatangani
//                                   Tanggal    : $currentDate
//                                   """; // Add more data as needed
//                                 }

//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0, vertical: 8.0),
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       side: BorderSide(
//                                         color: Colors.grey.shade300,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     elevation: 0,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           // Participant Information on the left
//                                           Expanded(
//                                             flex: 2,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Nama Peserta",
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.blueAccent,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 8),
//                                                 _buildInfoRow("Nama",
//                                                     audience.name ?? 'N/A'),
//                                                 _buildInfoRow("NIK",
//                                                     audience.nik ?? 'N/A'),
//                                                 _buildInfoRow("Position",
//                                                     audience.position ?? 'N/A'),
//                                                 _buildInfoRow(
//                                                     "Stakeholder",
//                                                     audience.stakeholder ??
//                                                         'N/A'),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 if (audience.status == 2 &&
//                                                     qrData.isNotEmpty)
//                                                   BarcodeWidget(
//                                                     barcode: Barcode.qrCode(),
//                                                     data: qrData,
//                                                     width: 150,
//                                                     height: 150,
//                                                     color: Colors.black,
//                                                   ),
//                                                 const SizedBox(
//                                                     height:
//                                                         12), // Space between QR code and button
//                                                 Column(
//                                                   children: [
//                                                     ElevatedButton(
//                                                       onPressed: (audience
//                                                                   .status ==
//                                                               0)
//                                                           ? () {
//                                                               _showSignatureOptionsDialog(
//                                                                   context,
//                                                                   audience);
//                                                             }
//                                                           : null, // Disable button if status is 1, 2, or 3
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                         backgroundColor:
//                                                             buttonColor, // Set the background color as buttonColor
//                                                         disabledBackgroundColor:
//                                                             buttonColor, // Ensure disabled background color stays the same
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 8,
//                                                                 horizontal: 16),
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(8),
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         buttonText,
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: ElevatedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 14, horizontal: 28),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Tutup",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOut;
//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           return SlideTransition(
//             position: animation.drive(tween),
//             child: child,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "$label: ",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//               color: Colors.black87,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSignatureOptionsDialog(BuildContext context, Audience audience) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Palette.bgcolor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Center(
//             child: Sz.headline5(context, "Pilih Metode Tanda Tangan",
//                 TextAlign.center, Colors.black),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Sz.subtitle(
//                   context,
//                   "Pilih metode untuk menandatangani dokumen ini.",
//                   TextAlign.center,
//                   Palette.primary),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildSignatureOption(
//                     context: context,
//                     icon: Icons.draw,
//                     label: "Tanda Tangan Manual",
//                     onTap: () {
//                       Navigator.pop(context);
//                       _showSignatureDialog(audience);
//                     },
//                   ),
//                   SizedBox(width: 12),
//                   _buildSignatureOption(
//                     context: context,
//                     icon: Icons.qr_code,
//                     label: "Tanda Tangan QR Code",
//                     onTap: () {
//                       Navigator.pop(context);
//                       _generateQrSignaturePreview(audience);
//                     },
//                   ),
//                   SizedBox(width: 12),
//                   _buildSignatureOption(
//                     context: context,
//                     icon: Icons.cloud,
//                     label: "Tanda Tangan Online",
//                     onTap: () {
//                       Navigator.pop(context);
//                       // Add online signature function here
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSignatureOption({
//     required BuildContext context,
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         width: 150,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Palette.bgcolor, width: 1.5),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 28, color: Palette.blackClr),
//             const SizedBox(height: 8),
//             Sz.bodyText(context, label, TextAlign.center, Colors.black),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSignatureDialog(Audience audience) {
//     final provider = Provider.of<MomsProvider>(context, listen: false);
//     final meetingId = provider.meetingResponse?.data.meetings
//         .firstWhere((meeting) => meeting.audiences.contains(audience))
//         .id;

//     if (meetingId == null) {
//       print("Meeting ID not found for the audience");
//       return;
//     }

//     final SignatureController _signatureController = SignatureController(
//       penStrokeWidth: 6,
//       penColor: Colors.black,
//     );

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey[200],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Center(
//             child: Text(
//               "Tanda Tangan untuk ${audience.name}",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           content: SizedBox(
//             width: double.maxFinite,
//             height: MediaQuery.of(context).size.height * 0.7,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Signature(
//                     controller: _signatureController,
//                     backgroundColor: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSignatureButton(
//                       context: context,
//                       label: "Clear",
//                       icon: Icons.clear,
//                       color: Colors.red,
//                       onTap: () {
//                         _signatureController.clear();
//                       },
//                     ),
//                     _buildSignatureButton(
//                       context: context,
//                       label: "Save",
//                       icon: Icons.check,
//                       color: Colors.green,
//                       onTap: () async {
//                         if (_signatureController.isNotEmpty) {
//                           final Uint8List? signatureData =
//                               await _signatureController.toPngBytes();
//                           if (signatureData != null) {
//                             provider.signAudience(
//                               context: context,
//                               meetingId: meetingId,
//                               audienceId: audience.id,
//                               status: 1,
//                               signatureData: signatureData,
//                               isPresent: 1,
//                             );
//                           }
//                         }
//                         setState(() {
//                           final meetingIndex = provider
//                               .meetingResponse?.data.meetings
//                               .indexWhere((meeting) => meeting.id == meetingId);

//                           if (meetingIndex != null && meetingIndex >= 0) {
//                             final audienceIndex = provider.meetingResponse?.data
//                                 .meetings[meetingIndex].audiences
//                                 .indexWhere((a) => a.id == audience.id);

//                             if (audienceIndex != null && audienceIndex >= 0) {
//                               final updatedAudience = Audience(
//                                 id: audience.id,
//                                 name: audience.name,
//                                 nik: audience.nik,
//                                 position: audience.position,
//                                 stakeholder: audience.stakeholder,
//                                 status: 1,
//                               );

//                               provider
//                                   .meetingResponse
//                                   ?.data
//                                   .meetings[meetingIndex]
//                                   .audiences[audienceIndex] = updatedAudience;
//                             }
//                           }
//                         });

//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             Center(
//               child: TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _generateQrSignaturePreview(Audience audience) async {
//     final provider = Provider.of<MomsProvider>(context, listen: false);
//     final meetingId = provider.meetingResponse?.data.meetings
//         .firstWhere((meeting) => meeting.audiences.contains(audience))
//         .id;

//     if (meetingId == null) {
//       print("Meeting ID not found for the audience");
//       return;
//     }
//     // Generate QR data string
//     String currentDate =
//         DateFormat('dd-MM-yyyy', 'id_ID').format(DateTime.now());
//     String qrData = """
//   --- Tanda Tangan QR ---
//   Nama       : ${audience.name}
//   NIK        : ${audience.nik}
//   Posisi     : ${audience.position}
//   Stakeholder: ${audience.stakeholder}
//   Status     : Tertandatangani
//   Tanggal    : $currentDate
//   """;

//     // Set the QR code data in the provider (optional)
//     provider.setQrCode(audience.id, qrData);

//     // Generate the QR code image
//     final qrCodePainter = QrPainter(
//       data: qrData,
//       version: QrVersions.auto,
//       gapless: false,
//       color: const Color(0xFF000000),
//     );

//     final image = await qrCodePainter.toImage(300);
//     final byteData = await image.toByteData(format: ImageByteFormat.png);
//     if (byteData != null) {
//       final Uint8List imageData = byteData.buffer.asUint8List();

//       provider.signAudience(
//         context: context,
//         meetingId: meetingId,
//         audienceId: audience.id,
//         status: 2,
//         signatureData: imageData,
//         isPresent: 1,
//       );

//       print("QR code signature saved for audience with ID: ${audience.id}");
//     } else {
//       print("Failed to generate QR code image");
//     }
//   }

//   Widget _buildSignatureButton({
//     required BuildContext context,
//     required String label,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         foregroundColor: color,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         elevation: 0, // No shadow for a softer look
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18),
//           const SizedBox(width: 6),
//           Sz.subtitle(context, label, TextAlign.center, color),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final meetingProvider = Provider.of<MomsProvider>(context);
//     final meetingResponse = meetingProvider.meetingResponse;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("List of Meetings"),
//         backgroundColor: Palette.bgcolor,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: meetingResponse == null
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Total Records: ${meetingResponse.data.pagination.totalRecords}",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Expanded(
//                     child: DataTable2(
//                       columnSpacing: 12,
//                       horizontalMargin: 12,
//                       minWidth: 800,
//                       headingRowColor: MaterialStateProperty.all<Color>(
//                         Palette.bgcolor,
//                       ),
//                       headingTextStyle: TextStyle(
//                         color: Palette.primary,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       columns: [
//                         DataColumn2(
//                           label: Text("No"),
//                           size: ColumnSize.S,
//                         ),
//                         DataColumn2(
//                           label: Text("Author"),
//                           size: ColumnSize.L,
//                         ),
//                         DataColumn2(
//                           label: Text("Date"),
//                           size: ColumnSize.M,
//                         ),
//                         DataColumn2(
//                           label: Text("Created At"),
//                           size: ColumnSize.M,
//                         ),
//                         DataColumn2(
//                           label: Text("Time"),
//                           size: ColumnSize.S,
//                         ),
//                         DataColumn2(
//                           label: Text("Place"),
//                           size: ColumnSize.L,
//                         ),
//                         DataColumn2(
//                           label: Text("Agenda"),
//                           size: ColumnSize.L,
//                         ),
//                         DataColumn(
//                           label: Text("Actions"),
//                         ),
//                       ],
//                       rows: meetingResponse.data.meetings.map((meeting) {
//                         return DataRow(cells: [
//                           DataCell(Text(
//                               (meetingResponse.data.meetings.indexOf(meeting) +
//                                       1)
//                                   .toString())),
//                           DataCell(Text(meeting.author)),
//                           DataCell(Text(meeting.date)),
//                           DataCell(Text(meeting.createAt)),
//                           DataCell(Text(meeting.time)),
//                           DataCell(Text(meeting.place)),
//                           DataCell(Text(meeting.agenda)),
//                           DataCell(Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.remove_red_eye,
//                                     color: Colors.blue),
//                                 onPressed: () async {
//                                   await Provider.of<MomsProvider>(context,
//                                           listen: false)
//                                       .showPdfPreview(context,
//                                           meetingId: meeting.id);
//                                 },
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.edit, color: Colors.green),
//                                 onPressed: () {
//                                   _showSelectedEmployeesDrawerSign(
//                                       meeting.audiences);
//                                 },
//                               ),
//                             ],
//                           )),
//                         ]);
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
