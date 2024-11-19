import 'package:intl/intl.dart';

final formatter = NumberFormat("##,###");

class Currency {
  static idr(String val) {
    num convertval = num.parse(val);

    String idrCurrency = NumberFormat('#,##0', 'ID').format(convertval);

    return idrCurrency;
  }

  static formatregular(double val) {
    double formatval = 0.0;
    if (val == '' || val == null) {
      formatval = 0.0;
    } else {
      formatval = val;
    }
    // double convertval = double.parse((val).toStringAsFixed(3));

    final currencyFormatter = NumberFormat('Rp #,##0', 'ID');
    // final currencyFormatter = NumberFormat('Rp #,##0.00', 'ID');

    var newformat = currencyFormatter.format(val);
    return newformat;
  }
}
