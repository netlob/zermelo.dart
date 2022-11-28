import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zermelo/Announcement/Announcement.dart';
import 'package:zermelo/Manager.dart';
import 'package:zermelo/Util.dart';

class AnnouncementsManager extends ZermeloManager {
  late String school;
  late String accessToken;

  get({user = "~me"}) async {
    final response = await http.get(ZermeloUtil.createApiURL(this.school,
        "announcements?user=$user&current=true", this.accessToken));
    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map((school) => Announcement.fromJson(json.decode(school)))
          .toList()
          .sort((a, b) => a.start.compareTo(b.start));
    } else {
      throw Exception('Failed to load announcement');
    }
  }

  AnnouncementsManager(String school, String accesstoken)
      : super(school: school, accessToken: accesstoken) {
    this.school = school;
    this.accessToken = accesstoken;
  }
}
