import 'package:dio/dio.dart';
import 'package:traffic_app/features/license/data/models/license_category_model.dart';
import '../../../../core/error/failures.dart';

abstract class LicenseRemoteDataSource {
  Future<List<LicenseCategoryModel>> getLicenseTypes();
}

class LicenseRemoteDataSourceImpl implements LicenseRemoteDataSource {
  final Dio dio;

  LicenseRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<LicenseCategoryModel>> getLicenseTypes() async {
    try {
      final response = await dio.get('/licenses/categories');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => LicenseCategoryModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
