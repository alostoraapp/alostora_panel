import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/services/api_client.dart';
import 'package:alostora/features/news/data/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews({int limit = 10, int offset = 0});
  Future<NewsModel> createNews(Map<String, dynamic> newsData);
  Future<NewsModel> updateNews(String id, Map<String, dynamic> newsData);
  Future<void> deleteNews(String id);
  Future<void> approveNews(String id, Map<String, dynamic> statusData);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient _apiClient;

  NewsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<NewsModel>> getNews({int limit = 10, int offset = 0}) async {
    final response = await _apiClient.get(
      '${AppConstants.baseUrl}/v1/admin/media/news/',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final List<dynamic> results = response['results'];
    return results
        .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<FormData> _createFormData(Map<String, dynamic> params) async {
    final data = <String, dynamic>{};

    for (var entry in params.entries) {
      if (entry.key == 'title_translations' && entry.value is List) {
        List list = entry.value;
        for (int i = 0; i < list.length; i++) {
          Map item = list[i];
          item.forEach((key, value) {
            data['title_translations[$i][$key]'] = value;
          });
        }
      } else if (entry.key == 'content_translations' && entry.value is List) {
        List list = entry.value;
        for (int i = 0; i < list.length; i++) {
          Map item = list[i];
          item.forEach((key, value) {
            data['content_translations[$i][$key]'] = value;
          });
        }
      } else if (entry.value is XFile) {
        final XFile file = entry.value;
        final bytes = await file.readAsBytes();
        data[entry.key] = MultipartFile.fromBytes(bytes, filename: file.name);
      } else if (entry.value is List &&
          (entry.value as List).isNotEmpty &&
          (entry.value as List).first is XFile) {
        final files = <MultipartFile>[];
        for (var item in entry.value) {
          if (item is XFile) {
            final bytes = await item.readAsBytes();
            files.add(MultipartFile.fromBytes(bytes, filename: item.name));
          }
        }
        data[entry.key] = files;
      } else {
        data[entry.key] = entry.value;
      }
    }
    return FormData.fromMap(data);
  }

  @override
  Future<NewsModel> createNews(Map<String, dynamic> newsData) async {
    // Check if we need to upload a file
    bool hasFile = newsData.values.any((value) =>
        value is XFile ||
        (value is List && value.isNotEmpty && value.first is XFile));

    dynamic data;
    if (hasFile) {
      data = await _createFormData(newsData);
    } else {
      data = newsData;
    }

    final response = await _apiClient.post(
      '${AppConstants.baseUrl}/v1/admin/media/news/',
      data: data,
    );
    return NewsModel.fromJson(response);
  }

  @override
  Future<NewsModel> updateNews(String id, Map<String, dynamic> newsData) async {
    // Check if we need to upload a file
    bool hasFile = newsData.values.any((value) =>
        value is XFile ||
        (value is List && value.isNotEmpty && value.first is XFile));

    dynamic data;
    if (hasFile) {
      data = await _createFormData(newsData);
    } else {
      data = newsData;
    }

    final response = await _apiClient.patch(
      '${AppConstants.baseUrl}/v1/admin/media/news/$id/',
      data: data,
    );
    return NewsModel.fromJson(response);
  }

  @override
  Future<void> deleteNews(String id) async {
    await _apiClient.delete(
      '${AppConstants.baseUrl}/v1/admin/media/news/$id/',
    );
  }

  @override
  Future<void> approveNews(String id, Map<String, dynamic> statusData) async {
    await _apiClient.post(
      '${AppConstants.baseUrl}/v1/admin/media/news/$id/approve/',
      data: statusData,
    );
  }
}
