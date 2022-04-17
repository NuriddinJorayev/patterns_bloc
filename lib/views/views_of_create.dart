import 'package:flutter/material.dart';
import 'package:petterns_bloc/widgets/text_field.dart';

Widget body_of_create(h, w, var control1, var control2, bool isloading) =>
    SingleChildScrollView(
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
    );
