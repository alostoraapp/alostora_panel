import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/services/api_client.dart';
import 'package:alostora/features/news/data/models/news_model.dart';
import 'package:alostora/features/news/data/models/team_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews({int limit = 10, int offset = 0});
  Future<NewsModel> createNews(Map<String, dynamic> newsData);
  Future<NewsModel> updateNews(String id, Map<String, dynamic> newsData);
  Future<void> deleteNews(String id);
  Future<void> approveNews(String id, Map<String, dynamic> statusData);
  Future<NewsImageModel> uploadNewsImage(String id, XFile image,
      {void Function(int, int)? onSendProgress});
  Future<List<TeamModel>> searchTeams(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient _apiClient;

  NewsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<NewsModel>> getNews({int limit = 10, int offset = 0}) async {
    final int page = (offset ~/ limit) + 1;
    final response = await _apiClient.get(
      '${AppConstants.baseUrl}${AppConstants.newsListUrl}',
      queryParameters: {'page': page, 'page_size': limit},
    );
    final List<dynamic> results = response['results'];
    return results
        .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<FormData> _createFormData(Map<String, dynamic> params) async {
    final data = <String, dynamic>{};

    for (var entry in params.entries) {
      if (entry.value is XFile) {
        final XFile file = entry.value;
        final bytes = await file.readAsBytes();
        data[entry.key] = MultipartFile.fromBytes(bytes, filename: file.name);
      } else {
        data[entry.key] = entry.value;
      }
    }
    return FormData.fromMap(data);
  }

  @override
  Future<NewsModel> createNews(Map<String, dynamic> newsData) async {
    final response = await _apiClient.post(
      '${AppConstants.baseUrl}${AppConstants.createNewsUrl}',
      data: newsData,
    );
    return NewsModel.fromJson(response);
  }

  @override
  Future<NewsModel> updateNews(String id, Map<String, dynamic> newsData) async {
    final response = await _apiClient.patch(
      '${AppConstants.baseUrl}${AppConstants.getNewsUrl(id)}',
      data: newsData,
    );
    return NewsModel.fromJson(response);
  }

  @override
  Future<void> deleteNews(String id) async {
    await _apiClient.delete(
      '${AppConstants.baseUrl}${AppConstants.getNewsUrl(id)}',
    );
  }

  @override
  Future<void> approveNews(String id, Map<String, dynamic> statusData) async {
    await _apiClient.post(
      '${AppConstants.baseUrl}${AppConstants.getApproveNewsUrl(id)}',
      data: statusData,
    );
  }

  @override
  Future<NewsImageModel> uploadNewsImage(String id, XFile image,
      {void Function(int, int)? onSendProgress}) async {
    final formData = await _createFormData({'image': image});
    final response = await _apiClient.post(
      '${AppConstants.baseUrl}${AppConstants.getUploadNewsImageUrl(id)}',
      data: formData,
      onSendProgress: onSendProgress,
    );
    return NewsImageModel.fromJson(response);
  }

  @override
  Future<List<TeamModel>> searchTeams(String query) async {
    final response = await _apiClient.get(
      '${AppConstants.baseUrl}${AppConstants.searchTeamsUrl}',
      queryParameters: {'search': query},
    );
    final List<dynamic> results = response['results'];
    return results
        .map((json) => TeamModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
