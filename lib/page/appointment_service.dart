import 'package:login/page/appointment_page.dart';

class AppointmentService {
  List<Appointment> appointments = [];

  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }

  void editAppointment(String id, Appointment updatedAppointment) {
    final index = appointments.indexWhere((app) => app.id == id);
    if (index != -1) {
      appointments[index] = updatedAppointment;
    }
  }

  void deleteAppointment(String id) {
    appointments.removeWhere((app) => app.id == id);
  }

  List<Appointment> getAllAppointments() {
    return appointments;
  }
}
