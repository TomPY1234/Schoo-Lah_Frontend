import 'package:schoolah_mobile_app/models/qrcode.dart';

import '../dependencies.dart';
import './rest_service.dart';
import 'qrcode_service.dart';

class QRCodeServiceRest implements QRCodeService {
  //------- Here is how we implement 'Singleton pattern' in Dart --------

  static final QRCodeServiceRest _instance = QRCodeServiceRest._constructor();
  factory QRCodeServiceRest() {
    return _instance;
  }

  QRCodeServiceRest._constructor();
  final rest = service<RestService>();

  Future<List<QRCode>> getAllQRCodes() async {
    final listJson = await rest.get('qr');

    return (listJson as List)
        .map((itemJson) => QRCode.fromJson(itemJson))
        .toList();
  }

  QRCode currQRCode;

  Future createQRCode({QRCode code, int year, String subject, String classTime}) async {
    final newQR = QRCode(subject: subject, year: year, classTime: classTime);

    final json = await rest.post('qr/', data: newQR);
    return QRCode.fromJson(json);
  }

  Future updateCurrentQRCode({QRCode code, String id}) async {
    currQRCode = code;

    final json = await rest.patch('qr/$id', data: code);
    return QRCode.fromJson(json);
  }

  Future<QRCode> getLatestQR() async {
    return currQRCode;
  }

  Future setLatestQR({QRCode code}) async {
    currQRCode = code;
  }
}
