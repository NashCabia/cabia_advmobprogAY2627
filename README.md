# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia
**Course:** INF231 / CTADMOBJ

## Project Overview

This repository contains a Flutter application developed for Advanced Mobile
Programming. The project follows a feature-aligned clean architecture pattern
that keeps responsibilities separated and easy to extend:

- `models/` contains typed data objects such as products and carts.
- `providers/` contains app-wide state, including `ThemeModel`.
- `screens/` contains the application views and user workflows.
- `services/` contains API and data-access logic for DummyJSON.
- `widgets/` contains reusable presentation components.

Provider is used for reactive application state management. Product and cart
data are integrated with the DummyJSON API, while the presentation layer
provides search, product details, theme settings, and cart workflows.

## Chronological Lab Activities

### Lab Activity 1: Flutter State Management

The first activity introduced the difference between ephemeral state and
application-wide state:

- **Ephemeral state:** a local counter is updated with Flutter's `setState`.
  This state belongs only to the widget that owns it.
- **App-wide state:** `ChangeNotifier` and Provider expose `ThemeModel` to the
  application. The provider stores the light/dark mode selection and notifies
  listening widgets when the selection changes.

This established the state-management foundation used by the later settings
and theme features.

### Lab Activity 2: Product API Integration

The second activity connected the product catalog to DummyJSON using the
`http` package. The application maps API data into product models and presents
it through reusable screens and widgets. The activity enhancements were:

1. **Enhancement 1:** a dynamic search bar is displayed above the product list
   and filters products as the user types.
2. **Enhancement 2:** selecting a product card opens a detail page containing
   the product information and price.
3. **Enhancement 3:** a settings page provides light and dark theme toggling.
   The activity uses `flutter_dotenv` for environment configuration and `http`
   for network requests.

### Lab Activity 3: Cart Management and Aquatic Theme

The third activity expanded the catalog into a cart workflow and applied a
custom visual identity inspired by Betta fish and Neocaridina shrimps. The
light theme uses clean water-clear tones, while the dark theme uses deep
abyss/slate tones. Royal blue represents Betta fish, and cherry-red and orange
accents represent Neocaridina shrimp.

The cart and navigation enhancements were:

1. **Enhancement 1:** `cart_screen.dart` renders cart data from the DummyJSON
   cart endpoints, including product thumbnails, quantities, prices, totals,
   and a Confirm Order action.
2. **Enhancement 2:** navigation connects the catalog, cart, and theme
   settings through the bottom navigation bar and its floating-style action
   behavior.
3. **Enhancement 3:** carts can be filtered for a specific user through
   `/carts/user/{id}`, and each cart item is clickable and routes to the
   corresponding product detail screen.

The catalog content is aligned with the theme through fish-focused products
such as Royal Blue Betta, Neon Tetra School, Fancy Guppy Pair, and Cherry
Shrimp Colony.
