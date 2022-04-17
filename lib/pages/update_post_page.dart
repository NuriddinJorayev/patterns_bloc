import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/update_post_cubit.dart';
import 'package:petterns_bloc/blocs/update_post_state.dart';
import 'package:petterns_bloc/models/post_model.dart';
import 'package:petterns_bloc/widgets/text_field.dart';

// ignore: must_be_immutable
class Update_post extends StatefulWidget {
  Post post;
  static final String id = "update_post";
  Update_post({Key? key, required this.post}) : super(key: key);

  @override
  State<Update_post> createState() => _Update_postState();
}

class _Update_postState extends State<Update_post> {
  var con1 = TextEditingController();
  var con2 = TextEditingController();
  @override
  void initState() {
    con1.text = widget.post.fullname;
    con2.text = widget.post.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => Update_post_cubit(con1, con2, widget.post, false),
      child: BlocBuilder<Update_post_cubit, Update_post_state>(
        builder: (context, state) {
          print("con1 = ${state.control1.text}");
          print("con2 = ${state.control2.text}");
          print("post id = ${widget.post.id}");
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Edite Post"),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: h,
                    width: w,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text_Field.Create_textFiled("Title", state.control1, 3),
                        Text_Field.Create_textFiled("Body", state.control2, 6),
                      ],
                    ),
                  ),
                  state.isloading
                      ? Container(
                          height: h,
                          width: w,
                          color: Colors.black.withOpacity(.4),
                          child: Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                var p = Post(widget.post.id, state.control1.text.trim(),
                    state.control2.text.trim());
                var v = BlocProvider.of<Update_post_cubit>(context)
                    .Update_post(context, p, state.control1, state.control2);
              },
              child: Icon(Icons.update),
            ),
          );
        },
      ),
    );
  }
}
