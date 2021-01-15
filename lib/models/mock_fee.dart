import 'package:schoolah_mobile_app/services/fee_data_service.dart';
import 'fees.dart';

List<Fee> mockFee = [
  Fee(
      monthFee: 'January',
      date: '1/1/2021',
      amount: 2000.00,
      feeStatus: 'UNPAID'),
];

class FeeDataServiceMock implements FeeDataService {
  Future<List<Fee>> getFeeList() async {
    return [...mockFee];
  }
}
