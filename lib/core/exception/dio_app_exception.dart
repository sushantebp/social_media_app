import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_media_app/core/core.dart';

class DioAppException extends AppException {
  final DioException dioError;
  final DioExceptionType type;
  final int? statusCode;

  DioAppException._({
    required this.dioError,
    required this.type,
    this.statusCode,
    String? message,
  }) : super(message);

  /// Factory constructor to map DioException to app-friendly exception
  factory DioAppException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DioAppException._(
          dioError: error,
          type: DioExceptionType.connectionTimeout,
          statusCode: null,
          message: "Connection timed out. Please try again.",
        );

      case DioExceptionType.badResponse:
        final status = error.response?.statusCode ?? 0;
        if (status == 401) {
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.badResponse,
            statusCode: status,
            message: "Unauthorized access. Please login again.",
          );
        } else if (status == 403) {
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.badResponse,
            statusCode: status,
            message: "Forbidden - You do not have access to this resource.",
          );
        } else if (status == 400) {
          final serverMessage =
              error.response?.data['message'] ?? "Bad request.";
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.badResponse,
            statusCode: status,
            message: serverMessage,
          );
        } else if (status >= 500) {
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.badResponse,
            statusCode: status,
            message: "Server error. Please try later.",
          );
        } else {
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.badResponse,
            statusCode: status,
            message: "Request failed. Please try again.",
          );
        }

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return DioAppException._(
            dioError: error,
            type: DioExceptionType.unknown,
            statusCode: null,
            message: "No internet connection. Check your network.",
          );
        }
        return DioAppException._(
          dioError: error,
          type: DioExceptionType.unknown,
          statusCode: null,
          message: "Something went wrong. Please try again.",
        );

      default:
        return DioAppException._(
          dioError: error,
          type: DioExceptionType.unknown,
          statusCode: null,
          message: "Unexpected error occurred.",
        );
    }
  }

  @override
  String toString() => 'DioAppException: $message (status code: $statusCode)';
}
