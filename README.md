# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia  
**Course:** INF231 / CTADMOBJ

## Project Overview

This Flutter project introduces a feature-aligned clean architecture pattern.
The application is organized into `models/`, `providers/`, `screens/`,
`services/`, and `widgets/` so data, state, screens, and reusable UI remain
separated. Provider is used for application-wide state management.

## Lab Activity 1: Flutter State Management

Lab Activity 1 demonstrates two kinds of state:

- **Ephemeral state:** a local counter is updated with Flutter's `setState`.
	The state belongs only to the widget that owns the counter.
- **App-wide state:** `ChangeNotifier` and Provider expose `ThemeModel` to the
	application. `ThemeModel` stores the light/dark mode selection and notifies
	listening widgets whenever the selection changes.

This activity establishes the state-management foundation used by the later
catalog, settings, and theme features.
