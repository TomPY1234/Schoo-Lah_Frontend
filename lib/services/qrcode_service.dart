import 'package:schoolah_mobile_app/models/qrcode.dart';

abstract class QRCodeService {
  Future<List<QRCode>> getAllQRCodes();
  Future createQRCode(
      {QRCode code, int year, String subject, String classTime});
  Future setLatestQR({QRCode code});
  Future<QRCode> getLatestQR();
}
