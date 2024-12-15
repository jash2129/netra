import React from 'react';
import {
  Grid,
  Paper,
  Typography,
  Box,
  Card,
  CardContent,
} from '@mui/material';

const Dashboard = () => {
  // Mock data - replace with actual API calls
  const attendanceStats = {
    present: 85,
    absent: 15,
    totalClasses: 100,
  };

  const upcomingClasses = [
    { id: 1, subject: 'Mathematics', time: '10:00 AM', room: '101' },
    { id: 2, subject: 'Physics', time: '11:30 AM', room: '203' },
    { id: 3, subject: 'Chemistry', time: '2:00 PM', room: '305' },
  ];

  return (
    <Box sx={{ flexGrow: 1, mt: 3 }}>
      <Grid container spacing={3}>
        {/* Attendance Overview */}
        <Grid item xs={12} md={4}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Attendance Overview
            </Typography>
            <Typography variant="body1">
              Present: {attendanceStats.present}%
            </Typography>
            <Typography variant="body1">
              Absent: {attendanceStats.absent}%
            </Typography>
            <Typography variant="body1">
              Total Classes: {attendanceStats.totalClasses}
            </Typography>
          </Paper>
        </Grid>

        {/* Today's Schedule */}
        <Grid item xs={12} md={8}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Today's Schedule
            </Typography>
            <Grid container spacing={2}>
              {upcomingClasses.map((class_) => (
                <Grid item xs={12} key={class_.id}>
                  <Card>
                    <CardContent>
                      <Typography variant="h6">{class_.subject}</Typography>
                      <Typography color="textSecondary">
                        Time: {class_.time}
                      </Typography>
                      <Typography color="textSecondary">
                        Room: {class_.room}
                      </Typography>
                    </CardContent>
                  </Card>
                </Grid>
              ))}
            </Grid>
          </Paper>
        </Grid>
      </Grid>
    </Box>
  );
};

export default Dashboard;
