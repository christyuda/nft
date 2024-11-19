import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';

class CatatanEditorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catatanProvider = Provider.of<MomsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Isi Catatan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: catatanProvider.catatanController,
              decoration: InputDecoration(
                labelText: "Tambah Catatan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Tuliskan catatan di sini...",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  final newCatatan = {
                    'catatan': catatanProvider.catatanController.text,
                    'pic': '', // Default PIC value
                    'dueDate': '', // Default Due Date value
                  };
                  catatanProvider.addCatatanToFinalized(newCatatan);
                  catatanProvider.catatanController.clear();
                },
                child: Text(
                  "Tambahkan Catatan",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.primary,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Catatan Final",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: DataTable(
                          columnSpacing: 16,
                          checkboxHorizontalMargin: 2,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: [
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text('No'),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text('Catatan'),
                              ),
                            ),
                            DataColumn(label: Text('PIC')),
                            DataColumn(label: Text('Due Date')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: List<DataRow>.generate(
                            catatanProvider.finalizedList.length,
                            (index) {
                              final catatan =
                                  catatanProvider.finalizedList[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Catatan"),
                                            content: Text(
                                              catatan['catatan'],
                                              textAlign: TextAlign.left,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'Tutup',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        child: Text(
                                          catatan['catatan'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      crossAxisAlignment: catatan['pic'].isEmpty
                                          ? CrossAxisAlignment.center
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            catatan['pic'].isNotEmpty
                                                ? catatan['pic']
                                                : '',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: catatan['pic'].isEmpty
                                                ? TextAlign.center
                                                : TextAlign.left,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            _showEditDialog(
                                              context: context,
                                              title: "PIC",
                                              initialValue: catatan['pic'],
                                              onSave: (value) => catatanProvider
                                                  .updatePIC(index, value,
                                                      isFinalized: true),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      crossAxisAlignment:
                                          catatan['dueDate'].isEmpty
                                              ? CrossAxisAlignment.center
                                              : CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            catatan['dueDate'].isNotEmpty
                                                ? catatan['dueDate']
                                                : '',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign:
                                                catatan['dueDate'].isEmpty
                                                    ? TextAlign.center
                                                    : TextAlign.left,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            _showEditDialog(
                                              context: context,
                                              title: "Due Date",
                                              initialValue: catatan['dueDate'],
                                              onSave: (value) => catatanProvider
                                                  .updateDueDate(index, value,
                                                      isFinalized: true),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        catatanProvider
                                            .removeFromFinalized(index);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
