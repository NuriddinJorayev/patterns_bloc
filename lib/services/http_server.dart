import 'dart:convert';

import 'package:http/http.dart';
import 'package:petterns_bloc/models/post_model.dart';

class Rest_APi {
  static String BASE = "625a99360ab4013f94a33913.mockapi.io";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /* Http Apis */

  static String API_GET = "/api/contacts";
  static String API_CREATE = "/api/contacts";
  static String API_UPDATE = "/api/contacts/"; //{id}
  static String API_DELETE = "/api/contacts/"; //{id}

  /* Http Requests */

  static Future<List<Post>?> GET_parsed_list() async {
    var uri = Uri.https(
      BASE,
      API_GET,
    );
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return List<Post>.from(
          jsonDecode(response.body).map((e) => Post.fromJson(e)));
    }
    return null;
  }

  static Future<String> POST(Post p) async {
    var params = paramsCreate(p);
    var uri = Uri.https(BASE, API_CREATE); // http or https
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Create \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  static Future<String> PUT(Post p) async {
    var uri = Uri.https(BASE, API_UPDATE + p.id.toString()); // http or https
    var response =
        await put(uri, headers: headers, body: jsonEncode(paramsUpdate(p)));
    print("status code = ${response.statusCode}");
    print("id = ${p.id}");
    if (response.statusCode == 200) {
      print('Updated \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  static Future<String> DEL(Post p) async {
    var uri = Uri.https(
        BASE, API_DELETE + p.id.toString(), paramsEmpty()); // http or https
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      print('Deleted \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) => {
        'fullname': post.fullname,
        'phone': post.phone,
        'id': post.id.toString(),
      };

  static Map<String, String> paramsUpdate(Post post) => {
        'fullname': post.fullname,
        'phone': post.phone,
        'id': post.id.toString(),
      };
}
