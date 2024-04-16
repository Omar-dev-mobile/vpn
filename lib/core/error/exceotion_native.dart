import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:vpn/core/error/exception.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class HandlerErrorNative {
  static Failure handle(dynamic error) {
    print(error);
    if (error is PlatformException) {
      return Failure(
        errorMessage: error.message ??
            LocaleKeys.failedToConnectToTheServerPleaseTryAgainLater.tr(),
      );
    } else {
      return Failure(
        errorMessage: LocaleKeys.anUnexpectedErrorOccurred.tr(),
      );
    }
  }

  Future<Either<String, T>> executeNativeHandleError<T>(
      Function() function) async {
    try {
      final result = await function();
      return Right(result);
    } catch (e) {
      final failure = handle(e);
      return Left(failure.message);
    }
  }
}
