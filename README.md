# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia  
**Course:** INF231 / CTADMOBJ

## Project Overview

This Flutter project follows a feature-aligned clean architecture pattern.
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

## Lab Activity 2: Product API Integration

Lab Activity 2 integrates the product catalog with the DummyJSON API using the
`http` package. API data is mapped into product models and displayed through
reusable screens and widgets.

The activity enhancements are:

1. **Enhancement 1:** a dynamic search bar filters the product list as the
	user types.
2. **Enhancement 2:** selecting a product card opens a detail page with the
	product information and price.
3. **Enhancement 3:** a settings page provides light and dark theme toggling.
	The activity uses `flutter_dotenv` for environment configuration and `http`
	for network requests.
