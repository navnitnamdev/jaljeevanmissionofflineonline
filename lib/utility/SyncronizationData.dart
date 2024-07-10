
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:jaljeevanmissiondynamic/database/DataBaseHelperJalJeevan.dart';

import '../localdatamodel/Villagelistdatalocaldata.dart';


class SyncronizationData {
  static Future<bool> isInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
// I am connected to a mobile network.
      if (await DataConnectionChecker().hasConnection) {
        print("mobile data detect");
        return true;
      } else {
        print("no internet");
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
// I am connected to a wifi network.
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detect");
        return true;
      } else {
        print("no wifi internet");
        return false;
      }
    } else {
      print("no wifi and no mobile data");
      return false;
    }
  }


  final  conn = DatabaseHelperJalJeevan.instance;
  Future<List<Villagelistlocaldata>> fatchvillagelist() async {
    var dbClient = await conn.db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('jaljeevanvillagelisttable');
    return queryResult.map((e) => Villagelistlocaldata.fromMap(e)).toList();
  }
}
