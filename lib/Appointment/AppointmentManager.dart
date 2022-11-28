import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zermelo/Appointment/Appointment.dart';
import 'package:zermelo/Manager.dart';
import 'package:zermelo/Util.dart';

class AppointmentManager extends ZermeloManager {
  late String school;
  late String accessToken;

  Future<List> get(DateTime startDate, DateTime endDate, {user = "~me"}) async {
    final response = await http.get(ZermeloUtil.createApiURL(
        this.school,
        "appointments?user=$user&start=${(startDate.millisecondsSinceEpoch / 1000).round()}&end=${(endDate.millisecondsSinceEpoch / 1000).round()}",
        this.accessToken));
    if (response.statusCode == 200) {
      return json
          .decode(response.body)['response']['data']
          .map((appointment) => Appointment.fromJson(appointment))
          .toList();
    } else {
      print(
          "Server returned with an error ${response.statusCode} (${response.body})");
      throw Exception('Failed to load appointments');
    }
  }

  getParticipations(int year, num weeknumber, {user = "~me"}) async {
    if (weeknumber <= 52 && weeknumber >= 1) {
      final response = await http.get(ZermeloUtil.createApiURL(
          this.school,
          "appointmentparticipations?student=$user&week=$year${weeknumber.round()}&fields=id,appointmentInstance,studentInDepartment,optional,studentEnrolled,attendanceParticipationCoordinator,plannedAttendance,realizedAttendance,publicComment,start,end,subjects,teachers,locations,groups,schedulerRemark,changeDescription,startTimeSlotName,endTimeSlotName,allowedStudentActions,availableSpace,cancelled,appointmentType,content",
          this.accessToken));
      if (response.statusCode == 200) {
        return json
            .decode(response.body)
            .map(
                (appointment) => Appointment.fromJson(json.decode(appointment)))
            .toList()
            .sort((a, b) => a.start.compareTo(b.start));
      } else {
        throw Exception('Failed to load appointments');
      }
    } else
      throw Exception('Weeknumber must be between 1-52');
  }

  AppointmentManager(String school, String accesstoken)
      : super(school: school, accessToken: accesstoken) {
    this.school = school;
    this.accessToken = accesstoken;
  }
}
