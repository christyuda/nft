// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';
// import 'package:webordernft/module/mom/provider/manager/list_meetings_provider.dart';
// import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';

// class OnlineSignaturePage extends StatefulWidget {
//   @override
//   _OnlineSignaturePageState createState() => _OnlineSignaturePageState();
// }

// class _OnlineSignaturePageState extends State<OnlineSignaturePage> {
//   late Future<Uint8List> _pdfBytes;

//   @override
//   void initState() {
//     super.initState();

//     // Inisialisasi PDF berdasarkan data dari provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider =
//           Provider.of<ListMeetingsProvider>(context, listen: false);

//       if (provider.meetingId != null) {
//         _pdfBytes = _generatePdf(provider.meetingId!);
//       } else {
//         // Jika meetingId tidak ada, arahkan kembali ke halaman sebelumnya
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Data meeting tidak valid')),
//         );
//       }
//     });
//   }

//   Future<Uint8List> _generatePdf(int meetingId) async {
//     final momsProvider = Provider.of<MomsProvider>(context, listen: false);

//     try {
//       final pdfDocument = await momsProvider.generatePdfWithSignature(
//         context,
//         meetingId: meetingId,
//       );

//       return pdfDocument.save();
//     } catch (e) {
//       throw Exception('Gagal generate PDF: $e');
//     }
//   }

//   Future<void> _handleSign(BuildContext context) async {
//     final provider = Provider.of<ListMeetingsProvider>(context, listen: false);
//     final momsProvider = Provider.of<MomsProvider>(context, listen: false);

//     try {
//       await momsProvider.signAudience(
//         context: context,
//         meetingId: provider.meetingId!,
//         audienceId: provider.audienceId!,
//         status: 3,
//         signatureData: Uint8List(0),
//         isPresent: 1,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Tanda Tangan Berhasil Disimpan!'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Gagal menyimpan tanda tangan: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ListMeetingsProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tanda Tangan Online'),
//         backgroundColor: Colors.blue,
//       ),
//       body: provider.meetingId == null
//           ? Center(child: CircularProgressIndicator())
//           : FutureBuilder<Uint8List>(
//               future: _pdfBytes,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData) {
//                   return Center(
//                       child: Text('Tidak ada data PDF untuk ditampilkan.'));
//                 }

//                 final pdfBytes = snapshot.data!;

//                 return Column(
//                   children: [
//                     // PDF Preview
//                     Expanded(
//                       child: Container(
//                         color: Colors.grey[200],
//                         child: PdfPreview(
//                           build: (format) => pdfBytes,
//                           allowPrinting: true,
//                           allowSharing: true,
//                         ),
//                       ),
//                     ),

//                     // Sign Button
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: ElevatedButton.icon(
//                         onPressed: () => _handleSign(context),
//                         icon: Icon(Icons.qr_code),
//                         label: Text('Tandatangani dengan QR'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           padding: EdgeInsets.symmetric(vertical: 14),
//                           textStyle: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//     );
//   }
// }
