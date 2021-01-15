import 'package:schoolah_mobile_app/models/fees.dart';

abstract class FeeDataService {
  Future<List<Fee>> getFeeList();
}
