class Appointment implements Comparable {
  final int id;
  final int start;
  final int end;
  final int startTimeSlot;
  final int endTimeSlot;

  final List<dynamic> subjects;
  final List<dynamic> teachers;
  final List<dynamic> groups;
  final List<dynamic> locations;

  final String type;
  final String remark;
  final String changeDescription;

  final bool valid;
  final bool cancelled;
  final bool modified;
  final bool moved;

  final dynamic isNew;

  Appointment({
    required this.id,
    required this.start,
    required this.end,
    required this.startTimeSlot,
    required this.endTimeSlot,
    required this.subjects,
    required this.teachers,
    required this.groups,
    required this.locations,
    required this.type,
    required this.remark,
    required this.valid,
    required this.cancelled,
    required this.modified,
    required this.moved,
    required this.isNew,
    required this.changeDescription,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      start: json['start'],
      end: json['end'],
      startTimeSlot: json['startTimeSlot'],
      endTimeSlot: json['endTimeSlot'],
      subjects: json['subjects'],
      teachers: json['teachers'],
      groups: json['groups'],
      locations: json['locations'],
      type: json['type'],
      remark: json['remark'],
      valid: json['valid'],
      cancelled: json['cancelled'],
      modified: json['modified'],
      moved: json['moved'],
      isNew: json['isNew'],
      changeDescription: json['changeDescription'],
    );
  }

  @override
  int compareTo(other) {
    return (start - other.start).round();
  }
}
