import 'package:schoolah_mobile_app/models/fees.dart';

import '../dependencies.dart';
import './rest_service.dart';
import 'fee_service.dart';

class FeeServiceRest implements FeeService {
  //------- Here is how we implement 'Singleton pattern' in Dart --------

  static final FeeServiceRest _instance = FeeServiceRest._constructor();
  factory FeeServiceRest() {
    return _instance;
  }

  FeeServiceRest._constructor();
  final rest = service<RestService>();

  Future<List<Fee>> getAllFees() async {
    final listJson = await rest.get('fees');

    return (listJson as List)
        .map((itemJson) => Fee.fromJson(itemJson))
        .toList();
  }
}
