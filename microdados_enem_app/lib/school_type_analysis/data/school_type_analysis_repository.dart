import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/api/app_cache.dart';
import 'package:microdados_enem_app/core/api/microdados_api.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/school_type_analysis/data/models.dart';

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

  Future<ScoreAverageBySchoolTypeResponse> getScoreAverageBySchoolType(
    BuildContext context,
  ) async {
    final route = 'analysis/score-average-by-school-type';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return ScoreAverageBySchoolTypeResponse.fromJson(response);
  }

  Future<ScoreDistributionBySchoolTypeResponse>
  getScoreDistributionBySchoolType(BuildContext context, ExamArea area) async {
    final route = 'analysis/score-distribution-by-school-type/${area.name}';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return ScoreDistributionBySchoolTypeResponse.fromJson(response);
  }

  Future<ScoreDistributionBySchoolTypeResponse>
  getScoreDistributionBySchoolTypeForEssay(BuildContext context) async {
    final route = 'analysis/score-distribution-by-school-type/essay';

    final response = await _httpClient.get(
      route,
      timeout: Duration(seconds: 10),
      cache: AppCache(context: context, key: route),
    );
    return ScoreDistributionBySchoolTypeResponse.fromJson(response);
  }
}
