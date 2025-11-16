import 'package:equatable/equatable.dart';

class TokenResponseModel extends Equatable {
  final String access;
  final String refresh;

  const TokenResponseModel({required this.access, required this.refresh});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );
  }

  @override
  List<Object?> get props => [access, refresh];
}