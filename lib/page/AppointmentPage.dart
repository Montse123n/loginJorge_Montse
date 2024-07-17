import 'package:flutter/material.dart';
import 'package:login/page/appointment_page.dart';
import 'appointment_service.dart';

class AppointmentPage extends StatefulWidget {
  final AppointmentService appointmentService;
  final Appointment? appointment;

  AppointmentPage({required this.appointmentService, this.appointment});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _titleController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.appointment != null) {
      _titleController.text = widget.appointment!.title;
      _doctorNameController.text = widget.appointment!.doctorName;
      _addressController.text = widget.appointment!.address;
      _selectedDateTime = widget.appointment!.dateTime;
    }
  }

  void _selectDateTime(BuildContext context) async {
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      ) ?? TimeOfDay.now();

      setState(() {
        _selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _saveAppointment() {
    final title = _titleController.text;
    final doctorName = _doctorNameController.text;
    final address = _addressController.text;
    if (title.isEmpty || _selectedDateTime == null || doctorName.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, completa todos los campos'),
      ));
      return;
    }

    final newAppointment = Appointment(
      id: widget.appointment?.id ?? DateTime.now().toString(),
      title: title,
      dateTime: _selectedDateTime!,
      doctorName: doctorName,
      address: address,
    );

    if (widget.appointment == null) {
      widget.appointmentService.addAppointment(newAppointment);
    } else {
      widget.appointmentService.editAppointment(widget.appointment!.id, newAppointment);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null ? 'Agregar Cita' : 'Editar Cita', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(color: Colors.grey[900]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _doctorNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Médico',
                labelStyle: TextStyle(color: Colors.grey[900]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Dirección',
                labelStyle: TextStyle(color: Colors.grey[900]),
                focusedBorder: UnderlineInputBorder(
                  
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () => _selectDateTime(context),
              child: Text(_selectedDateTime == null
                  ? 'Seleccionar Fecha y Hora'
                  : 'Fecha y Hora: ${_selectedDateTime!.toString()}'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveAppointment,
              child: Text('Guardar Cita'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
