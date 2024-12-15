const mongoose = require('mongoose');

const semesterArchiveSchema = new mongoose.Schema({
  semester: {
    type: Number,
    required: true
  },
  year: {
    type: Number,
    required: true
  },
  startDate: {
    type: Date,
    required: true
  },
  endDate: {
    type: Date,
    required: true
  },
  attendanceRecords: [{
    studentId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User'
    },
    subject: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Subject'
    },
    totalClasses: Number,
    presentCount: Number,
    absentCount: Number,
    attendancePercentage: Number
  }],
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Compound index for efficient querying
semesterArchiveSchema.index({ semester: 1, year: 1 }, { unique: true });

module.exports = mongoose.model('SemesterArchive', semesterArchiveSchema);
