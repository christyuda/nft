import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
import 'package:webordernft/module/mom/service/model/employee_selection.dart';

class SignatureListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MomsProvider>(context, listen: false);
    final selectedEmployees = provider.selectedEmployees;

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Tanda Tangan"),
      ),
      body: ListView.builder(
        itemCount: selectedEmployees.length,
        itemBuilder: (context, index) {
          final employee = selectedEmployees[index];
          return ListTile(
            title: Text(employee.name ?? 'N/A'),
            subtitle: Text("NIK: ${employee.nik ?? 'N/A'}"),
            trailing: ElevatedButton(
              onPressed: () => _showSignatureDialog(context, employee),
              child: Text("Tanda Tangani"),
            ),
          );
        },
      ),
    );
  }

  void _showSignatureDialog(BuildContext context, EmployeeSelection employee) {
    final SignatureController _signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tanda Tangan untuk ${employee.name}"),
          content: Container(
            width: double.maxFinite,
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.grey[200]!,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        _signatureController.clear();
                      },
                      child: Text("Clear"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Save the signature or handle it here
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
