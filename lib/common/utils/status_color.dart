import '../../config/palette.dart';

class Switcher {
  ticket(String status) {
    switch (status) {
      case 'Baru':
        return Palette.openClr;
      case 'Dalam Proses':
        return Palette.inprogressClr;
      // case 'canceled':
      //   return Palette.cancelClr;
      case 'Selesai':
        return Palette.completedClr;
      default:
        return Palette.blackClr;
    }
  }

  labelStatus(context, int num) {
    switch (num) {
      case 0:
        return 'Baru';
      case 1:
        return 'Dalam Proses';
      // case 2:
      //   return 'canceled';
      case 2:
        return 'Selesai';
      default:
        return 'unknown';
    }
  }

  product(String status) {
    switch (status) {
      case 'Transfer':
        return Palette.openClr;
      case 'Overbook':
        return Palette.inprogressClr;
      case 'Topup':
        return Palette.cancelClr;
      case 'PPOB':
        return Palette.completedClr;
      default:
        return Palette.blackClr;
    }
  }

  ticketBerjalan(String status) {
    switch (status) {
      case 'NewTicket':
        return Palette.openClr;
      case 'ClosedTicket':
        return Palette.completedClr;
      default:
        return Palette.blackClr;
    }
  }
}
