import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/create_post_state.dart';
import 'package:petterns_bloc/models/post_model.dart';
import 'package:petterns_bloc/services/http_server.dart';
import 'package:petterns_bloc/utils/navigation.dart';

class CreateCubit extends Cubit<CreatePostState> {
  CreateCubit()
      : super(CreatePostState(
            isloading: false,
            control1: TextEditingController(),
            control2: TextEditingController()));

  Create_new_post(BuildContext context, control1, control2) async {
    var text1 = control1.text.trim();
    var text2 = control2.text.trim();
    if (text1.isNotEmpty && text2.isNotEmpty) {
      emit(CreatePostState(
          isloading: true, control1: control1, control2: control2));
      var posts = await Rest_APi.GET_parsed_list();
      var new_post = Post(0, text1, text2);
      await Rest_APi.POST(new_post);
      emit(CreatePostState(
          isloading: false, control1: control1, control2: control2));
      MyNavigation.pop(context, result: "new post");
    } else {
      var message = (text1.isEmpty && text2.isEmpty)
          ? "Title and Body"
          : text1.isEmpty
              ? "Title"
              : "Body";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message + " are empty",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: .5),
          ),
          action: SnackBarAction(
            label: 'Exit',
            onPressed: () {
              MyNavigation.pop(context);
            },
          ),
        ),
      );
    }
  }
}
