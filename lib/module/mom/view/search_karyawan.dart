import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/widget/btnwidget.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';

class SearchKaryawan extends StatefulWidget {
  @override
  State<SearchKaryawan> createState() => _SearchKaryawanState();
}

class _SearchKaryawanState extends State<SearchKaryawan> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final employeeProvider = Provider.of<MomsProvider>(context, listen: false);
    employeeProvider.fetchUserAudiences(context, 1, 10, '');
  }

  void _onSearchChanged(String term) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final employeeProvider =
          Provider.of<MomsProvider>(context, listen: false);
      employeeProvider.fetchUserAudiences(
          context, 1, 10, term); // Fetch data after user stops typing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari Peserta Rapat"),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tutup", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Peserta Rapat",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Consumer<MomsProvider>(
                  builder: (context, employeeProvider, child) {
                    return ElevatedButton.icon(
                      onPressed: () =>
                          _showAddEmployeeDialog(context, employeeProvider),
                      icon: Icon(Icons.add, size: 16, color: Colors.white),
                      label: Text(
                        "Tambah Peserta Rapat",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<MomsProvider>(
              builder: (context, employeeProvider, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Cari nama, nik, jabatan, stakeholder",
                      prefixIcon:
                          Icon(Icons.search, color: Colors.grey.shade600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MomsProvider>(
                builder: (context, employeeProvider, child) {
                  return Row(
                    children: [
                      Expanded(
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
                              itemCount: employeeProvider.audiences.length,
                              itemBuilder: (context, index) {
                                final audience =
                                    employeeProvider.audiences[index];
                                return ListTile(
                                  title: Text(audience.name ?? '-'),
                                  subtitle: Text(audience.position ?? '-'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: Colors.blue),
                                    onPressed: () {
                                      employeeProvider.addEmployeeById(
                                        audience.id,
                                        audience.name ?? '-',
                                        audience.position ?? '-',
                                        audience.nik ?? '-',
                                        audience.stakeholder ?? '-',
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      VerticalDivider(width: 32, color: Colors.grey.shade300),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Daftar yang dipilih",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    employeeProvider.clearSelectedEmployees();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 36),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    shadowColor: Colors.red.withOpacity(0.3),
                                  ),
                                  child: Text("Hapus Semua",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  itemCount:
                                      employeeProvider.selectedEmployees.length,
                                  itemBuilder: (context, index) {
                                    final selectedEmployee = employeeProvider
                                        .selectedEmployees[index];
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          selectedEmployee.name ?? 'Unknown',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(
                                            selectedEmployee.position ??
                                                'Unknown'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.remove_circle,
                                              color: Colors.red),
                                          onPressed: () {
                                            employeeProvider.removeEmployeeById(
                                                selectedEmployee.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<MomsProvider>(
              builder: (context, employeeProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final selectedEmployees =
                            employeeProvider.selectedEmployees;

                        for (var employee in selectedEmployees) {
                          print(
                            "ID: ${employee.id}, Name: ${employee.name}, Position: ${employee.position}",
                          );
                        }

                        employeeProvider
                            .submitSelectedEmployees(selectedEmployees);

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 36),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: Colors.blue.withOpacity(0.3),
                      ),
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showAddEmployeeDialog(BuildContext context, MomsProvider provider) {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
        SubmitButton(
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
                1,
              );

              await Provider.of<MomsProvider>(context, listen: false)
                  .fetchUserAudiences(context, 1, 10, '');

              Navigator.of(context).pop();
            }
          },
          labelname: 'Tambah',
          icn: Icons.add,
          clr: Palette.white,
        ),
        SpaceVertical(size: 10),
        CancelButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          labelname: 'Kembali',
        ),
      ],
    ),
  );
}
