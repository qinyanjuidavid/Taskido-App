import 'package:http_interceptor/http_interceptor.dart';
import 'package:taskido/services/auth_services.dart';

class AuthorizationInterceptor implements InterceptorContract {
  // Intercepts before request is called
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // data.headers["Authorization"] = "Bearer $token";
    print("Before Interception::::${data.toString()}");
    return data;
  }

  // Intercepts after the request is called
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("After Interception::::${data.toString()}");
    return data;
  }
}

//retry policy
class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int maxRetries = 3;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      //refresh token
      //retry request
      // await authService.refreshToken();

      return true;
    }
    return false;
  }
}
