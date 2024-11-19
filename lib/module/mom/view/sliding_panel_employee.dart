import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/widget/btnwidget.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';

class SlidingPanelEmployee extends StatefulWidget {
  @override
  _SlidingPanelEmployeeState createState() => _SlidingPanelEmployeeState();
}

class _SlidingPanelEmployeeState extends State<SlidingPanelEmployee> {
  final _formKey = GlobalKey<FormBuilderState>();
  Timer? _debounce;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch initial data after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final employeeProvider =
          Provider.of<MomsProvider>(context, listen: false);
      employeeProvider.fetchUserAudiences(context, 1, 10, '');
    });

    _textEditingController.addListener(() {
      _onSearchChanged(_textEditingController.text);
    });
  }

  void _onSearchChanged(String term) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (term.isEmpty) {
      final employeeProvider =
          Provider.of<MomsProvider>(context, listen: false);
      employeeProvider.clearSuggestions();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final employeeProvider =
          Provider.of<MomsProvider>(context, listen: false);
      employeeProvider.fetchUserAudiences(context, 1, 10, term);
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<MomsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 254, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Peserta Rapat",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Palette.momsecondary,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Search Bar and Add Button
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Cari nama, nik, jabatan, stakeholder",
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.grey.shade600),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _showAddEmployeeDialog(
                                          context, employeeProvider);
                                    },
                                    icon: Icon(Icons.add, color: Colors.white),
                                    label: Text("Tambah Peserta",
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Palette.primary,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Consumer<MomsProvider>(
                                builder: (context, employeeProvider, child) {
                                  if (employeeProvider.isLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (employeeProvider.suggestions.isEmpty) {
                                    return Center(
                                        child: Text(
                                            "Masukkan nama atau nik peserta"));
                                  }
                                  return Container(
                                    color: Colors.white,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          employeeProvider.suggestions.length,
                                      itemBuilder: (context, index) {
                                        final suggestion =
                                            employeeProvider.suggestions[index];
                                        final id = suggestion['id'] ?? "";
                                        final name = suggestion['name'] ?? '';
                                        final position =
                                            suggestion['position'] ?? '';
                                        final nik = suggestion['nik'] ?? '';
                                        final stakeholder =
                                            suggestion['stakeholder'] ?? '';

                                        return InkWell(
                                          onTap: () {
                                            _textEditingController.clear();
                                            employeeProvider.addEmployeeById(
                                                int.parse(id),
                                                name,
                                                position,
                                                nik,
                                                stakeholder);
                                            employeeProvider.clearSuggestions();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            child: Row(
                                              children: [
                                                Icon(Icons.person,
                                                    color:
                                                        Colors.grey.shade600),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      name,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      position,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          //     ElevatedButton.icon(
                          //       onPressed: () {
                          //         _showAddEmployeeDialog(
                          //             context, employeeProvider);
                          //       },
                          //       icon: Icon(Icons.add, color: Colors.white),
                          //       label: Text("Tambah Peserta",
                          //           style: TextStyle(color: Colors.white)),
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Palette.primary,
                          //         padding: EdgeInsets.symmetric(
                          //             vertical: 20, horizontal: 16),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          const SizedBox(height: 16),

                          _buildSelectedParticipantList(context),

                          const SizedBox(height: 16),

                          // Save Button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Consumer<MomsProvider>(
                              builder: (context, employeeProvider, child) {
                                return ElevatedButton(
                                  onPressed: () {
                                    final selectedEmployees =
                                        employeeProvider.selectedEmployees;
                                    employeeProvider.submitSelectedEmployees(
                                        selectedEmployees);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Palette.primary,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 64),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text("Simpan",
                                      style: TextStyle(color: Colors.white)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daftar Peserta yang Ada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Palette.momsecondary,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 800, maxHeight: 800),
            child: Consumer<MomsProvider>(
              builder: (context, employeeProvider, child) {
                if (employeeProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (employeeProvider.audiences.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada hasil ditemukan",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: employeeProvider.audiences.length,
                  itemBuilder: (context, index) {
                    final participant = employeeProvider.audiences[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Palette.momPrimary, width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(4),
                        title: Text(
                          participant.name ?? "Peserta ${index + 1}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        subtitle: Text(
                            participant.position ?? "Position ${index + 1}"),
                        trailing: IconButton(
                          icon: Icon(Icons.add, color: Palette.primary),
                          onPressed: () {
                            employeeProvider.addEmployeeById(
                              participant.id,
                              participant.name ?? "Unknown",
                              participant.position ?? "Unknown",
                              participant.nik ?? "-",
                              participant.stakeholder ?? "-",
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedParticipantList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daftar Peserta yang Dipilih",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Palette.momsecondary,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 600, maxHeight: 600),
            child: Consumer<MomsProvider>(
              builder: (context, employeeProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: employeeProvider.selectedEmployees.length,
                  itemBuilder: (context, index) {
                    final selectedEmployee =
                        employeeProvider.selectedEmployees[index];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Palette.momPrimary, width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(4),
                        title: Text(
                          selectedEmployee.name ?? 'Peserta ${index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          selectedEmployee.position ?? 'Position ${index + 1}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value:
                                  selectedEmployee.representative_signer == 1,
                              onChanged: (bool? value) {
                                employeeProvider.updateRepresentativeSigner(
                                    selectedEmployee.id, value == true ? 1 : 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                employeeProvider
                                    .removeEmployeeById(selectedEmployee.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showAddEmployeeDialog(BuildContext context, MomsProvider provider) {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _representativeSigner = 0;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          Icon(
            Icons.person_add,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 8),
          Text(
            'Tambah Peserta Rapat Baru',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      content: Container(
        width: 700,
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Nama wajib diisi"),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'nik',
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "NIK wajib diisi"),
                    FormBuilderValidators.numeric(
                        errorText: "NIK harus berupa angka"),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'position',
                  decoration: InputDecoration(
                    labelText: 'Position',
                    prefixIcon: Icon(Icons.work),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Position wajib diisi"),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'stakeholder',
                  decoration: InputDecoration(
                    labelText: 'Stakeholder',
                    prefixIcon: Icon(Icons.work),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Stakeholder wajib diisi"),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton.icon(
          onPressed: () async {
            if (_formKey.currentState!.saveAndValidate()) {
              final formData = _formKey.currentState!.value;

              // Add user audience and wait for completion
              await provider.addUserAudience(
                context,
                formData['name'],
                formData['nik'],
                formData['position'],
                formData['stakeholder'],
                formData['signing'] ?? '',
                0,
              );

              await Provider.of<MomsProvider>(context, listen: false)
                  .fetchUserAudiences(context, 1, 10, '');

              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Tambah'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.white,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kembali'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey, // Change to desired color
          ),
        ),
      ],
    ),
  );
}
