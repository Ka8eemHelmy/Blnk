import 'package:dio/dio.dart';
import 'end_points.dart';

//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          // 'lang': 'en',
        },
      ),
    );
    // dio.interceptors.add(CurlLoggerDioInterceptor(
    //   printOnSuccess: true,
    // ));
  }

  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
    String? lang,
    Options? options,
  }) async {
    try {
      dio.options.headers = {
        'api_access_token': token ?? '',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    FormData? formData,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'api_access_token': token ?? '',
        'Content-Type': formData != null ? 'multipart/form-data' : 'application/json',
      };
      final Response response = await dio.post(
        url,
        data: formData ?? data,
        queryParameters: query,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    FormData? formData,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'api_access_token': token ?? '',
        'Content-Type': formData != null ? 'multipart/form-data' : 'application/json',
      };
      final Response response = await dio.put(
        url,
        data: formData ?? data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'api_access_token': token,
      'Content-Type': 'application/json',
    };
    return await dio.patch(
      url,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'api_access_token': '$token',
      };
      final Response response = await dio.delete(
        url,
        queryParameters: params,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
