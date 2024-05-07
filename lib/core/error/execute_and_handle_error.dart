import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/exception.dart';
import 'package:vpn/core/shared/usecases/network_info.dart';
import 'package:vpn/locator.dart';
// Custom helper function for make our code more clean.

// T → is a generic type define the return type [String, bool, etc..l.

/// The helper will take function and execute it with try catch block.

// if the execution success then it will return the result.

//if the execution failed then it will handle the error and return it.

Future<Either<String, T>> executeAndHandleError<T>(
  Future<T> Function() function,
) async {
  try {
    final internet = await locator<NetworkChecker>().isConnected;
    if (!internet) throw NoInternetException();
    final result = await function();
    return Right(result);
  } catch (e, s) {
    print('Stack trace in execute And Handle Error$s');
    if (e is String) return Left(e);
    final failure = ErrorHandler.handle(e);
    return Left(failure.errorMessage ?? "");
  }
}

Future<T> executeAndHandleErrorServer<T>(
  Future<T> Function() function,
) async {
  try {
    final internet = await locator<NetworkChecker>().isConnected;
    if (!internet) throw NoInternetException();
    final result = await function();
    return result;
  } on DioException catch (error) {
    if (error.response?.statusCode == 401) {
      BuildContext? context = navigatorKey.currentState?.context;
      if (context != null) {
        navigatorKey.currentState?.popUntil((route) {
          if (route.settings.name != '/login') {
            navigatorKey.currentState?.pushNamed('/login');
          }
          return true;
        });
      }
    }
    throw DioException(
        message: error.response?.data?["error_status"].toString(),
        requestOptions: error.requestOptions);
  } on NoInternetException {
    throw NoInternetException();
  } on Exception catch (error, s) {
    throw Exception(error.toString());
  }
}
