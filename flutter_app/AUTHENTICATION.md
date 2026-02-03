# Authentication System

## Overview

The app now includes a complete authentication system with support for:

- User Sign Up
- User Sign In
- Guest Account (no sign-in required)
- User Profile Management

## New Files Created

### Providers

- **`lib/providers/auth_provider.dart`** - Manages authentication state, user sessions, and guest mode

### Screens

- **`lib/screens/welcome_screen.dart`** - Landing page with Sign Up, Sign In, and Continue as Guest options
- **`lib/screens/signup_screen.dart`** - User registration form
- **`lib/screens/signin_screen.dart`** - User login form
- **`lib/screens/profile_view.dart`** - User profile and settings page

## Features

### Welcome Screen

- Beautiful welcome page with app branding
- Three options for users:
  - **Sign Up** - Create a new account
  - **Sign In** - Login with existing credentials
  - **Continue as Guest** - Use the app without authentication

### Sign Up Screen

- Name, email, and password input fields
- Form validation (minimum 8 characters for password)
- Social login placeholders (Google, Apple, Facebook)
- Link to switch to Sign In screen

### Sign In Screen

- Email and password input fields
- Form validation
- Forgot password option (placeholder)
- Social login placeholders
- Link to switch to Sign Up screen

### Profile View

Accessible from the sidebar navigation, includes:

- User avatar and display name
- Account status (Guest or Premium User)
- Settings:
  - Dark mode toggle
  - Notifications toggle
  - Download quality settings
  - Help & support
  - About dialog
- Account management (for logged-in users):
  - Edit profile
  - Change password
- Sign out button with confirmation dialog

### Updated Components

- **`lib/main.dart`** - Added AuthProvider and routing logic to show Welcome screen when not authenticated
- **`lib/widgets/sidebar.dart`** - Added user info section at bottom with sign-out button and Profile navigation item

## How It Works

1. **App Launch**: When the app starts, it checks if the user is authenticated (`isAuthenticated` in AuthProvider)
2. **Not Authenticated**: Shows the Welcome screen with three options
3. **Guest Mode**: User can continue without signing in, all features available
4. **Authenticated**: Shows the main app with full access
5. **Sign Out**: Returns user to Welcome screen

## User Experience

### New User Flow

1. Launch app → See welcome screen
2. Tap "Sign Up" → Fill in registration form
3. Submit → Automatically logged in and taken to main app

### Returning User Flow

1. Launch app → See welcome screen
2. Tap "Sign in" → Enter credentials
3. Submit → Taken to main app

### Guest User Flow

1. Launch app → See welcome screen
2. Tap "Continue as Guest" → Immediately taken to main app
3. Full access with Guest badge in profile

### Profile Access

- Click "Profile" in sidebar navigation
- View account info, change settings
- Sign out when needed

## State Management

The `AuthProvider` manages:

- `isLoggedIn` - User signed in with credentials
- `isGuest` - User using guest mode
- `isAuthenticated` - Either logged in or guest (determines app access)
- `userName` - Display name
- `userEmail` - User email (null for guests)

## Future Enhancements

- Connect to real authentication API
- Implement actual social login (Google, Apple, Facebook)
- Add password reset functionality
- Add email verification
- Store authentication tokens securely
- Persist login state across app restarts
- Add profile photo upload
- Implement premium subscription features
