import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/attendance.dart';
import '../services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  final AttendanceService attendanceService;
  final String subject;

  const AttendanceScreen({
    Key? key,
    required this.attendanceService,
    required this.subject,
  }) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late DateTime _selectedDate;
  List<Attendance> _attendanceList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    setState(() => _isLoading = true);
    try {
      final attendance = await widget.attendanceService.getAttendanceByDate(
        _selectedDate,
        widget.subject,
      );
      setState(() => _attendanceList = attendance);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading attendance: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _markAttendance(String studentId, String status) async {
    try {
      final attendance = Attendance(
        studentId: studentId,
        teacherId: 'current_teacher_id', // Replace with actual teacher ID
        subject: widget.subject,
        date: _selectedDate,
        status: status,
        semester: 1, // Replace with actual semester
      );
      await widget.attendanceService.markAttendance(attendance);
      await _loadAttendance();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error marking attendance: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance - ${widget.subject}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
                await _loadAttendance();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _attendanceList.length,
              itemBuilder: (context, index) {
                final attendance = _attendanceList[index];
                return ListTile(
                  title: Text('Student ID: ${attendance.studentId}'),
                  subtitle: Text('Status: ${attendance.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle_outline),
                        onPressed: () => _markAttendance(attendance.studentId, 'present'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () => _markAttendance(attendance.studentId, 'absent'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
