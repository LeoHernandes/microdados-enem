import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';

class SchoolTypeAnalysisRepository {
  final AppHttpClient _httpClient = AppHttpClient();

  SchoolTypeAnalysisRepository();

  Future<SchoolTypeDistrubtionResponse> getSchoolTypeDistribution(
    BuildContext context,
  ) async {
    final route = 'analysis/school-type-distribution';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return SchoolTypeDistrubtionResponse.fromJson(response);
  }
}

class SchoolTypeDistrubtionResponse {
  final int unknownCount;
  final int publicCount;
  final int privateCount;

  const SchoolTypeDistrubtionResponse({
    required this.unknownCount,
    required this.publicCount,
    required this.privateCount,
  });

  factory SchoolTypeDistrubtionResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'unknownCount': final unknownCount,
        'publicCount': final publicCount,
        'privateCount': final privateCount,
      } =>
        SchoolTypeDistrubtionResponse(
          unknownCount: unknownCount.toInt(),
          publicCount: publicCount.toInt(),
          privateCount: privateCount.toInt(),
        ),
      _ =>
        throw const FormatException(
          'Failed to load analysis school type distribution.',
        ),
    };
  }
}
