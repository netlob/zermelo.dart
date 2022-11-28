import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zermelo/Manager.dart';
import 'package:zermelo/User/User.dart';
import 'package:zermelo/Util.dart';

class UserManager extends ZermeloManager {
  late String school;
  late String accessToken;

  getAll() async {
    final response = await http
        .get(ZermeloUtil.createApiURL(this.school, "users", this.accessToken));
    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map((user) => User.fromJson(json.decode(user)))
          .toList();
    } else {
      throw Exception('Failed to load user');
    }
  }

  get({id = "~me"}) async {
    final response = await http.get(
        ZermeloUtil.createApiURL(this.school, "users/$id", this.accessToken));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['response']['data'][0]);
    } else {
      print(response.body.toString());
      throw Exception('Failed to load user');
    }
  }

  UserManager(String school, String accesstoken)
      : super(school: school, accessToken: accesstoken) {
    this.school = school;
    this.accessToken = accesstoken;
  }
}
