import 'package:cloudinary/cloudinary.dart';
import 'package:rmservice/report/models/report.dart';
import 'package:rmservice/utilities/constants/variable.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: debugServer,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  ),
);

class ReportController {
  Future<Report> getReport(
      String userCode, String? from_date, String? to_date) async {
    from_date = from_date == '' ? null : from_date;
    to_date = to_date == '' ? null : to_date;
    
    try {
      final response = await dio.get(
        "/user/$userCode/order-report",
        queryParameters: {
          "from_date": from_date,
          "to_date": to_date,
        },
      );
      if (response.data['code'] == 0) {
        return Report.fromJson(response.data);
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
