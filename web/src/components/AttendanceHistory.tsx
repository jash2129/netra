import React from 'react';
import {
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Typography,
} from '@mui/material';

const AttendanceHistory = () => {
  // Mock data - replace with actual API calls
  const attendanceRecords = [
    {
      id: 1,
      date: '2024-12-15',
      subject: 'Mathematics',
      status: 'Present',
      teacher: 'Dr. Smith',
    },
    {
      id: 2,
      date: '2024-12-14',
      subject: 'Physics',
      status: 'Present',
      teacher: 'Prof. Johnson',
    },
    {
      id: 3,
      date: '2024-12-13',
      subject: 'Chemistry',
      status: 'Absent',
      teacher: 'Dr. Williams',
    },
  ];

  return (
    <Paper sx={{ width: '100%', overflow: 'hidden', mt: 3 }}>
      <Typography variant="h6" sx={{ p: 2 }}>
        Attendance History
      </Typography>
      <TableContainer sx={{ maxHeight: 440 }}>
        <Table stickyHeader>
          <TableHead>
            <TableRow>
              <TableCell>Date</TableCell>
              <TableCell>Subject</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Teacher</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {attendanceRecords.map((record) => (
              <TableRow key={record.id}>
                <TableCell>{record.date}</TableCell>
                <TableCell>{record.subject}</TableCell>
                <TableCell>
                  <Typography
                    color={record.status === 'Present' ? 'success.main' : 'error.main'}
                  >
                    {record.status}
                  </Typography>
                </TableCell>
                <TableCell>{record.teacher}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </Paper>
  );
};

export default AttendanceHistory;
