import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyNavigation {
  static pop(BuildContext context, {String? result}) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context, result);
    });
  }

  static Future<dynamic> push(BuildContext context, Widget page) async {
    dynamic data;

    data =
        await Navigator.push(context, MaterialPageRoute(builder: (_) => page));

    return data;
  }
}
