import 'package:login/page/appointment_page.dart';

class AppointmentService {
  final List<Appointment> _appointments = [];

  List<Appointment> getAllAppointments() {
    return _appointments;
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
  }

  void editAppointment(String id, Appointment newAppointment) {
    final index = _appointments.indexWhere((appointment) => appointment.id == id);
    if (index != -1) {
      _appointments[index] = newAppointment;
    }
  }

  void deleteAppointment(String id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
  }
}
