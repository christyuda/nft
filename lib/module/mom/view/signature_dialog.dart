import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/module/mom/provider/manager/moms_provider.dart';
import 'package:webordernft/module/mom/service/model/employee_selection.dart';

class SignatureDialog extends StatefulWidget {
  final EmployeeSelection employee;

  SignatureDialog({required this.employee});

  @override
  _SignatureDialogState createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Tanda Tangan untuk ${widget.employee.name}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.all(10),
              child: Signature(
                controller: _controller,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.clear, color: Colors.red),
                  label: Text(
                    "Bersihkan",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _controller.clear(),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.check, color: Colors.green),
                  label: Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final signature = await _controller.toPngBytes();
                      if (signature != null) {
                        // Save signature in provider
                        Provider.of<MomsProvider>(context, listen: false)
                            .saveEmployeeSignature(widget.employee, signature);
                        Navigator.pop(context, signature); // Close dialog
                      } else {
                        _showSnackbar("Gagal menyimpan tanda tangan.");
                      }
                    } else {
                      _showSnackbar("Tanda tangan kosong!");
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without saving
              },
              child: Text(
                "Batal",
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
