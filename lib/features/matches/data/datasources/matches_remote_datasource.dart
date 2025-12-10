import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/competition_model.dart';
import '../models/match_model.dart';

abstract class MatchesRemoteDataSource {
  Future<List<CompetitionModel>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  });

  Future<MatchModel> getMatch(String id);
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final ApiClient apiClient;

  MatchesRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CompetitionModel>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  }) async {
    final queryParameters = <String, dynamic>{
      if (search != null) 'search': search,
      if (ordering != null) 'ordering': ordering,
      if (isLive != null) 'is_live': isLive,
      if (startTimestamp != null) 'start_timestamp': startTimestamp,
      if (endTimestamp != null) 'end_timestamp': endTimestamp,
    };

    final response = await apiClient.get(
      AppConstants.matchesListUrl,
      queryParameters: queryParameters,
    );

    if (response is! List) {
      return [];
    }

    return response
        .where((competition) => competition != null)
        .map((competition) =>
            CompetitionModel.fromJson(competition as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MatchModel> getMatch(String id) async {
    // Assuming the API client returns the parsed JSON directly or throws on error.
    // If it returns a raw response object, you'd need to check status code and parse data.
    final response = await apiClient.get('${AppConstants.matchesListUrl}$id/');

    if (response is! Map<String, dynamic>) {
      // Or throw a specific exception if the response format is unexpected
      throw Exception('Unexpected response format for getMatch');
    }

    return MatchModel.fromJson(response);
  }
}
