import 'package:equatable/equatable.dart';
import 'package:petterns_bloc/models/post_model.dart';

abstract class ListPostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListPostInit extends ListPostState {}

class ListPostLoading extends ListPostState {}

class ListPostLoaded extends ListPostState {
  final Future<List<Post>?>? future_list;
  ListPostLoaded(this.future_list);
}

class ListPostError extends ListPostState {
  final String error_massage;
  ListPostError(this.error_massage);
}
