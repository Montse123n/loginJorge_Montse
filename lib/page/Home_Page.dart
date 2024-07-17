import 'package:flutter/material.dart';
import 'package:login/page/AppointmentPage.dart';
import 'appointment_service.dart';
import 'appointment_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppointmentService _appointmentService = AppointmentService();

  void _navigateToAppointmentPage({Appointment? appointment}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentPage(
          appointmentService: _appointmentService,
          appointment: appointment,
        ),
      ),
    ).then((_) => setState(() {})); // Actualiza la lista al regresar
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Médicas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => _navigateToAppointmentPage(),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: ListView.builder(
          itemCount: _appointmentService.getAllAppointments().length,
          itemBuilder: (context, index) {
            final appointment = _appointmentService.getAllAppointments()[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  appointment.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.dateTime.toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    Text(
                      'Médico: ${appointment.doctorName}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    Text(
                      'Dirección: ${appointment.address}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _appointmentService.deleteAppointment(appointment.id);
                    setState(() {});
                  },
                ),
                onTap: () => _navigateToAppointmentPage(appointment: appointment),
              ),
            );
          },
        ),
      ),
    );
  }
}
