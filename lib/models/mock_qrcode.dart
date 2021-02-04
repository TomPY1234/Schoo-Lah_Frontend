import 'qrcode.dart';

// List<QRCode> mockQRCode = [
//   QRCode(
//       id: 1,
//       year: 5,
//       subject: 'Bahasa Melayu',
//       classTime: "2021-01-02 10:00 AM"),
//   QRCode(
//       id: 2, year: 5, subject: 'Mathematics', classTime: "2021–01–02 02:30 PM"),
//   QRCode(id: 3, year: 5, subject: 'Science', classTime: "2021–01–08 10:00 AM"),
//   QRCode(
//       id: 4,
//       year: 5,
//       subject: 'Bahasa Melayu',
//       classTime: "2021–01–09 10:00 AM"),
//   QRCode(
//       id: 5, year: 5, subject: 'Mathematics', classTime: "2021–01–09 02:30 PM"),
//   QRCode(id: 6, year: 5, subject: 'Science', classTime: "2021–01–15 10:00 AM"),
//   QRCode(
//       id: 7,
//       year: 5,
//       subject: 'Bahasa Melayu',
//       classTime: "2021–01–16 10:00 AM"),
// ];

// class QRCodeDataServiceMock implements QRCodeDataService {
//   QRCode currQRCode;
//   int _nextId = 8;

//   Future<List<QRCode>> getAllHistory() async {
//     return [...mockQRCode];
//   }

//   Future createQRCode(
//       {QRCode code, int year, String subject, String classTime}) async {
//     QRCode newHistory = QRCode(
//         id: _nextId++, year: year, subject: subject, classTime: classTime);
//     mockQRCode.add(newHistory);
//   }

//   Future<QRCode> getHistory({QRCode code}) async {
//     return currQRCode;
//   }

//   Future<QRCode> updateHistory({QRCode code}) async {
//     currQRCode = code;
//   }
// }
