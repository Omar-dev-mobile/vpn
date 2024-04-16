import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class Failure {
  final String? errorMessage;

  String get message => errorMessage ?? '';

  Failure({
    this.errorMessage,
  });

  @override
  String toString() {
    if (message.isNotEmpty) {
      return message;
    } else {
      return "Something went wrong, Please try again";
    }
  }
}

class UnknownException extends Failure {
  final String? errMessage;
  UnknownException([this.errMessage]) : super(errorMessage: errMessage);

  @override
  String toString() {
    if ((errMessage ?? '').isNotEmpty) {
      return message;
    } else {
      return LocaleKeys.somethingWentWrongPleaseTryAgain.tr();
    }
  }
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return Failure(
        errorMessage: error.message ??
            LocaleKeys.failedToConnectToTheServerPleaseTryAgainLater.tr(),
      );
    } else if (error is NoInternetException) {
      return Failure(
        errorMessage: LocaleKeys.itSeemsYoureNotConnectedToTheInternet.tr(),
      );
    } else if (error is Exception) {
      return Failure(errorMessage: error.toString());
    } else {
      return Failure(
        errorMessage: LocaleKeys.anUnexpectedErrorOccurred.tr(),
      );
    }
  }
}

class NoInternetException implements Exception {}
