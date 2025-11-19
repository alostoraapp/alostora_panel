import 'package:equatable/equatable.dart';

class CompetitionSearchEntity extends Equatable {
  final String id;
  final String name;
  final String logo;

  const CompetitionSearchEntity({
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  List<Object?> get props => [id, name, logo];
}
