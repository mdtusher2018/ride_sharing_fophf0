import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

class ApiClient {
  final http.Client _httpClient;

  ApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<dynamic> get(Uri url, {Map<String, String>? headers}) async {
    final response = await _httpClient.get(url, headers: headers);
    return _processResponse(response);
  }

  Future<dynamic> post(
    Uri url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _httpClient.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(
    Uri url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _httpClient.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> patch(
    Uri url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _httpClient.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(Uri url, {Map<String, String>? headers}) async {
    final response = await _httpClient.delete(url, headers: headers);
    return _processResponse(response);
  }

  Future<dynamic> sendMultipart(
    Uri url, {
    String method = 'POST',
    Map<String, String>? headers,
    Map<String, dynamic>? fields,
    Map<String, List<File>>? files,
    dynamic body,
    String bodyFieldName = 'data',
  }) async {
    final request = http.MultipartRequest(method.toUpperCase(), url);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    // Form fields
    if (fields != null) {
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    // Files (multiple files per field)
    if (files != null) {
      for (final entry in files.entries) {
        final fieldName = entry.key;

        for (final file in entry.value) {
          final multipartFile = await http.MultipartFile.fromPath(
            fieldName,
            file.path,
          );
          request.files.add(multipartFile);
        }
      }
    }

    // Optional JSON body
    if (body != null) {
      request.fields[bodyFieldName] = jsonEncode(body);
    }

    log(request.fields.toString());

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    _logResponse(
      statusCode: statusCode,
      url: response.request?.url.toString(),
      method: response.request?.method,
      body: body,
    );
    if (statusCode >= 200 && statusCode < 300) return body;

    throw ApiException(
      statusCode,
      (body?['error'] != null)
          ? body['error']
          : body?['message'] ?? 'Unknown error',
      data: body,
    );
  }

  void _logResponse({
    required int statusCode,
    String? url,
    String? method,
    dynamic body,
  }) {
    final isSuccess = statusCode >= 200 && statusCode < 300;

    final emoji = isSuccess ? '✅' : '❌';
    final title = '$emoji [$statusCode] ${method ?? ''} ${url ?? ''}';

    log(title);

    if (body != null) {
      const encoder = JsonEncoder.withIndent('  ');
      log(encoder.convert(body));
    } else {
      log('No response body');
    }
  }
}
