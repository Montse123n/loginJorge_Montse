class Appointment {
  final String id;
  final String title;
  final DateTime dateTime;
  final String doctorName;
  final String address;

  Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.doctorName,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'doctorName': doctorName,
      'address': address,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
      doctorName: map['doctorName'],
      address: map['address'],
    );
  }
}