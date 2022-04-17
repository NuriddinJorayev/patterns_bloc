import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/list_post_state.dart';
import 'package:petterns_bloc/models/post_model.dart';
import 'package:petterns_bloc/services/http_server.dart';
import 'package:petterns_bloc/utils/navigation.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());
  initialize_future() async {
    emit(ListPostLoading());
    var future = Rest_APi.GET_parsed_list();

    future != null
        ? emit(ListPostLoaded(future))
        : emit(ListPostError("Check your internet"));
  }

  Future<dynamic> page_to(BuildContext context, Widget page) async {
    return MyNavigation.push(context, page);
  }

  Delete_post(Post p) {
    emit(ListPostLoading());
    Rest_APi.DEL(p).then((value) {
      if (value.isNotEmpty) {
        initialize_future();
      } else {
        emit(ListPostError("Check your internet"));
      }
    });
  }
}
