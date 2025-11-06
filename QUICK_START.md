# Quick Start Guide

## Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App-wide constants
│   ├── theme/              # Design system (colors, typography, spacing)
│   └── utils/              # Utility functions
├── data/                   # Data layer
│   ├── models/            # Data models
│   ├── repositories/       # Data access layer
│   └── mock_data/         # Mock data for MVP
├── domain/                 # Business logic
│   └── services/          # Business logic services
├── presentation/          # UI layer
│   ├── screens/           # Full screen widgets
│   ├── widgets/           # Reusable UI components
│   └── providers/         # State management
└── main.dart              # App entry point
```

## Running the App

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Key Features

- **Daily View**: View and log meals for today or any past date
- **Weekly Progress**: See adherence statistics and daily breakdown
- **Report Generation**: Generate and share progress reports

## Design Principles

- **Simplicity**: Clean, focused UI
- **Speed**: One-tap meal logging
- **Clarity**: Easy to understand progress indicators
- **Professional**: Shareable reports for nutritionists

## State Management

Uses Provider for state management with three main providers:
- `MealPlanProvider`: Manages meal plan data
- `MealLogProvider`: Handles meal logging
- `ProgressProvider`: Calculates progress and adherence

## Mock Data

The app uses mock data for MVP:
- Client: Sarah Johnson
- Meal Plan: Week 1 with 5 meals per day for 7 days
- All data is stored in memory (not persisted)

