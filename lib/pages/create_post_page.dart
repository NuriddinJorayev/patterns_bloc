import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/create_post_cubit.dart';
import 'package:petterns_bloc/blocs/create_post_state.dart';
import 'package:petterns_bloc/views/views_of_create.dart';
import 'package:petterns_bloc/widgets/text_field.dart';

class Create_post extends StatefulWidget {
  static final String id = "create_post";
  Create_post({
    Key? key,
  }) : super(key: key);

  @override
  State<Create_post> createState() => _Create_postState();
}

class _Create_postState extends State<Create_post> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => CreateCubit(),
      child: BlocBuilder<CreateCubit, CreatePostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Create Post"),
            ),
            body: body_of_create(
                h, w, state.control1, state.control2, state.isloading),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                BlocProvider.of<CreateCubit>(context)
                    .Create_new_post(context, state.control1, state.control2);
              },
              child: Icon(Icons.send),
            ),
          );
        },
      ),
    );
  }
}
