abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("Không có kết nối Internet");
}

class CacheFailure extends Failure {
  CacheFailure() : super('Lỗi truy cập bộ nhớ đệm');
}

class ServerException implements Exception {}