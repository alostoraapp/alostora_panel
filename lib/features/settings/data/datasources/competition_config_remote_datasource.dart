import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/competition_config_model.dart';
import '../models/competition_search_model.dart';

abstract class CompetitionConfigRemoteDataSource {
  Future<List<CompetitionConfigModel>> getConfigs({String? search});
  Future<CompetitionConfigModel> addConfig(String competitionId);
  Future<CompetitionConfigModel> toggleStatus(String id, bool isActive);
  Future<void> deleteConfig(String id);
  Future<void> reorderConfigs(List<String> orderedIds);
  Future<List<CompetitionSearchModel>> searchCompetitions({required String query, int page = 1, int pageSize = 10});
}

class CompetitionConfigRemoteDataSourceImpl implements CompetitionConfigRemoteDataSource {
  final ApiClient _apiClient;

  CompetitionConfigRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<CompetitionConfigModel>> getConfigs({String? search}) async {
    final response = await _apiClient.get(
      AppConstants.competitionConfigsUrl,
      queryParameters: search != null ? {'search': search} : null,
    );
    return (response as List).map((e) => CompetitionConfigModel.fromJson(e)).toList();
  }

  @override
  Future<CompetitionConfigModel> addConfig(String competitionId) async {
    final response = await _apiClient.post(
      AppConstants.competitionConfigsUrl,
      data: {'competition': competitionId, 'is_active_by_default': true},
    );
    return CompetitionConfigModel.fromJson(response);
  }

  @override
  Future<CompetitionConfigModel> toggleStatus(String id, bool isActive) async {
    final response = await _apiClient.patch(
      '${AppConstants.competitionConfigsUrl}$id/',
      data: {'is_active_by_default': isActive},
    );
    return CompetitionConfigModel.fromJson(response);
  }

  @override
  Future<void> deleteConfig(String id) async {
    await _apiClient.delete('${AppConstants.competitionConfigsUrl}$id/');
  }

  @override
  Future<void> reorderConfigs(List<String> orderedIds) async {
    await _apiClient.post(
      AppConstants.competitionConfigsReorderUrl,
      data: {'ordered_ids': orderedIds},
    );
  }

  @override
  Future<List<CompetitionSearchModel>> searchCompetitions({required String query, int page = 1, int pageSize = 10}) async {
    final response = await _apiClient.get(
      '/v1/entities/admin/competition/search/',
      queryParameters: {
        'search': query,
        'page': page,
        'page_size': pageSize,
      },
    );
    final searchResponse = CompetitionSearchResponseModel.fromJson(response);
    return searchResponse.results;
  }
}
