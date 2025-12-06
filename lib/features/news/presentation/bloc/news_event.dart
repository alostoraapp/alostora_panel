import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final int limit;
  final int offset;

  const GetNewsEvent({this.limit = 10, this.offset = 0});

  @override
  List<Object> get props => [limit, offset];
}

class CreateNewsEvent extends NewsEvent {
  final Map<String, dynamic> newsData;

  const CreateNewsEvent(this.newsData);

  @override
  List<Object> get props => [newsData];
}

class UpdateNewsEvent extends NewsEvent {
  final String id;
  final Map<String, dynamic> newsData;

  const UpdateNewsEvent(this.id, this.newsData);

  @override
  List<Object> get props => [id, newsData];
}

class DeleteNewsEvent extends NewsEvent {
  final String id;

  const DeleteNewsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ApproveNewsEvent extends NewsEvent {
  final String id;
  final Map<String, dynamic> statusData;

  const ApproveNewsEvent(this.id, this.statusData);

  @override
  List<Object> get props => [id, statusData];
}
