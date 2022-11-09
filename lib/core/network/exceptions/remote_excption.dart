import 'package:watch/core/network/models/error_model.dart';

class RemoteException implements Exception {
  final ErrorMessageModel errorMessageModel;
  RemoteException(this.errorMessageModel);
}
