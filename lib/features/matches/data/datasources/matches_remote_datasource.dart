import '../../../../core/config/constants.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/services/api_client.dart';
import '../models/competition_model.dart';

abstract class MatchesRemoteDataSource {
  Future<List<CompetitionModel>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  });
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final ApiClient _apiClient;
  final LanguageCubit _languageCubit;

  MatchesRemoteDataSourceImpl(this._apiClient, this._languageCubit);

  @override
  Future<List<CompetitionModel>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  }) async {
    final lang = _languageCubit.state.languageCode == 'ar' ? 'ar' : 'en';
    final queryParameters = <String, dynamic>{
      'lang': lang,
      if (search != null) 'search': search,
      if (ordering != null) 'ordering': ordering,
      if (isLive != null) 'is_live': isLive,
      if (startTimestamp != null) 'start_timestamp': startTimestamp,
      if (endTimestamp != null) 'end_timestamp': endTimestamp,
    };

    final response = await _apiClient.get(
      AppConstants.matchesListUrl,
      queryParameters: queryParameters,
    );

    if (response is! List) {
      return [];
    }

    return response
        .where((competition) => competition != null)
        .map((competition) => CompetitionModel.fromJson(competition as Map<String, dynamic>))
        .toList();
  }
}
