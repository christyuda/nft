import 'package:intl/intl.dart';

class FormatDateINA {
  static String formatHari(String tanggal) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);

    var day = DateFormat('EEEE').format(dateTime);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {
          hari = "Minggu";
        }
        break;
      case 'Monday':
        {
          hari = "Senin";
        }
        break;
      case 'Tuesday':
        {
          hari = "Selasa";
        }
        break;
      case 'Wednesday':
        {
          hari = "Rabu";
        }
        break;
      case 'Thursday':
        {
          hari = "Kamis";
        }
        break;
      case 'Friday':
        {
          hari = "Jumat";
        }
        break;
      case 'Saturday':
        {
          hari = "Sabtu";
        }
        break;
    }
    return hari;
  }

  static String formatJam(String tanggal) {
    if (tanggal != "") {
      DateTime dt = DateTime.parse(tanggal);
      String jam = DateFormat('HH:mm:ss').format(dt);

      return jam;
    } else {
      return "- : -";
    }
  }

  static String formatTglIndo(String tanggal) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);

    var m = DateFormat('MM').format(dateTime);
    var d = DateFormat('dd').format(dateTime).toString();
    var Y = DateFormat('yyyy').format(dateTime).toString();
    var month = "";
    switch (m) {
      case '01':
        {
          month = "Januari";
        }
        break;
      case '02':
        {
          month = "Februari";
        }
        break;
      case '03':
        {
          month = "Maret";
        }
        break;
      case '04':
        {
          month = "April";
        }
        break;
      case '05':
        {
          month = "Mei";
        }
        break;
      case '06':
        {
          month = "Juni";
        }
        break;
      case '07':
        {
          month = "Juli";
        }
        break;
      case '08':
        {
          month = "Agustus";
        }
        break;
      case '09':
        {
          month = "September";
        }
        break;
      case '10':
        {
          month = "Oktober";
        }
        break;
      case '11':
        {
          month = "November";
        }
        break;
      case '12':
        {
          month = "Desember";
        }
        break;
    }
    return "$d $month $Y";
  }

  static String dateINA() {
    String tgl = DateTime.now().toIso8601String();

    String jamIndo = formatJam(tgl);
    String hariIndo = formatHari(tgl);
    String tanggalIndo = formatTglIndo(tgl);
    // print('${hariIndo}, ${tanggalIndo} ${jamIndo}');
    String newtanggalIndo = hariIndo + ', ' + tanggalIndo + ' ' + jamIndo;
    return newtanggalIndo;
  }

  static String convertdateINA(String tanggal) {
    // String tgl = DateTime.now().toIso8601String();
    String tgl = tanggal;

    String jamIndo = formatJam(tgl);
    String hariIndo = formatHari(tgl);
    String tanggalIndo = formatTglIndo(tgl);
    // print('${hariIndo}, ${tanggalIndo} ${jamIndo}');
    String newtanggalIndo = hariIndo + ', ' + tanggalIndo + ' ' + jamIndo;
    return newtanggalIndo;
  }

  static String convertMonth(m) {
    var month = "";
    switch (m) {
      case '1':
        {
          month = "Januari ";
        }
        break;
      case '2':
        {
          month = "Februari ";
        }
        break;
      case '3':
        {
          month = "Maret ";
        }
        break;
      case '4':
        {
          month = "April ";
        }
        break;
      case '5':
        {
          month = "Mei ";
        }
        break;
      case '6':
        {
          month = "Juni ";
        }
        break;
      case '7':
        {
          month = "Juli ";
        }
        break;
      case '8':
        {
          month = "Agustus ";
        }
        break;
      case '9':
        {
          month = "September ";
        }
        break;
      case '10':
        {
          month = "Oktober ";
        }
        break;
      case '11':
        {
          month = "November ";
        }
        break;
      case '12':
        {
          month = "Desember ";
        }
        break;
    }
    return month;
  }
}
