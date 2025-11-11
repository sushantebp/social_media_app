import 'package:dio/dio.dart';
import 'package:social_media_app/core/core.dart';

class DioClient {
  late final Dio _dio;
  DioClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: {"Content-Type": "application/json"},
      ),
    );
    _dio.interceptors.add(_interceptorsWrapper());
  }

  static final DioClient _instance = DioClient._();
  factory DioClient() => _instance;

  Dio get dio => _dio;

  InterceptorsWrapper _interceptorsWrapper() => InterceptorsWrapper(
    onRequest: (options, handler) async {
      try {
        final token = await SecureStorageService().read(AppConstant.tokenKey);

        if (token != null || token!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } on DioException catch (error) {
        final dioException = DioAppException.fromDioError(error);
        handler.reject(dioException.dioError);
      } catch (error) {
        handler.reject(DioException(requestOptions: options, error: error));
      }
      handler.next(options);
    },
    onResponse: (response, handler) => handler.next(response),
    onError: (error, handler) async {
      final dioException = DioAppException.fromDioError(error);
      final statusCode = dioException.statusCode;

      if (statusCode == 401) {
        await SecureStorageService().delete(AppConstant.tokenKey);
        handler.reject(error);
        return;
      } else if (statusCode == 403) {
        return handler.reject(dioException.dioError);
      }

      handler.next(error);
    },
  );
}
