import 'package:schoolah_mobile_app/models/qrcode.dart';

abstract class QRCodeDataService {
  Future<List<QRCode>> getAllHistory();
  Future createQRCode({QRCode code, int year, String subject, String classTime});
}
