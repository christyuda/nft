import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/module/order/provider/order_provider.dart';

class PaymentConfirmationPage extends StatefulWidget {
  const PaymentConfirmationPage({super.key});

  @override
  _PaymentConfirmationPageState createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false)
        .initializeVideo('assets/video/nft.mp4');
    Provider.of<OrderProvider>(context, listen: false).generateCaptcha();
  }

  @override
  void dispose() {
    Provider.of<OrderProvider>(context, listen: false).disposeVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final screenPadding =
        isLargeScreen ? screenWidth * 0.1 : screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pembayaran',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Palette.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenPadding, vertical: 16),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Loading spinner
            : SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  child: isLargeScreen
                      ? _buildLargeScreenLayout(context)
                      : _buildSmallScreenLayout(context),
                ),
              ),
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPaymentInstructions(context),
        SpaceVertical(size: 24),
        _buildQRCodeSection(),
        SpaceVertical(size: 24),
        _buildUploadForm(context),
      ],
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentInstructions(context),
              SpaceVertical(size: 24),
            ],
          ),
        ),
        SpaceHorizontal(size: 32),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildQRCodeSection(),
              SpaceVertical(size: 24),
              _buildUploadForm(context),
            ],
          ),
        ),
      ],
    );
  }

  void _showCaptchaDialog(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Verifikasi CAPTCHA'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          orderProvider.generatedCaptcha,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            orderProvider.generateCaptcha();
                          });
                        },
                      ),
                    ],
                  ),
                  SpaceVertical(size: 16),
                  TextField(
                    onChanged: (value) {
                      orderProvider.enteredCaptcha = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Masukkan kode CAPTCHA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    orderProvider.generateCaptcha();
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text('Verifikasi'),
                  onPressed: () async {
                    if (orderProvider.validateCaptcha()) {
                      final selectedFiles =
                          _formKey.currentState?.fields['payment_proof']?.value;
                      final phoneNumber =
                          Provider.of<OrderProvider>(context, listen: false)
                              .phoneNumber;
                      Provider.of<OrderProvider>(context, listen: false)
                          .submitPaymentProof(context, selectedFiles,
                              phoneNumber!, orderProvider.paymentChannel);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Kode CAPTCHA salah. Silakan coba lagi.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Future<void> _submitPaymentProof(BuildContext context) async {
  //   if (_formKey.currentState?.saveAndValidate() ?? false) {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     final selectedFiles =
  //         _formKey.currentState?.fields['payment_proof']?.value;
  //     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

  //     if (selectedFiles != null && selectedFiles.isNotEmpty) {
  //       if (kIsWeb) {
  //         Uint8List? fileBytes = selectedFiles.first.bytes;
  //         String? fileName = selectedFiles.first.name; // Get the file name

  //         // Validate the file extension for JPG/PNG
  //         if (fileName != null &&
  //             (fileName.endsWith('.jpg') || fileName.endsWith('.png'))) {
  //           if (fileBytes != null && orderProvider.phoneNumber != null) {
  //             try {
  //               // Construct the OrderPaymentProof object for web
  //               OrderPaymentProof paymentProofData = OrderPaymentProof(
  //                 cellphone: orderProvider.phoneNumber!,
  //                 fileBytes: fileBytes, // Use bytes for web
  //                 fileName: fileName, // Add file name for file validation
  //               );

  //               // Submit the payment proof to the API
  //               await OrderService.submitPaymentProof(
  //                   context, paymentProofData);

  //               setState(() {
  //                 isLoading = false;
  //               });
  //               Navigator.pushNamed(context, 'SuccessPage');
  //             } catch (e) {
  //               setState(() {
  //                 isLoading = false;
  //               });
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text('Error: $e')),
  //               );
  //             }
  //           } else {
  //             setState(() {
  //               isLoading = false;
  //             });
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Phone number or file is missing.')),
  //             );
  //           }
  //         } else {
  //           setState(() {
  //             isLoading = false;
  //           });
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('File must be JPG or PNG format.')),
  //           );
  //         }
  //       } else {
  //         // For mobile/desktop platforms, use the file path
  //         String? imagePath = selectedFiles.first.path;

  //         if (imagePath != null &&
  //             (imagePath.endsWith('.jpg') || imagePath.endsWith('.png'))) {
  //           if (orderProvider.phoneNumber != null) {
  //             try {
  //               // Construct the OrderPaymentProof object for mobile/desktop
  //               OrderPaymentProof paymentProofData = OrderPaymentProof(
  //                 cellphone: orderProvider.phoneNumber!,
  //                 imagePath: imagePath,
  //               );

  //               // Submit the payment proof to the API
  //               await OrderService.submitPaymentProof(
  //                   context, paymentProofData);

  //               setState(() {
  //                 isLoading = false;
  //               });
  //               Navigator.pushNamed(context, 'SuccessPage');
  //             } catch (e) {
  //               setState(() {
  //                 isLoading = false;
  //               });
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text('Error: $e')),
  //               );
  //             }
  //           } else {
  //             setState(() {
  //               isLoading = false;
  //             });
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Phone number or file is missing.')),
  //             );
  //           }
  //         } else {
  //           setState(() {
  //             isLoading = false;
  //           });
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('File must be JPG or PNG format.')),
  //           );
  //         }
  //       }
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('No file selected.')),
  //       );
  //     }
  //   } else {
  //     print('Validation failed');
  //   }
  // }

  Widget _buildPaymentInstructions(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Silahkan melakukan pembayaran sesuai dengan ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Total yang harus dibayar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Set bold untuk bagian ini
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' pada halaman sebelumnya. Pembayaran dapat dilakukan dengan beberapa metode sebagai berikut:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceVertical(size: 16),
            const Text(
                '1. Pembayaran menggunakan QRIS (Kantor Filateli Jakarta 10700).'),
            const Text(
                '2. Transfer ke Rekening Giropos Kantor Filateli Jakarta 0400008777 dengan menggunakan bank berikut:'),
            const Text(
                '   •  Bank BNI: kode 851088 dan 10 digit Rekening Giropos (8510880400008777)'),
            const Text(
                '   •  Bank Mandiri: kode 88588 dan 10 digit Rekening Giropos (885880400008777)'),
            const Text(
                '   •  Bank BCA: kode 81610 dan 10 digit Rekening Giropos (816100400008777)'),
            const Text(
                '   •  Bank BRI: kode 10953 dan 10 digit Rekening Giropos (109530400008777)'),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Scan QRIS untuk pembayaran:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Palette.blackClr,
              ),
              textAlign: TextAlign.center,
            ),
            SpaceVertical(size: 16),
            Center(
              child: Container(
                width: 240,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner/qris-nft.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadForm(BuildContext context) {
    final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Palette.blackClr,
              ),
            ),
            SpaceVertical(size: 16),
            FormBuilderDropdown<String>(
              name: 'transfer_method',
              decoration: InputDecoration(
                labelText: 'Pilih Metode Pembayaran',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                orderprovider.paymentChannel = int.parse(value!);
              },
              items: [
                DropdownMenuItem(value: '21', child: Text('Qris (Scan QRIS)')),
                DropdownMenuItem(
                    value: '22', child: Text('Giropos (0400008777)')),
                DropdownMenuItem(
                    value: '23', child: Text('BNI (8510880400008777)')),
                DropdownMenuItem(
                    value: '24', child: Text('Mandiri (885880400008777)')),
                DropdownMenuItem(
                    value: '25', child: Text('BCA (816100400008777)')),
                DropdownMenuItem(
                    value: '26', child: Text('BRI (109530400008777)')),
              ],
              validator: FormBuilderValidators.required(),
            ),
            SpaceVertical(size: 16),
            Text(
              'Upload bukti pembayaran yang sudah dilakukan:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Palette.blackClr,
              ),
            ),
            SpaceVertical(size: 16),
            FormBuilderFilePicker(
              name: 'payment_proof',
              decoration: InputDecoration(
                labelText: 'Upload file (PDF or image)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.upload_file),
              ),
              maxFiles: 1,
              allowMultiple: false,
              allowedExtensions: ['jpg', 'jpeg', 'png'],
              previewImages: true,
              typeSelectors: [
                TypeSelector(
                  type: FileType.custom,
                  selector: Row(
                    children: <Widget>[
                      Icon(Icons.add_circle),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Tambah Dokumen"),
                      ),
                    ],
                  ),
                ),
              ],
              onFileLoading: (status) => print(status),
              validator: FormBuilderValidators.required(),
            ),
            SpaceVertical(size: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showCaptchaDialog(context);
              },
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text(
                'Submit Bukti Pembayaran',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
