/*
Normal
{
    "data": any,
    "error": null
}
Error
{
    "data": null,
    "error": {
            "code": 1029,
            "message": "User not found!."
        }
}
 */
import 'dart:core';

class BaseResponse<T> {
  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  T data;
  BaseError error;

  /// Abstract json to data
  T jsonToData(dynamic dataJson) {
    return null;
  }

  /// Abstract data to json
  dynamic dataToJson(T data) {
    return null;
  }

  /// Parsing data to object
  dynamic parsing(Map<String, dynamic> fullJson,
      {String dataKey = 'data', String errorKey = 'error'}) {
    if (fullJson != null) {
      data = fullJson[dataKey] != null ? jsonToData(fullJson[dataKey]) : null;
      error = fullJson[errorKey] != null
          ? BaseError.fromJson(fullJson[errorKey] as Map<String, dynamic>)
          : null;
    }
  }

  /// Data to json
  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data != null ? dataToJson(data) : null,
        'error': error?.toJson(),
      };

  @override
  String toString() {
    return 'BaseResponse{data: $data, error: $error}';
  }
}

class BaseError {
  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
        code: json['code'] as int,
        message: json['message'] as String,
      );

  int code;
  String message;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'message': message,
      };

  @override
  String toString() {
    return 'BaseError{code: $code, message: $message}';
  }
}

// Example
///*
//Error
//{
//	"data": null,
//	"error": {
//		"code": 1029,
//		"message": "User not found!."
//	}
//}
//
//Successful
//{
//	"data": {
//		"token_type": "Bearer",
//		"expires_in": 1295998,
//		"access_token": "nhancv_dep_trai",
//		"refresh_token": "call_nhancv_dep_trai"
//	}
//}
// */
//
//import 'base_response.dart';
//
//class Credential {
//  Credential(
//      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});
//
//  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
//    tokenType: json['token_type'] as String,
//    expiresIn: json['expires_in'] as int,
//    accessToken: json['access_token'] as String,
//    refreshToken: json['refresh_token'] as String,
//  );
//
//  final String tokenType;
//  final int expiresIn;
//  final String accessToken;
//  final String refreshToken;
//
//  Map<String, dynamic> toJson() => <String, dynamic>{
//    'tokenType': tokenType,
//    'expiresIn': expiresIn,
//    'accessToken': accessToken,
//    'refreshToken': refreshToken,
//  };
//}
//
//class LoginResponse extends BaseResponse<Credential> {
//  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson);
//
//  @override
//  Map<String, dynamic> dataToJson(Credential data) {
//    return data.toJson();
//  }
//
//  @override
//  Credential jsonToData(Map<String, dynamic> dataJson) {
//    return Credential.fromJson(dataJson);
//  }
//}

/// With extra token response
///*
//Error
//{
//    "data": null,
//    "error": {
//            "code": 1029,
//            "message": "User not found!."
//        }
//}
//
//Successful
//{
//    "token": "Bearer",
//}
// */
//
//import 'base-response.model.dart';
//
//class LoginResponseModel extends BaseResponseModel<dynamic> {
//  LoginResponseModel(Map<String, dynamic> fullJson) : super(fullJson) {
//    token = fullJson['token'] as String;
//  }
//
//  String token;
//
//  @override
//  Map<String, dynamic> toJson() {
//    return <String, dynamic>{
//      'token': token,
//      ... super.toJson()
//    };
//  }
//
//}
