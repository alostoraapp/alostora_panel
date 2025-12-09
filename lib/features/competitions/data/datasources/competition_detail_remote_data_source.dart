import '../../../../core/services/api_client.dart';
import '../models/competition_detail_model.dart';

abstract class CompetitionDetailRemoteDataSource {
  Future<CompetitionDetailModel> getCompetitionDetail(String id);
  Future<CompetitionDetailModel> updateCompetitionDetail(
      String id, Map<String, dynamic> body);
}

class CompetitionDetailRemoteDataSourceImpl
    implements CompetitionDetailRemoteDataSource {
  final ApiClient apiClient;

  CompetitionDetailRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CompetitionDetailModel> getCompetitionDetail(String id) async {
    final response = await apiClient.get(
      '/v1/admin/entities/competitions/$id/detail/',
    );

    return CompetitionDetailModel.fromJson(response);
  }

  @override
  Future<CompetitionDetailModel> updateCompetitionDetail(
      String id, Map<String, dynamic> body) async {
    final response = await apiClient.patch(
      '/v1/admin/entities/competitions/$id/detail/',
      data: body,
    );

    return CompetitionDetailModel.fromJson(response);
  }
}
