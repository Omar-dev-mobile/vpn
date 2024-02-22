import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:vpn/core/error/exception.dart';

class HandlerErrorNative {
  static Failure handle(dynamic error) {
    print(error);
    if (error is PlatformException) {
      return Failure(
        errorMessage: error.message ??
            "Error connecting to the server, please try again later",
      );
    } else {
      return Failure(
        errorMessage: "An unexpected error occurred",
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
