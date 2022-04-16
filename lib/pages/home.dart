import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petterns_bloc/blocs/list_post_cubit.dart';
import 'package:petterns_bloc/blocs/list_post_state.dart';
import 'package:petterns_bloc/pages/create_post_page.dart';
import 'package:petterns_bloc/views/views_of_home.dart';

class Home extends StatefulWidget {
  static final String id = "home_page";
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).initialize_future();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("setState"),
      ),
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (context, state) {
          if (state is ListPostLoaded)
            return all_list_items(h, w, state.future_list!);
          else
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Create_post.id).then((value) {
            if (value != null) {
              // initialize_future();
            }
            FocusScope.of(context).requestFocus(FocusNode());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
