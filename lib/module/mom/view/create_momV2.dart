import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:webordernft/common/widget/toast_message.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
import 'package:webordernft/module/mom/view/discussion_material.dart';
import 'package:webordernft/module/mom/view/search_karyawan.dart';
import 'package:webordernft/module/mom/view/sliding_panel_employee.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class CreateMomV2 extends StatefulWidget {
  @override
  _CreateMomV2State createState() => _CreateMomV2State();
}

class _CreateMomV2State extends State<CreateMomV2>
    with TickerProviderStateMixin {
  final HtmlEditorController _htmlEditorController = HtmlEditorController();

  Timer? _debounce;

  final _formKey = GlobalKey<FormBuilderState>();
  bool isRightColumnVisible = false;
  bool isEditable = false;

  Future<Uint8List>? pdfFuture;
  late AnimationController _animationController;
  void _saveDiscussionMaterial() async {
    final provider = Provider.of<MomsProvider>(context, listen: false);
    final String? content = await _htmlEditorController.getText();
    if (content != null && content.isNotEmpty) {
      provider.discussionMaterial = content;
    } else {
      provider.discussionMaterial = '';
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isRightColumnVisible) {
        final provider = Provider.of<MomsProvider>(context, listen: false);
        provider.author = _formKey.currentState?.fields['Author']?.value;
        final DateTime? selectedDate =
            _formKey.currentState?.fields['Hari / Tanggal']?.value;
        provider.meetingDate = selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate)
            : null;
        final DateTime? selectedDateTime =
            _formKey.currentState?.fields['Waktu']?.value;
        provider.time = selectedDateTime != null
            ? DateFormat('hh:mm a').format(selectedDateTime)
            : null;
        provider.place = _formKey.currentState?.fields['Tempat']?.value;
        provider.agenda = _formKey.currentState?.fields['Agenda']?.value;
        final String discussionMaterial = provider.discussionMaterial ?? '';
        if (discussionMaterial.isNotEmpty) {
          print("Discussion Material: $discussionMaterial");
        }

        pdfFuture = provider.generatePreview(context).then((pdf) => pdf.save());
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _toggleRightColumn() {
    setState(() {
      isRightColumnVisible = !isRightColumnVisible;
    });

    // Mulai animasi setelah mengubah status kolom kanan
    if (isRightColumnVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
      pdfFuture = null; // Kosongkan PDF saat kolom ditutup
    }
  }

  void _toggleEditable() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final catatanProvider = Provider.of<MomsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Buat MOM"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Palette.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left Column
            Expanded(
              flex: isRightColumnVisible ? 3 : 5,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildTabItem("Meeting"),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.list_alt),
                              color: Palette.momsecondary,
                              onPressed: () {
                                _showSelectedEmployeesDrawer(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              color: Palette.momsecondary,
                              onPressed: () {
                                _toggleRightColumn();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // FormBuilder Form in Left Column
                        Expanded(
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: _buildLabeledField(
                                          "Penulis *",
                                          _buildCustomTextField(
                                            name: 'Author',
                                            hintText: 'Masukkan nama penulis',
                                            suffixIcon: Icons.info_outline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: _buildLabeledField(
                                          "Hari / Tanggal *",
                                          _buildCustomTextField(
                                            name: 'Hari / Tanggal',
                                            hintText: 'Pilih hari / tanggal',
                                            suffixIcon: Icons.calendar_today,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: _buildLabeledField(
                                          "Waktu *",
                                          _buildCustomTextField(
                                            name: 'Waktu',
                                            hintText: 'Masukkan jam',
                                            suffixIcon: Icons.access_time,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: _buildLabeledField(
                                          "Tempat Rapat *",
                                          _buildCustomTextField(
                                            name: 'Tempat',
                                            hintText: 'Masukkan tempat rapat',
                                            suffixIcon: Icons.location_on,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: _buildLabeledField(
                                          "Agenda *",
                                          _buildCustomTextField(
                                            name: 'Agenda',
                                            hintText: 'Masukkan agenda rapat',
                                            suffixIcon: Icons.event_note,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: _buildLabeledField(
                                          "Peserta Rapat *",
                                          _buildParticipantField(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Stack(
                                //       children: [
                                //         Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               "Materi Pembahasan *",
                                //               style: TextStyle(
                                //                 color: Colors.black87,
                                //                 fontWeight: FontWeight.w500,
                                //                 fontSize: 16,
                                //               ),
                                //             ),
                                //             const SizedBox(height: 8),
                                //             Container(
                                //               padding: EdgeInsets.all(16),
                                //               decoration: BoxDecoration(
                                //                 color: Colors.white,
                                //                 borderRadius:
                                //                     BorderRadius.circular(8),
                                //                 border: Border.all(
                                //                     color: Colors.grey[300]!),
                                //               ),
                                //               child: SizedBox(
                                //                 height:
                                //                     350, // Tinggi area editor
                                //                 child: SingleChildScrollView(
                                //                   child: HtmlEditor(
                                //                     htmlToolbarOptions:
                                //                         HtmlToolbarOptions(
                                //                             toolbarPosition:
                                //                                 ToolbarPosition
                                //                                     .belowEditor,
                                //                             toolbarType: ToolbarType
                                //                                 .nativeScrollable),
                                //                     controller:
                                //                         _htmlEditorController,
                                //                     htmlEditorOptions:
                                //                         HtmlEditorOptions(
                                //                             hint:
                                //                                 "Isi Materi Pembahasan di sini...",
                                //                             shouldEnsureVisible:
                                //                                 true,
                                //                             adjustHeightForKeyboard:
                                //                                 true,
                                //                             autoAdjustHeight:
                                //                                 false),
                                //                     otherOptions: OtherOptions(
                                //                       height: 300,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             const SizedBox(height: 16),
                                //             ElevatedButton(
                                //               onPressed:
                                //                   _saveDiscussionMaterial,
                                //               child: Text(
                                //                 "Simpan Materi",
                                //                 style: TextStyle(
                                //                     color: Colors.white),
                                //               ),
                                //               style: ElevatedButton.styleFrom(
                                //                 backgroundColor:
                                //                     Palette.primary,
                                //                 padding: EdgeInsets.symmetric(
                                //                     vertical: 14,
                                //                     horizontal: 28),
                                //                 shape: RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.circular(8),
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                _DiscussionSection(
                                  htmlEditorController: _htmlEditorController,
                                  saveDiscussionMaterial:
                                      _saveDiscussionMaterial,
                                ),
                                SizedBox(height: 24),
                                // Insert this code in the _CreateMomV2State's build method, below the "Materi Pembahasan" section

                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title for "Kesimpulan" section
                                      Text(
                                        "Kesimpulan *",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Section for adding a new note
                                      TextField(
                                        controller:
                                            catatanProvider.catatanController,
                                        decoration: InputDecoration(
                                          labelText: "Tambah Kesimpulan",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          hintText:
                                              "Tuliskan Kesimpulan di sini...",
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 10),

                                      // Button to add the new note to the final list
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            final newCatatan = {
                                              'catatan': catatanProvider
                                                  .catatanController.text,
                                              'pic': '', // Default PIC value
                                              'dueDate':
                                                  '', // Default Due Date value
                                            };
                                            catatanProvider
                                                .addCatatanToFinalized(
                                                    newCatatan);
                                            catatanProvider.catatanController
                                                .clear(); // Clear the text field after adding
                                          },
                                          child: Text(
                                            "Tambahkan Catatan",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Palette.primary,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          child: DataTable(
                                            columnSpacing:
                                                12, // Reduce the spacing between columns
                                            columns: [
                                              // Narrower "No" column
                                              DataColumn(
                                                label: SizedBox(
                                                  width:
                                                      30, // Adjust width for the "No" column
                                                  child: Text('No'),
                                                ),
                                              ),
                                              DataColumn(
                                                  label: Text('Catatan')),

                                              // "PIC" column
                                              DataColumn(
                                                label: SizedBox(
                                                  width:
                                                      100, // Adjust the width to keep it compact
                                                  child: Text('PIC'),
                                                ),
                                              ),

                                              // "Due Date" column
                                              DataColumn(
                                                label: SizedBox(
                                                  width:
                                                      100, // Adjust width for better visibility of "Edit" icon
                                                  child: Text('Due Date'),
                                                ),
                                              ),

                                              // Narrower "Actions" column
                                              DataColumn(
                                                label: SizedBox(
                                                  width:
                                                      60, // Adjust width for the "Actions" column
                                                  child: Text('Actions'),
                                                ),
                                              ),
                                            ],
                                            rows: List<DataRow>.generate(
                                              catatanProvider
                                                  .finalizedList.length,
                                              (index) {
                                                final catatan = catatanProvider
                                                    .finalizedList[index];
                                                return DataRow(
                                                  cells: [
                                                    // Compact "No" cell
                                                    DataCell(SizedBox(
                                                      width: 30,
                                                      child:
                                                          Text('${index + 1}'),
                                                    )),

                                                    // "Catatan" cell
                                                    DataCell(Text(
                                                        catatan['catatan'] ??
                                                            '')),

                                                    // Editable "PIC" cell
                                                    DataCell(
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              catatan['pic']
                                                                      .isNotEmpty
                                                                  ? catatan[
                                                                      'pic']
                                                                  : 'Edit PIC',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .blue),
                                                            onPressed: () {
                                                              _showEditDialog(
                                                                context:
                                                                    context,
                                                                title:
                                                                    "Edit PIC",
                                                                initialValue:
                                                                    catatan[
                                                                        'pic'],
                                                                onSave: (value) =>
                                                                    catatanProvider
                                                                        .updatePIC(
                                                                  index,
                                                                  value,
                                                                  isFinalized:
                                                                      true,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Editable "Due Date" cell with reduced width
                                                    DataCell(
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              catatan['dueDate']
                                                                      .isNotEmpty
                                                                  ? catatan[
                                                                      'dueDate']
                                                                  : 'Select Date',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .blue),
                                                            onPressed: () {
                                                              _showDatePickerDialog(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    catatan[
                                                                        'dueDate'],
                                                                onSave: (value) =>
                                                                    catatanProvider
                                                                        .updateDueDate(
                                                                  index,
                                                                  value,
                                                                  isFinalized:
                                                                      true,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Compact "Actions" cell
                                                    DataCell(SizedBox(
                                                      width: 30,
                                                      child: IconButton(
                                                        icon: Icon(Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          catatanProvider
                                                              .removeFromFinalized(
                                                                  index);
                                                        },
                                                      ),
                                                    )),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 16),
            // Right Column with smooth transition
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: isRightColumnVisible
                  ? MediaQuery.of(context).size.width * 0.3
                  : 0,
              child: isRightColumnVisible
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Preview",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  color: Colors.grey,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Outer Container with Inner Container for padding
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Palette.bgcolor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FutureBuilder<Uint8List>(
                                future: pdfFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text("Error generating PDF"));
                                  } else {
                                    return PdfPreview(
                                      build: (format) => snapshot.data!,
                                      allowPrinting: true,
                                      allowSharing: true,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build labeled fields
  Widget _buildLabeledField(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        field,
      ],
    );
  }

  Widget _buildParticipantField() {
    return FormBuilderTextField(
      name: "Peserta Rapat",
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Masukkan peserta rapat",
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.person_search, color: Colors.blue),
                onPressed: () => _openSlidingPanelEmployee(context))
          ],
        ),
      ),
    );
  }

  // Widget _buildCatatanField() {}

  void _showEditDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Masukkan $title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ElevatedButton(
        //   onPressed: () async {
        //     final provider = Provider.of<MomsProvider>(context, listen: false);
        //     provider.author = _formKey.currentState?.fields['Author']?.value;
        //     final DateTime? selectedDate =
        //         _formKey.currentState?.fields['Hari / Tanggal']?.value;
        //     provider.meetingDate = selectedDate != null
        //         ? DateFormat('yyyy-MM-dd').format(selectedDate)
        //         : null;

        //     // Format TimeOfDay for the time
        //     final DateTime? selectedDateTime =
        //         _formKey.currentState?.fields['Waktu']?.value;
        //     provider.time = selectedDateTime != null
        //         ? DateFormat('hh:mm a').format(selectedDateTime)
        //         : null;
        //     provider.place = _formKey.currentState?.fields['Tempat']?.value;
        //     provider.agenda = _formKey.currentState?.fields['Agenda']?.value;

        //     print("Author: ${provider.author}");
        //     print("Meeting Date: ${provider.meetingDate}");
        //     print("Time: ${provider.time}");
        //     print("Place: ${provider.place}");
        //     print("Agenda: ${provider.agenda}");
        //     print("Selected Employees: ${provider.selectedEmployees}");
        //     print("Catatan List: ${provider.catatanList}");
        //     print("Finalized List: ${provider.finalizedList}");

        //     // Validasi data sebelum pratinjau
        //     if (provider.author == null ||
        //         provider.meetingDate == null ||
        //         provider.time == null ||
        //         provider.place == null ||
        //         provider.agenda == null ||
        //         provider.selectedEmployees.isEmpty ||
        //         provider.finalizedList.isEmpty) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //             content: Text("Lengkapi semua data sebelum pratinjau PDF")),
        //       );
        //       return;
        //     }

        //     // Show PDF preview through the provider method
        //     await provider.showPdfPreview(context);
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   child: Text(
        //     "Pratinjau",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        //   ),
        // ),
        // const SizedBox(width: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     _showSelectedEmployeesDrawerSign();
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   child: Text(
        //     "Tandatangani",
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        //   ),
        // ),
        ElevatedButton(
          onPressed: () async {
            final provider = Provider.of<MomsProvider>(context, listen: false);

            if (_formKey.currentState?.saveAndValidate() ?? false) {
              provider.author = _formKey.currentState?.fields['Author']?.value;
              final DateTime? selectedDate =
                  _formKey.currentState?.fields['Hari / Tanggal']?.value;
              provider.meetingDate = selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(selectedDate)
                  : null;

              // Format TimeOfDay for the time
              final DateTime? selectedDateTime =
                  _formKey.currentState?.fields['Waktu']?.value;
              provider.time = selectedDateTime != null
                  ? DateFormat('hh:mm a').format(selectedDateTime)
                  : null;
              provider.place = _formKey.currentState?.fields['Tempat']?.value;
              provider.agenda = _formKey.currentState?.fields['Agenda']?.value;

              final int representativeSigner = provider.representativeSigner;
              final String discussionMaterial =
                  provider.discussionMaterial ?? '';
              if (discussionMaterial.isNotEmpty) {
                print("Discussion Material: $discussionMaterial");
              }

              await provider.createMeeting(context, representativeSigner);
              if (provider.isSubmitting == false) {
                _formKey.currentState?.reset();

                provider.resetFormData();
              } else {
                SnackToastMessage(context,
                    "Gagal membuat MOM. Silakan coba lagi.", ToastType.error);
              }
            }
          },
          child: Text(
            'Simpan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIconOption(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

void _openSlidingPanelEmployee(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlidingPanelEmployee();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

void _showSelectedEmployeesDrawer(BuildContext context) {
  final employeeProvider = Provider.of<MomsProvider>(context, listen: false);

  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Peserta Rapat Terpilih",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                employeeProvider.selectedEmployees.length,
                            itemBuilder: (context, index) {
                              final employee =
                                  employeeProvider.selectedEmployees[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color:
                                          Colors.grey.shade300, // Warna border
                                      width: 1, // Ketebalan border
                                    ),
                                  ),
                                  elevation: 0, // Menghilangkan shadow
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nama Peserta",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildInfoRow(
                                            "Nama", employee.name ?? 'N/A'),
                                        _buildInfoRow(
                                            "NIK", employee.nik ?? 'N/A'),
                                        _buildInfoRow("Position",
                                            employee.position ?? 'N/A'),
                                        _buildInfoRow("Stakeholder",
                                            employee.stakeholder ?? 'N/A'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Tutup",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Muncul dari kanan
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

void _showEditDialog({
  required BuildContext context,
  required String title,
  required String initialValue,
  required Function(String) onSave,
}) {
  final TextEditingController controller =
      TextEditingController(text: initialValue);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Masukkan $title"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text("Simpan"),
          ),
        ],
      );
    },
  );
}

void _showDatePickerDialog({
  required BuildContext context,
  required String initialDate,
  required Function(String) onSave,
}) async {
  final initialDateParsed =
      initialDate.isNotEmpty ? DateTime.parse(initialDate) : DateTime.now();

  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDateParsed,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (selectedDate != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    onSave(formattedDate);
  }
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    ),
  );
}

// void _openSlidingPanelEmployee(BuildContext context) {
//   Navigator.of(context).push(
//     PageRouteBuilder(
//       opaque: false,
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Stack(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Material(
//                   color: Colors.transparent,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     padding: EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 254, 255, 255),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey[300]!),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Header
//                           Text(
//                             "Pilih Peserta Rapat",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Palette.momsecondary,
//                             ),
//                           ),
//                           SizedBox(height: 20),

//                           // Top Section - Search and Add Button
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   // Trigger debounce search
//                                   decoration: InputDecoration(
//                                     hintText:
//                                         "Cari nama, nik, jabatan, stakeholder",
//                                     prefixIcon: Icon(Icons.search,
//                                         color: Colors.grey.shade600),
//                                     filled: true,
//                                     fillColor: Palette.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide: BorderSide(
//                                         color: Palette.blackClr,
//                                       ),
//                                     ),
//                                     contentPadding: EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 16),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Add participant logic
//                                   },
//                                   icon: Icon(Icons.add, color: Colors.white),
//                                   label: Text(
//                                     "Tambah Peserta",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Palette.primary,
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 20, horizontal: 2),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),

//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Palette.white,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Daftar Peserta yang Ada",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Palette.momsecondary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),

//                                 // Using ConstrainedBox to limit the height
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                     maxHeight: 400, // Limit height
//                                   ),
//                                   child: Consumer<MomsProvider>(
//                                     builder: (context, momProvider, child) {
//                                       if (momProvider.audiences.isEmpty) {
//                                         momProvider.fetchUserAudiences(
//                                             context, 1, 10, "");
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       }

//                                       return ListView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             AlwaysScrollableScrollPhysics(),
//                                         itemCount: momProvider.audiences.length,
//                                         itemBuilder: (context, index) {
//                                           final participant =
//                                               momProvider.audiences[index];

//                                           return Container(
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 4),
//                                             padding: EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: Palette.momPrimary,
//                                                 width: 1.0,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: ListTile(
//                                               contentPadding: EdgeInsets.all(4),
//                                               title: Text(
//                                                 participant.name ??
//                                                     "Peserta ${index + 1}",
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                               subtitle: Text(
//                                                 participant.position ??
//                                                     "Position ${index + 1}",
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                               trailing: IconButton(
//                                                 icon: Icon(Icons.add,
//                                                     color: Palette.primary),
//                                                 onPressed: () {
//                                                   // Add to selected list logic
//                                                   momProvider.addEmployeeById(
//                                                     participant.id,
//                                                     participant.name ??
//                                                         "Unknown",
//                                                     participant.position ??
//                                                         "Unknown",
//                                                     participant.nik ?? "-",
//                                                     participant.stakeholder ??
//                                                         "-",
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // Selected Participants List with Checkboxes
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Palette.white,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Daftar Peserta yang Dipilih",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Palette.momsecondary,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),

//                                 // Constrained box to limit the list height
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                     minHeight: 400,
//                                     maxHeight: 400, // Limit height
//                                   ),
//                                   child: Consumer<MomsProvider>(
//                                     builder:
//                                         (context, employeeProvider, child) {
//                                       return ListView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             AlwaysScrollableScrollPhysics(),
//                                         itemCount: employeeProvider
//                                             .selectedEmployees.length,
//                                         itemBuilder: (context, index) {
//                                           final selectedEmployee =
//                                               employeeProvider
//                                                   .selectedEmployees[index];

//                                           return Container(
//                                             margin: EdgeInsets.symmetric(
//                                                 vertical: 4),
//                                             padding: EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: Palette.momPrimary,
//                                                 width: 1.0,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: ListTile(
//                                               contentPadding: EdgeInsets.all(4),
//                                               title: Text(
//                                                 selectedEmployee.name ??
//                                                     'Peserta ${index + 1}',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                               subtitle: Text(
//                                                 selectedEmployee.position ??
//                                                     'Position ${index + 1}',
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                               trailing: Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Checkbox(
//                                                     value: true,
//                                                     onChanged:
//                                                         (bool? newValue) {
//                                                       // Update the selection state if necessary
//                                                     },
//                                                   ),
//                                                   IconButton(
//                                                     icon: Icon(Icons.delete,
//                                                         color: Colors.red),
//                                                     onPressed: () {
//                                                       employeeProvider
//                                                           .removeEmployeeById(
//                                                               selectedEmployee
//                                                                   .id); // Remove from selected list
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // Save Button
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: Consumer<MomsProvider>(
//                               builder: (context, employeeProvider, child) {
//                                 return ElevatedButton(
//                                   onPressed: () {
//                                     final selectedEmployees =
//                                         employeeProvider.selectedEmployees;

//                                     for (var employee in selectedEmployees) {
//                                       print(
//                                         "ID: ${employee.id}, Name: ${employee.name}, Position: ${employee.position}",
//                                       );
//                                     }

//                                     employeeProvider.submitSelectedEmployees(
//                                         selectedEmployees);

//                                     Navigator.pop(context);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Palette.primary,
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 18, horizontal: 64),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     "Simpan",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0); // Slide in from the right
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     ),
//   );
// }
Widget _buildCustomTextField({
  required String name,
  required String hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) {
  // Check if the field should be a date, time, or textarea type based on name
  if (name == 'Hari / Tanggal') {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: InputType.date,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[300]!, size: 20)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey[300]!, size: 20)
            : null,
      ),
      validator: FormBuilderValidators.required(),
    );
  } else if (name == 'Waktu') {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: InputType.time,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[300]!, size: 20)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey[300]!, size: 20)
            : null,
      ),
      validator: FormBuilderValidators.required(),
    );
  } else if (name == 'Agenda') {
    return FormBuilderTextField(
      name: name,
      maxLines: 5, // Makes the input field a text area
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[300]!, size: 20)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey[300]!, size: 20)
            : null,
      ),
      validator: FormBuilderValidators.required(),
    );
  } else {
    // Default text field if not date, time, or textarea
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[300]!, size: 20)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey[300]!, size: 20)
            : null,
      ),
      validator: FormBuilderValidators.required(),
    );
  }
}

// void _openMateriPembahasanEditor(BuildContext context) {
//   final quillController = quill.QuillController.basic();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Edit Materi Pembahasan"),
//         content: Container(
//           height: 300,
//           child: quill.QuillEditor.basic(
//             controller: quillController,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               // Save content from the editor
//               final content = quillController.document.toPlainText();
//               // Update the provider or state with the content if necessary
//               // You can access this content later

//               Navigator.of(context).pop();
//             },
//             child: Text("Save"),
//           ),
//         ],
//       );
//     },
//   );
// }

void _openCatatanEditor() {
  // Define your catatan editor logic here
}

Widget _buildTabItem(String label, {bool isActive = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 26.0),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Palette.momsecondary : Colors.black54,
          ),
        ),
        if (isActive)
          Container(
            margin: EdgeInsets.only(top: 4),
            height: 2,
            width: 80,
            color: Palette.momsecondary,
          ),
      ],
    ),
  );
}

class _DiscussionSection extends StatelessWidget {
  final HtmlEditorController htmlEditorController;
  final Function saveDiscussionMaterial;

  const _DiscussionSection({
    Key? key,
    required this.htmlEditorController,
    required this.saveDiscussionMaterial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Materi Pembahasan *",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: HtmlEditor(
            controller: htmlEditorController,
            htmlToolbarOptions: HtmlToolbarOptions(
              toolbarPosition: ToolbarPosition.aboveEditor,

              // defaultToolbarButtons: [
              //   StyleButtons(),
              //   FontSettingButtons(fontSizeUnit: false),
              //   ColorButtons(),
              //   ListButtons(),

              //   ParagraphButtons(
              //     lineHeight: false,
              //     caseConverter: false,
              //     textDirection: false,
              //   ),
              //   InsertButtons(
              //     link: true,
              //     picture: true,
              //     audio: false,
              //     video: false,
              //     table: false,
              //     hr: false,

              //   ),

              // ],
            ),
            htmlEditorOptions: HtmlEditorOptions(
              hint: "Enter text here...",
              shouldEnsureVisible: true,
              initialText: "Initial text",
            ),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => saveDiscussionMaterial(),
          child: Text(
            "Simpan Materi",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
