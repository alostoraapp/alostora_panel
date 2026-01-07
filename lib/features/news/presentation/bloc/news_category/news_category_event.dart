import 'package:equatable/equatable.dart';

abstract class NewsCategoryEvent extends Equatable {
  const NewsCategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetNewsCategoriesEvent extends NewsCategoryEvent {
  const GetNewsCategoriesEvent();
}

class AddNewsCategoryEvent extends NewsCategoryEvent {
  final Map<String, dynamic> body;

  const AddNewsCategoryEvent(this.body);

  @override
  List<Object?> get props => [body];
}

class UpdateNewsCategoryEvent extends NewsCategoryEvent {
  final String id;
  final Map<String, dynamic> body;

  const UpdateNewsCategoryEvent(this.id, this.body);

  @override
  List<Object?> get props => [id, body];
}

class ToggleNewsCategoryStatusEvent extends NewsCategoryEvent {
  final String id;
  final bool isActive;

  const ToggleNewsCategoryStatusEvent(this.id, this.isActive);

  @override
  List<Object?> get props => [id, isActive];
}

class DeleteNewsCategoryEvent extends NewsCategoryEvent {
  final String id;

  const DeleteNewsCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ReorderNewsCategoriesEvent extends NewsCategoryEvent {
  final List<String> orderedIds;
  final int oldIndex;
  final int newIndex;

  const ReorderNewsCategoriesEvent(
      this.orderedIds, this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [orderedIds, oldIndex, newIndex];
}
