// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:webordernft/common/widget/toast_message.dart';
// import 'package:webordernft/config/palette.dart';
// import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
// import 'package:webordernft/module/mom/service/model/employee_selection.dart';
// import 'package:webordernft/module/mom/service/model/response_listmom.dart';
// import 'package:webordernft/module/mom/view/create_catatan.dart';
// import 'package:webordernft/module/mom/view/search_karyawan.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:webordernft/module/mom/view/signature_dialog.dart';
// import 'dart:typed_data';

// import 'package:webordernft/module/mom/view/signature_list.dart';

// class FormCreateMom extends StatefulWidget {
//   @override
//   State<FormCreateMom> createState() => FormCreateMomState();
// }

// class FormCreateMomState extends State<FormCreateMom> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Buat Meeting",
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w600,
//             color: Palette.primary,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Color(0xFFF6FBFF),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
//         child: FormBuilder(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Text(
//                 //   "Buat Meeting",
//                 //   style: TextStyle(
//                 //     fontSize: 28,
//                 //     fontWeight: FontWeight.w600,
//                 //     color: Colors.black87,
//                 //   ),
//                 // ),
//                 // Row for Author and Hari/Tanggal
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildTextField("Author", "Masukkan nama penulis"),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildDateField(
//                           "Hari / Tanggal", "Pilih hari/tanggal"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 // Row for Waktu and Tempat
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildTimeField("Waktu", "Pilih waktu"),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildTextField("Tempat", "Masukkan tempat rapat"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 // Row for Agenda and Peserta Rapat
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildTextField("Agenda", "Masukkan agenda rapat"),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: _buildParticipantField(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 // Catatan field with "Isi Catatan" button
//                 _buildCatatanField(),
//                 const SizedBox(height: 32),
//                 _buildActionButtons(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildParticipantField() {
//     return FormBuilderTextField(
//       name: "Peserta Rapat",
//       readOnly: true, // Makes the field uneditable but keeps the icons active
//       decoration: InputDecoration(
//         labelText: "Peserta Rapat *",
//         labelStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//         hintText: "Masukkan peserta rapat",
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//         suffixIcon: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.person_search, color: Colors.blue),
//               onPressed: _openSlidingPage,
//             ),
//             IconButton(
//               icon: Icon(Icons.list_alt, color: Colors.blue),
//               onPressed: _showSelectedEmployeesDrawer,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String name, String hint,
//       {int maxLines = 1,
//       bool withModalButton = false,
//       bool enabled = true,
//       VoidCallback? onModalButtonPressed,
//       bool withViewParticipantsButton = false}) {
//     return FormBuilderTextField(
//       enabled: enabled,
//       name: name,
//       decoration: InputDecoration(
//         labelText: "$name *",
//         labelStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//         suffixIcon: withModalButton
//             ? Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.person_search, color: Colors.blue),
//                     onPressed: onModalButtonPressed,
//                   ),
//                   if (withViewParticipantsButton)
//                     IconButton(
//                       icon: Icon(Icons.list_alt, color: Colors.blue),
//                       onPressed: _showSelectedEmployeesDrawer,
//                     ),
//                 ],
//               )
//             : null,
//       ),
//       maxLines: maxLines,
//       validator: FormBuilderValidators.compose([
//         FormBuilderValidators.required(),
//       ]),
//     );
//   }

//   Widget _buildDateField(String name, String hint) {
//     return FormBuilderDateTimePicker(
//       name: name,
//       inputType: InputType.date,
//       decoration: InputDecoration(
//         labelText: "$name *",
//         labelStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       ),
//       validator: FormBuilderValidators.required(),
//     );
//   }

//   Widget _buildTimeField(String name, String hint) {
//     return FormBuilderDateTimePicker(
//       name: name,
//       inputType: InputType.time,
//       decoration: InputDecoration(
//         labelText: "$name *",
//         labelStyle: TextStyle(
//           color: Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       ),
//       validator: FormBuilderValidators.required(),
//     );
//   }

//   Widget _buildCatatanField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Catatan *",
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 255, 255, 255),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: Center(
//             child:
//                 _buildIconOption("Isi Catatan", Icons.edit, _openCatatanEditor),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildIconOption(String label, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(40),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[300]!),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Icon(
//               icon,
//               size: 24,
//               color: Colors.black54,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         // ElevatedButton(
//         //   onPressed: () async {
//         //     final provider = Provider.of<MomsProvider>(context, listen: false);
//         //     provider.author = _formKey.currentState?.fields['Author']?.value;
//         //     final DateTime? selectedDate =
//         //         _formKey.currentState?.fields['Hari / Tanggal']?.value;
//         //     provider.meetingDate = selectedDate != null
//         //         ? DateFormat('yyyy-MM-dd').format(selectedDate)
//         //         : null;

//         //     // Format TimeOfDay for the time
//         //     final DateTime? selectedDateTime =
//         //         _formKey.currentState?.fields['Waktu']?.value;
//         //     provider.time = selectedDateTime != null
//         //         ? DateFormat('hh:mm a').format(selectedDateTime)
//         //         : null;
//         //     provider.place = _formKey.currentState?.fields['Tempat']?.value;
//         //     provider.agenda = _formKey.currentState?.fields['Agenda']?.value;

//         //     print("Author: ${provider.author}");
//         //     print("Meeting Date: ${provider.meetingDate}");
//         //     print("Time: ${provider.time}");
//         //     print("Place: ${provider.place}");
//         //     print("Agenda: ${provider.agenda}");
//         //     print("Selected Employees: ${provider.selectedEmployees}");
//         //     print("Catatan List: ${provider.catatanList}");
//         //     print("Finalized List: ${provider.finalizedList}");

//         //     // Validasi data sebelum pratinjau
//         //     if (provider.author == null ||
//         //         provider.meetingDate == null ||
//         //         provider.time == null ||
//         //         provider.place == null ||
//         //         provider.agenda == null ||
//         //         provider.selectedEmployees.isEmpty ||
//         //         provider.finalizedList.isEmpty) {
//         //       ScaffoldMessenger.of(context).showSnackBar(
//         //         SnackBar(
//         //             content: Text("Lengkapi semua data sebelum pratinjau PDF")),
//         //       );
//         //       return;
//         //     }

//         //     // Show PDF preview through the provider method
//         //     await provider.showPdfPreview(context);
//         //   },
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: Colors.blue,
//         //     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
//         //     shape: RoundedRectangleBorder(
//         //       borderRadius: BorderRadius.circular(8),
//         //     ),
//         //   ),
//         //   child: Text(
//         //     "Pratinjau",
//         //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//         //   ),
//         // ),
//         // const SizedBox(width: 16),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     _showSelectedEmployeesDrawerSign();
//         //   },
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: Colors.blue,
//         //     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
//         //     shape: RoundedRectangleBorder(
//         //       borderRadius: BorderRadius.circular(8),
//         //     ),
//         //   ),
//         //   child: Text(
//         //     "Tandatangani",
//         //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//         //   ),
//         // ),
//         ElevatedButton(
//           onPressed: () async {
//             final provider = Provider.of<MomsProvider>(context, listen: false);

//             if (_formKey.currentState?.saveAndValidate() ?? false) {
//               provider.author = _formKey.currentState?.fields['Author']?.value;
//               final DateTime? selectedDate =
//                   _formKey.currentState?.fields['Hari / Tanggal']?.value;
//               provider.meetingDate = selectedDate != null
//                   ? DateFormat('yyyy-MM-dd').format(selectedDate)
//                   : null;

//               // Format TimeOfDay for the time
//               final DateTime? selectedDateTime =
//                   _formKey.currentState?.fields['Waktu']?.value;
//               provider.time = selectedDateTime != null
//                   ? DateFormat('hh:mm a').format(selectedDateTime)
//                   : null;
//               provider.place = _formKey.currentState?.fields['Tempat']?.value;
//               provider.agenda = _formKey.currentState?.fields['Agenda']?.value;

//               await provider.createMeeting(context);
//               if (provider.isSubmitting == false) {
//                 _formKey.currentState?.reset();

//                 provider.resetFormData();
//               } else {
//                 SnackToastMessage(context,
//                     "Gagal membuat rapat. Silakan coba lagi.", ToastType.error);
//               }
//             }
//           },
//           child: Text(
//             'Buat Rapat',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//             padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   void _showSelectedEmployeesDrawer() {
//     final employeeProvider = Provider.of<MomsProvider>(context, listen: false);

//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return GestureDetector(
//             onTap: () => Navigator.pop(context),
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
//                               itemCount:
//                                   employeeProvider.selectedEmployees.length,
//                               itemBuilder: (context, index) {
//                                 final employee =
//                                     employeeProvider.selectedEmployees[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0, vertical: 8.0),
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       side: BorderSide(
//                                         color: Colors
//                                             .grey.shade300, // Warna border
//                                         width: 1, // Ketebalan border
//                                       ),
//                                     ),
//                                     elevation: 0, // Menghilangkan shadow
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Nama Peserta",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.blueAccent,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           _buildInfoRow(
//                                               "Nama", employee.name ?? 'N/A'),
//                                           _buildInfoRow(
//                                               "NIK", employee.nik ?? 'N/A'),
//                                           _buildInfoRow("Position",
//                                               employee.position ?? 'N/A'),
//                                           _buildInfoRow("Stakeholder",
//                                               employee.stakeholder ?? 'N/A'),
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
//           const begin = Offset(1.0, 0.0); // Muncul dari kanan
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

//   void _showSelectedEmployeesDrawerSign() {
//     final employeeProvider = Provider.of<MomsProvider>(context, listen: false);

//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return GestureDetector(
//             onTap: () => Navigator.pop(context),
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
//                               itemCount:
//                                   employeeProvider.selectedEmployees.length,
//                               itemBuilder: (context, index) {
//                                 final employee =
//                                     employeeProvider.selectedEmployees[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0, vertical: 8.0),
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       side: BorderSide(
//                                         color: Colors
//                                             .grey.shade300, // Border color
//                                         width: 1, // Border thickness
//                                       ),
//                                     ),
//                                     elevation: 0, // No shadow
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Nama Peserta",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.blueAccent,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           _buildInfoRow(
//                                               "Nama", employee.name ?? 'N/A'),
//                                           _buildInfoRow(
//                                               "NIK", employee.nik ?? 'N/A'),
//                                           _buildInfoRow("Position",
//                                               employee.position ?? 'N/A'),
//                                           _buildInfoRow("Stakeholder",
//                                               employee.stakeholder ?? 'N/A'),
//                                           const SizedBox(height: 8),
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: ElevatedButton(
//                                               onPressed: () {
//                                                 _showSignatureDialog(employee);
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 8,
//                                                     horizontal: 16),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 "Tanda Tangani",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
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
//           const begin = Offset(1.0, 0.0); // Slide in from the right
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

// // Helper method to open the signature dialog
//   void _showSignatureDialog(EmployeeSelection employee) {
//     showDialog(
//       context: context,
//       builder: (context) => SignatureDialog(employee: employee),
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

//   void _openSlidingPage() {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             SearchKaryawan(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;
//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//       ),
//     );
//   }

//   void _openCatatanEditor() {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             CatatanEditorPage(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;
//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//       ),
//     );
//   }
// }

// void _showConfirmSignatureDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Konfirmasi"),
//         content: Text("Apakah Anda yakin untuk menandatangani?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Close dialog
//             child: Text("Tidak"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the dialog
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignatureListPage()),
//               );
//             },
//             child: Text("Ya"),
//           ),
//         ],
//       );
//     },
//   );
// }
