import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:petterns_bloc/blocs/list_post_cubit.dart';
import 'package:petterns_bloc/blocs/update_post_cubit.dart';
import 'package:petterns_bloc/models/post_model.dart';
import 'package:petterns_bloc/pages/create_post_page.dart';
import 'package:petterns_bloc/pages/update_post_page.dart';
import 'package:petterns_bloc/utils/navigation.dart';

Widget all_list_items(h, w, Future<List<Post>?> list_posts, Function() func) =>
    Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://i.pinimg.com/originals/4b/f2/b3/4bf2b361a67b3030b185fd7447b279b5.jpg"),
              fit: BoxFit.fill)),
      child: FutureBuilder<List<Post>?>(
        future: list_posts,
        builder: (BuildContext context, snp) {
          if (snp.connectionState == ConnectionState.done) {
            return snp.data!.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snp.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return items_builder(snp.data![index], func);
                    },
                  )
                : Center(
                    child: Text(
                      "No data",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .5),
                    ),
                  );
          } else if (snp.connectionState == ConnectionState.waiting) {
            return Container(
              height: h,
              width: w,
              color: Colors.black.withOpacity(.4),
              child: Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Container();
        },
      ),
    );

Widget items_builder(Post p, Function() fun) => Slidable(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                p.fullname,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                p.phone,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      startActionPane:
          ActionPane(extentRatio: .25, motion: const ScrollMotion(), children: [
        SlidableAction(
          // Edite function
          onPressed: (BuildContext context) async {
            print("keldi = ${p.id}");
            MyNavigation.push(context, Update_post(post: p)).then((value) {
              if (value == "new") {
                fun();
              }
            });
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edite',
        ),
      ]),
      endActionPane:
          ActionPane(extentRatio: .25, motion: const ScrollMotion(), children: [
        SlidableAction(
          // delete function
          onPressed: (BuildContext context) {
            BlocProvider.of<ListPostCubit>(context).Delete_post(p);
          },
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
    );
