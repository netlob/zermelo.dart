import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zermelo/Announcement/AnnouncementManager.dart';
import 'package:zermelo/Appointment/AppointmentManager.dart';
import 'package:zermelo/School/SchoolManager.dart';
import 'package:zermelo/User/UserManager.dart';

import 'Util.dart';

export 'package:zermelo/Announcement/AnnouncementManager.dart';
export 'package:zermelo/Announcement/Announcement.dart';
export 'package:zermelo/Appointment/AppointmentManager.dart';
export 'package:zermelo/Appointment/Appointment.dart';
export 'package:zermelo/School/SchoolManager.dart';
export 'package:zermelo/School/School.dart';
export 'package:zermelo/User/UserManager.dart';
export 'package:zermelo/User/User.dart';

class Zermelo {
  late String school;
  late String accessToken;
  late SchoolManager schools;
  late UserManager users;
  late AnnouncementsManager announcements;
  late AppointmentManager appointments;

  static getAPI(String school, String accessToken) {
    return Zermelo(school, accessToken);
  }

  static getAccessToken(String school, String authCode) async {
    final authURL = "${ZermeloUtil.getApiURL(school)}/oauth/token";
    authCode = authCode.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    final response = await http.post(
        Uri.parse("$authURL?grant_type=authorization_code&code=$authCode"));
    if (response.statusCode == 200) {
      return json.decode(response.body)['access_token'];
    } else {
      throw Exception(
          "Server returned with an error ${response.statusCode} (${response.body})");
    }
  }

  Zermelo(String school, String accessToken) {
    this.school = school;
    this.accessToken = accessToken;

    this.schools = SchoolManager(school, accessToken);
    this.users = UserManager(school, accessToken);
    this.announcements = AnnouncementsManager(school, accessToken);
    this.appointments = AppointmentManager(school, accessToken);
  }
}
