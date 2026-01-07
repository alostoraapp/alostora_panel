import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/services/api_client.dart';
import '../models/news_category_model.dart';

abstract class NewsCategoryRemoteDataSource {
  Future<List<NewsCategoryModel>> getNewsCategories();
  Future<NewsCategoryModel> addNewsCategory(Map<String, dynamic> body);
  Future<NewsCategoryModel> updateNewsCategory(
      String id, Map<String, dynamic> body);
  Future<NewsCategoryModel> getNewsCategory(String id);
  Future<NewsCategoryModel> toggleNewsCategoryStatus(String id, bool isActive);
  Future<void> deleteNewsCategory(String id);
  Future<void> reorderNewsCategories(List<String> orderedIds);
}

class NewsCategoryRemoteDataSourceImpl implements NewsCategoryRemoteDataSource {
  final ApiClient _apiClient;

  NewsCategoryRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<NewsCategoryModel>> getNewsCategories() async {
    final response = await _apiClient.get(
      AppConstants.newsCategoriesListUrl,
    );
    // Based on API docs, it returns a list directly, not inside 'results' wrapper like pagination results
    // GET /v1/admin/media/news/categories/ returns:
    // [
    //   { "id": ... }
    // ]
    // So it is a direct list.
    return (response as List)
        .map((json) => NewsCategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<NewsCategoryModel> addNewsCategory(Map<String, dynamic> body) async {
    final response = await _apiClient.post(
      AppConstants.newsCategoriesListUrl,
      data: body,
    );
    return NewsCategoryModel.fromJson(response);
  }

  @override
  Future<NewsCategoryModel> updateNewsCategory(
      String id, Map<String, dynamic> body) async {
    final response = await _apiClient.patch(
      AppConstants.getNewsCategoryUrl(id),
      data: body,
    );
    return NewsCategoryModel.fromJson(response);
  }

  @override
  Future<NewsCategoryModel> getNewsCategory(String id) async {
    final response = await _apiClient.get(
      AppConstants.getNewsCategoryUrl(id),
    );
    return NewsCategoryModel.fromJson(response);
  }

  @override
  Future<NewsCategoryModel> toggleNewsCategoryStatus(
      String id, bool isActive) async {
    final response = await _apiClient.patch(
      AppConstants.getNewsCategoryUrl(id),
      data: {'is_active': isActive},
    );
    return NewsCategoryModel.fromJson(response);
  }

  @override
  Future<void> deleteNewsCategory(String id) async {
    await _apiClient.delete(
      AppConstants.getNewsCategoryUrl(id),
    );
  }

  @override
  Future<void> reorderNewsCategories(List<String> orderedIds) async {
    await _apiClient.post(
      AppConstants.newsCategoriesReorderUrl,
      data: {'ordered_ids': orderedIds},
    );
  }
}
