import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/traffic_sign_category_model.dart';
import '../models/traffic_sign_model.dart';

abstract class TrafficSignRemoteDataSource {
  Future<List<TrafficSignCategoryModel>> getTrafficSignCategories();
  Future<List<TrafficSignModel>> getTrafficSignsByGroup(String group);
}

class TrafficSignRemoteDataSourceImpl implements TrafficSignRemoteDataSource {
  final Dio dio;

  TrafficSignRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TrafficSignCategoryModel>> getTrafficSignCategories() async {
    try {
      final response = await dio.get('/traffic-signs/categories');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => TrafficSignCategoryModel.fromJson(json as String))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TrafficSignModel>> getTrafficSignsByGroup(String group) async {
    try {
      final response = await dio.get('/traffic-signs/group/$group');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => TrafficSignModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
