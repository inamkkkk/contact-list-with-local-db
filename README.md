# Flutter Contact List App

A simple contact list application built with Flutter, using Hive for local database storage and Provider for state management.

## Features

*   Add new contacts (name, phone number, email).
*   View a list of contacts.
*   Delete contacts.

## Architecture

*   `lib/main.dart`: Entry point of the application.
*   `lib/screens`: Contains the UI screens (contact list, add contact).
*   `lib/models`: Defines the `Contact` data model.
*   `lib/services`: Implements the data service using Hive.

## State Management

*   Provider is used for state management to handle contacts data and notify the UI.

## Local Database

*   Hive is used as the local database for storing contact information.

## Getting Started

1.  Clone the repository.
2.  Run `flutter pub get` to install dependencies.
3.  Run `flutter run` to start the application.