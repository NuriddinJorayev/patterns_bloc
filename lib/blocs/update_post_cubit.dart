import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/update_post_state.dart';
import 'package:petterns_bloc/models/post_model.dart';
import 'package:petterns_bloc/services/http_server.dart';
import 'package:petterns_bloc/utils/navigation.dart';

class Update_post_cubit extends Cubit<Update_post_state> {
  final TextEditingController con1;
  final TextEditingController con2;
  final Post? post;
  final bool isloading;

  Update_post_cubit(this.con1, this.con2, this.post, this.isloading)
      : super(Update_post_state(
            control1: con1, control2: con2, post: post, isloading: isloading));

  Update_post(BuildContext context, Post p, var control1, var control2) async {
    var text1 = control1.text.trim();
    var text2 = control2.text.trim();
    if (text1.isNotEmpty && text2.isNotEmpty) {
      emit(Update_post_state(
          control1: control1, control2: control2, post: p, isloading: true));
      p.fullname = text1;
      p.phone = text2;

      print("my id = ${p.id}");
      await Rest_APi.PUT(p);
      emit(Update_post_state(
          control1: control1, control2: control2, post: p, isloading: false));
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        Navigator.pop(context, 'new');
      });
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
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
  }
}
