# Attendance Management System

A comprehensive attendance management system with mobile SDK, web application, and WhatsApp integration.

## Project Structure
```
/
├── mobile-sdk/          # Flutter-based mobile SDK
├── web-app/            # React-based student web application
├── server/            # Node.js backend server
│   ├── models/       # MongoDB schemas
│   ├── routes/       # API endpoints
│   ├── services/     # Business logic
│   └── config/       # Configuration files
└── scripts/          # Deployment and utility scripts
```

## Setup Instructions

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
Create a `.env` file in the root directory with:
```
MONGODB_URI=your_mongodb_uri
JWT_SECRET=your_jwt_secret
WHATSAPP_API_KEY=your_whatsapp_api_key
```

3. Start the server:
```bash
npm start
```

## Mobile SDK Integration

Follow the instructions in `mobile-sdk/
Creating a new React app in d:\test\web.

Installing packages. This might take a couple of minutes.
Installing react, react-dom, and react-scripts with cra-template-typescript...

README.md` for integrating the SDK into Android/iOS applications.

## Web Application

The web application is available at `http://localhost:3000` after starting the server.
