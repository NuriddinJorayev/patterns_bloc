import 'package:flutter/material.dart';
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
  bool isloading = false;
  var control1 = TextEditingController();
  var control2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Post"),
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
                  Text_Field.Create_textFiled("Title", control1, 3),
                  Text_Field.Create_textFiled("Body", control2, 6),
                ],
              ),
            ),
            isloading
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
          //   FocusScope.of(context).requestFocus(FocusNode());
          //   var text1 = control1.text.trim();
          //   var text2 = control2.text.trim();
          //   if (text1.isNotEmpty && text2.isNotEmpty) {
          //     setState(() => isloading = true);
          //     var posts = await Rest_APi.GET_parsed_list(Rest_APi.API_GET);
          //     var id = random_id(posts);
          //     var new_post = Post(int.parse(id), text1, text2, int.parse(id));
          //     await Create_delete_add_function.Create(new_post);
          //     setState(() => isloading = false);
          //     Navigator.pop(context, "new_post");
          //   } else {
          //     var message = (text1.isEmpty && text2.isEmpty)
          //         ? "Title and Body"
          //         : text1.isEmpty
          //             ? "Title"
          //             : "Body";
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(
          //           message + " are empty",
          //           style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               letterSpacing: .5),
          //         ),
          //         action: SnackBarAction(
          //           label: 'Exit',
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //         ),
          //       ),
          //     );
          //   }
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
