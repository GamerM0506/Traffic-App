import '../../domain/entities/license_entity.dart';

abstract class LicenseState {}

class LicenseInitial extends LicenseState {}

class LicenseLoading extends LicenseState {}

class LicenseLoaded extends LicenseState {
  final List<LicenseCategoryEntity> licenses;
  LicenseLoaded(this.licenses);
}

class LicenseFailure extends LicenseState {
  final String message;
  LicenseFailure(this.message);
}
