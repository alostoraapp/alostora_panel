import '../../domain/entities/competition_search_entity.dart';

class CompetitionSearchModel extends CompetitionSearchEntity {
  const CompetitionSearchModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory CompetitionSearchModel.fromJson(Map<String, dynamic> json) {
    return CompetitionSearchModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class CompetitionSearchResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<CompetitionSearchModel> results;

  CompetitionSearchResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory CompetitionSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return CompetitionSearchResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null
          ? (json['results'] as List)
              .map((e) => CompetitionSearchModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
