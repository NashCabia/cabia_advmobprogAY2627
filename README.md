# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia  
**Course:** INF231 / CTADMOBJ

## Project Overview

This Flutter project follows a feature-aligned clean architecture pattern.
The application is organized into `models/`, `providers/`, `screens/`,
`services/`, and `widgets/` so data, state, screens, and reusable UI remain
separated. Provider is used for application-wide state management.

## Progressive Lab Discussions and Reflections

### Lab Activity 1: Flutter State Management

In Lab Activity 1, I learned the difference between ephemeral state and
application-wide state. I used `setState` for a local counter, where the state
belongs only to the widget that owns it. I also used `ChangeNotifier` and
Provider for the theme setting so different parts of the application could
respond when the light or dark mode changed.

This activity helped me understand that state management depends on how widely
the data needs to be used. It became the foundation for the settings and API
features that I added later.

### Lab Activity 2: Product API Integration

For Lab Activity 2, I started organizing the project using a clean
architecture structure with `models`, `providers`, `screens`, `services`, and
`widgets`. Separating these responsibilities made the code easier for me to
understand because the data, state, API logic, and interface were no longer
kept in one place.

I connected the product catalog to DummyJSON using the `http` package. I
learned how to receive product data from the API, map it into models, and show
it through reusable screens and widgets. I added a search filter so I could
find products while typing, and I added detail view navigation so selecting a
product opened its image, description, and price.

I also added a settings page for switching between light and dark themes. Lab
Activity 2 showed me how the state-management ideas from the first activity
could support a real API-based application.
