import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart'; // Format currency import
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart'; // Import responsive_builder package
import 'package:webordernft/common/utils/appbar.dart';
import 'package:webordernft/common/widget/spacer.dart';
import 'package:webordernft/config/sizeconf.dart';
import 'package:webordernft/module/order/provider/order_provider.dart';
import '../../common/widget/btnwidget.dart';
import '../../common/widget/frmstyle.dart';
import '../../config/palette.dart';

class IndexOrder extends StatefulWidget {
  const IndexOrder({super.key});

  @override
  State<IndexOrder> createState() => _IndexOrderState();
}

class _IndexOrderState extends State<IndexOrder> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _orderAmountController;
  late TextEditingController _totalController;
  late TextEditingController _totalToBePaidController;

  // Format currency function
  String _formatCurrency(double amount) {
    final format =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return format.format(amount);
  }

  @override
  void initState() {
    super.initState();
    _totalController = TextEditingController();
    _totalToBePaidController = TextEditingController();
  }

  @override
  void dispose() {
    _totalController.dispose();
    _totalToBePaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ReuseAppBar.getAppBar(context, 'Data Pemesanan / Orderer Data', ''),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // Check if the current screen size is mobile, tablet, or desktop
          if (sizingInformation.isMobile) {
            return _buildMobileLayout(context); // Layout untuk mobile
          } else if (sizingInformation.isTablet) {
            return _buildTabletLayout(context); // Layout untuk tablet
          } else {
            return _buildDesktopLayout(context); // Layout untuk desktop
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sz.wpfactor(context, 20),
          vertical: Sz.hpfactor(context, 20),
        ),
        child: _buildFormMobile(context), // Panggil form khusus untuk mobile
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sz.wpfactor(context, 20),
          vertical: Sz.hpfactor(context, 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildForm(context), // Form dibangun di dalam kolom secara vertikal
            SpaceVertical(size: 20), // Jarak antar elemen
            // Tambahkan elemen lain jika ada, seperti tombol atau teks
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sz.wpfactor(context, 50),
          vertical: Sz.hpfactor(context, 50),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildForm(context),
            ),
            SpaceHorizontal(size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceVertical(size: 16),
                Sz.title(context, 'Nama Pemesan / Orderer Name', TextAlign.left,
                    Palette.blackClr),
                SpaceVertical(size: 8),
                FormBuilderTextField(
                  name: 'orderer_name',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.required(),
                ),
                SpaceVertical(size: 20),
                Sz.title(
                    context,
                    'Nomor HP Pemesan / Orderer\'s cellphone number',
                    TextAlign.left,
                    Palette.blackClr),
                SpaceVertical(size: 5),
                FormBuilderTextField(
                  name: 'phone_number',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.minLength(10),
                  ]),
                ),
                SpaceVertical(size: 20),
                Sz.title(context, 'Email Pemesan / Orderer Email',
                    TextAlign.left, Palette.blackClr),
                SpaceVertical(size: 5),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                SpaceVertical(size: 20),
                Sz.title(
                    context,
                    'Alamat Lengkap Pemesan / Order\'s Complete Address (for delivery)',
                    TextAlign.left,
                    Palette.blackClr),
                SpaceVertical(size: 5),
                FormBuilderTextField(
                  name: 'address',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.required(),
                ),
                SpaceVertical(size: 20),
                Sz.title(
                    context, 'Kota / City', TextAlign.left, Palette.blackClr),
                SpaceVertical(size: 5),
                FormBuilderTextField(
                  name: 'city',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.required(),
                ),
                SpaceVertical(size: 20),
                Sz.title(context, 'Kode Pos / PostCode', TextAlign.left,
                    Palette.blackClr),
                SpaceVertical(size: 5),
                FormBuilderTextField(
                  name: 'post_code',
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    filled: true,
                    counterText: '',
                    labelStyle: FormStyle().labelText(),
                    hintText: '',
                    hintStyle: FormStyle().hintText(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Palette.primary,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Palette.bordercolor, width: 1)),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
              ],
            ),
          ),
          SpaceHorizontal(size: 32),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                border: Border.all(color: Palette.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpaceVertical(size: 16),
                  Sz.title(context, 'Jumlah Pemesanan / Order Amount',
                      TextAlign.left, Palette.blackClr),
                  SpaceVertical(size: 8),
                  FormBuilderTextField(
                    name: 'order_amount',
                    decoration: InputDecoration(
                      fillColor: Palette.white,
                      filled: true,
                      counterText: '',
                      labelStyle: FormStyle().labelText(),
                      hintText: '',
                      hintStyle: FormStyle().hintText(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Palette.bordercolor, width: 1)),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                    onChanged: (val) {
                      if (val != null && val.isNotEmpty) {
                        int orderAmount = int.tryParse(val) ?? 0;
                        Provider.of<OrderProvider>(context, listen: false)
                            .setOrderAmount(orderAmount);
                      } else {
                        Provider.of<OrderProvider>(context, listen: false)
                            .resetOrder();
                      }
                    },
                  ),
                  SpaceVertical(size: 20),
                  Sz.title(context, 'Harga / Price', TextAlign.left,
                      Palette.blackClr),
                  SpaceVertical(size: 5),
                  FormBuilderTextField(
                    name: 'price',
                    initialValue: _formatCurrency(
                        150000), // Fixed price with currency formatting
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Palette.white,
                      filled: true,
                      labelStyle: FormStyle().labelText(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Palette.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Palette.bordercolor, width: 1)),
                    ),
                  ),
                  SpaceVertical(size: 20),
                  Sz.title(context, 'Total', TextAlign.left, Palette.blackClr),
                  SpaceVertical(size: 5),
                  Consumer<OrderProvider>(builder: (context, order, child) {
                    _totalController.text = _formatCurrency(
                        order.total); // Apply currency formatting
                    return FormBuilderTextField(
                      name: 'total',
                      controller: _totalController,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Palette.white,
                        filled: true,
                        labelStyle: FormStyle().labelText(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Palette.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Palette.bordercolor,
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  }),
                  SpaceVertical(size: 20),
                  Sz.title(context, 'Ongkos Kirim / Shipping Cost',
                      TextAlign.left, Palette.blackClr),
                  SpaceVertical(size: 5),
                  FormBuilderTextField(
                    name: 'shipping_cost',
                    initialValue: _formatCurrency(
                        20000), // Fixed shipping cost with currency formatting
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Palette.white,
                      filled: true,
                      labelStyle: FormStyle().labelText(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Palette.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Palette.bordercolor, width: 1)),
                    ),
                  ),
                  SpaceVertical(size: 16),
                  Sz.title(context, 'Total Harus di Bayar / Total Must Be Paid',
                      TextAlign.left, Palette.blackClr),
                  SpaceVertical(size: 2),
                  Consumer<OrderProvider>(builder: (context, order, child) {
                    _totalToBePaidController.text = _formatCurrency(
                        order.totalToBePaid); // Apply currency formatting
                    return FormBuilderTextField(
                      name: 'total_to_be_paid',
                      controller: _totalToBePaidController,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Palette.white,
                        filled: true,
                        labelStyle: FormStyle().labelText(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Palette.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Palette.bordercolor,
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  }),
                  SpaceVertical(size: 20),
                  SubmitButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = _formKey.currentState?.value;
                        final orderProvider =
                            Provider.of<OrderProvider>(context, listen: false);

                        bool isValid = orderProvider.submitOrder(
                          name: formData?['orderer_name'],
                          phone: formData?['phone_number'],
                          email: formData?['email'],
                          address: formData?['address'],
                          city: formData?['city'],
                          postCode: formData?['post_code'],
                          orderAmount: formData?['order_amount'],
                        );

                        if (isValid) {
                          Navigator.pushNamed(context, 'KonfirmasiPembayaran');
                        } else {
                          print('Validation failed');
                        }
                      }
                    },
                    labelname: 'Bayar / Check Out',
                    icn: Icons.add_chart,
                    clr: Palette.white,
                  ),
                  SpaceVertical(size: 20),
                  CancelButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      labelname: 'Batal / Cancel')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormMobile(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceVertical(size: 16),
          Sz.title(context, 'Nama Pemesan / Orderer Name', TextAlign.left,
              Palette.blackClr),
          SpaceVertical(size: 8),
          FormBuilderTextField(
            name: 'orderer_name',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.required(),
          ),
          SpaceVertical(size: 20),
          Sz.title(context, 'Nomor HP Pemesan / Orderer\'s cellphone number',
              TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'phone_number',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.minLength(10),
            ]),
          ),
          SpaceVertical(size: 20),
          Sz.title(context, 'Email Pemesan / Orderer Email', TextAlign.left,
              Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          SpaceVertical(size: 20),
          Sz.title(
              context,
              'Alamat Lengkap Pemesan / Order\'s Complete Address (for delivery)',
              TextAlign.left,
              Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'address',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.required(),
          ),
          SpaceVertical(size: 20),
          Sz.title(context, 'Kota / City', TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'city',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.required(),
          ),
          SpaceVertical(size: 20),
          Sz.title(
              context, 'Kode Pos / PostCode', TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'post_code',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
          ),
          SpaceVertical(size: 20),
          // Bagian untuk jumlah pesanan, harga, dan total ke bawah
          Sz.title(context, 'Jumlah Pemesanan / Order Amount', TextAlign.left,
              Palette.blackClr),
          SpaceVertical(size: 8),
          FormBuilderTextField(
            name: 'order_amount',
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              counterText: '',
              labelStyle: FormStyle().labelText(),
              hintText: '',
              hintStyle: FormStyle().hintText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
            onChanged: (val) {
              if (val != null && val.isNotEmpty) {
                int orderAmount = int.tryParse(val) ?? 0;
                Provider.of<OrderProvider>(context, listen: false)
                    .setOrderAmount(orderAmount);
              } else {
                Provider.of<OrderProvider>(context, listen: false).resetOrder();
              }
            },
            validator: FormBuilderValidators.required(),
          ),
          SpaceVertical(size: 20),
          Sz.title(context, 'Harga / Price', TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'price',
            initialValue: _formatCurrency(150000),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              labelStyle: FormStyle().labelText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
          ),
          SpaceVertical(size: 20),
          Sz.title(context, 'Total', TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 5),
          Consumer<OrderProvider>(builder: (context, order, child) {
            _totalController.text = _formatCurrency(order.total);
            return FormBuilderTextField(
              name: 'total',
              controller: _totalController,
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Palette.white,
                filled: true,
                labelStyle: FormStyle().labelText(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.bordercolor, width: 1),
                ),
              ),
            );
          }),
          SpaceVertical(size: 20),
          Sz.title(context, 'Ongkos Kirim / Shipping Cost', TextAlign.left,
              Palette.blackClr),
          SpaceVertical(size: 5),
          FormBuilderTextField(
            name: 'shipping_cost',
            initialValue: _formatCurrency(20000),
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Palette.white,
              filled: true,
              labelStyle: FormStyle().labelText(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Palette.bordercolor, width: 1),
              ),
            ),
          ),
          SpaceVertical(size: 16),
          Sz.title(context, 'Total Harus di Bayar / Total Must Be Paid',
              TextAlign.left, Palette.blackClr),
          SpaceVertical(size: 2),
          Consumer<OrderProvider>(builder: (context, order, child) {
            _totalToBePaidController.text =
                _formatCurrency(order.totalToBePaid);
            return FormBuilderTextField(
              name: 'total_to_be_paid',
              controller: _totalToBePaidController,
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Palette.white,
                filled: true,
                labelStyle: FormStyle().labelText(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.bordercolor, width: 1),
                ),
              ),
            );
          }),
          SpaceVertical(size: 16),
          SubmitButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                final formData = _formKey.currentState?.value;
                final orderProvider =
                    Provider.of<OrderProvider>(context, listen: false);

                bool isValid = orderProvider.submitOrder(
                  name: formData?['orderer_name'],
                  phone: formData?['phone_number'],
                  email: formData?['email'],
                  address: formData?['address'],
                  city: formData?['city'],
                  postCode: formData?['post_code'],
                  orderAmount: formData?['order_amount'],
                );

                if (isValid) {
                  Navigator.pushNamed(context, 'KonfirmasiPembayaran');
                } else {
                  print('Validation failed');
                }
              }
            },
            labelname: 'Bayar / Check Out',
            icn: Icons.add_chart,
            clr: Palette.white,
          ),
          SpaceVertical(size: 20),
          CancelButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              labelname: 'Batal / Cancel')
        ],
      ),
    );
  }
}
