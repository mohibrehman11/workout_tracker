# Workout Tracker App

## Overview

The **Workout Tracker App** is a Flutter-based application that allows users to manage their workout routines. Users can add, edit, and delete workouts, tracking individual exercises, weights, and repetitions. The app uses `flutter_riverpod` for state management and `SharedPreferences` for local data persistence. This ensures that your workout data is saved even when the app is closed or restarted.

---

## Features

- **Track Workouts**: Add workouts with specific exercises, weights, and repetitions.
- **Edit Workouts**: Modify existing workouts to adjust your progress.
- **Delete Workouts**: Remove old workouts when they're no longer needed.
- **Persist Workouts**: Workouts are saved locally on the device using `SharedPreferences`.
- **Clean UI**: Simple and intuitive interface for easy use.

---

## Screens

### 1. **Workout List Screen**
- This is the home screen of the app where all saved workouts are displayed.
- You can add a new workout by tapping the "add" button in the top-right corner.
- Each workout is listed by date, and you can tap on an individual workout to edit it or press the delete icon to remove it.

### 2. **Workout Screen**
- This screen allows users to add or edit a workout.
- Users can select an exercise from a dropdown, enter the weight used, and specify the number of repetitions.
- Multiple sets can be added, and the workout can be saved for future reference.

---

## Technology Stack

- **Flutter**: Cross-platform framework for building Android and iOS apps using a single codebase.
- **Dart**: The programming language used for Flutter development.
- **flutter_riverpod**: State management library that provides a reactive and modular approach to managing state in Flutter.
- **SharedPreferences**: Used for persisting data locally in the form of key-value pairs.

---

## Project Structure

lib/
│
├── add_workout/
│   └── ui/
│       └── workout_screen.dart                # UI screen for adding/editing workouts
│
├── workout_listing/
│   └── ui/
│       └── workout_list_screen.dart           # UI screen to list all workouts
│
├── model/
│   ├── workout.dart                           # Workout model definition
│   └── workout_set.dart                       # WorkoutSet model definition (exercise, weight, repetitions)
│
├── notifier/
│   └── workout_notifier.dart                  # Workout state notifier (CRUD operations)
│
├── infrastructure/
│   ├── local/
│   │   └── sharedpreferences_workout_repository.dart   # Repository implementation using SharedPreferences
│   └── workout_repository.dart                # Abstract workout repository definition
│
├── utils/
│   ├── logger.dart                            # Logger utility for tracking method calls and log messages
│   └── json_util.dart                         # JSON utility for encoding/decoding JSON data
│
└── main.dart                                  # App entry point and MyApp widget
