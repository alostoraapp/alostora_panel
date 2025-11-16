import 'package:equatable/equatable.dart';

// This model maps directly to your custom backend error schema
class ErrorResponseModel extends Equatable {
  final String status;
  final String message;
  final List<String> errors;

  const ErrorResponseModel({
    required this.status,
    required this.message,
    required this.errors,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      status: json['status'] ?? 'error',
      message: json['message'] ?? 'An unknown error occurred.',
      // Ensure 'errors' is always a list of strings
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }

  // Helper to get the first, most relevant error message
  String get firstError => errors.isNotEmpty ? errors.first : message;

  @override
  List<Object?> get props => [status, message, errors];
}