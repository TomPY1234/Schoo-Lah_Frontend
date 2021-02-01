import 'package:schoolah_mobile_app/models/fees.dart';

abstract class FeeService {
  Future<List<Fee>> getAllFees();
}
