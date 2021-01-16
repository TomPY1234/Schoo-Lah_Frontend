import 'package:schoolah_mobile_app/services/fee_data_service.dart';
import 'fees.dart';

List<Fee> mockFee = [
  Fee(
      monthFee: 'January',
      date: '1/1/2021',
      amount: "100.00",
      feeStatus: 'PAID'),
  Fee(
      monthFee: 'Books x 5',
      date: '1/1/2021',
      amount: "60.00",
      feeStatus: 'PAID'),
  Fee(
      monthFee: 'February',
      date: '13/2/2021',
      amount: "100.00",
      feeStatus: 'PAID'),
  Fee(
      monthFee: 'March',
      date: '15/3/2021',
      amount: "100.00",
      feeStatus: 'PAID'),
  Fee(
      monthFee: 'April',
      date: '22/4/2021',
      amount: "100.00",
      feeStatus: 'PAID'),
  Fee(
      monthFee: 'May',
      date: '13/5/2021',
      amount: "100.00",
      feeStatus: 'UNPAID'),
];

class FeeDataServiceMock implements FeeDataService {
  Future<List<Fee>> getFeeList() async {
    return [...mockFee];
  }
}
