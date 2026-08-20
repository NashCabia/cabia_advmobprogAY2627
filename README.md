# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia
**Course:** INF231 / CTADMOBJ

## Project Overview

This repository contains a Flutter application developed for Advanced Mobile
Programming. The project follows a feature-aligned clean architecture pattern
that keeps responsibilities separated, testable, and easy to extend:

- `models/` contains typed JSON data objects such as products, carts, and users.
- `providers/` contains reactive app-wide state, including `ThemeModel` and
   the interactive cart model.
- `screens/` contains the catalog, product detail, cart, authentication,
   profile, splash, and settings views.
- `services/` contains DummyJSON API clients and local user-session storage.
- `widgets/` contains reusable presentation components.

Provider is used for reactive application state management. Product, cart, and
authentication data are integrated with DummyJSON, while
`shared_preferences` stores the authenticated user locally. The presentation
layer provides search, product details, theme settings, authentication,
profile, and cart workflows.

## Chronological Lab Activities

### Lab Activity 1: Flutter State Management

The first activity introduced the difference between ephemeral state and
application-wide state:

- **Ephemeral state:** a local counter is updated with Flutter's `setState`.
  This state belongs only to the widget that owns it.
- **App-wide state:** `ChangeNotifier` and Provider expose `ThemeModel` to the
  application. The provider stores the light/dark mode selection and notifies
  listening widgets when the selection changes.

This established the state-management foundation used by the later settings,
authentication, and cart features.

### Lab Activity 2: Product API Integration

The second activity connected the product catalog to DummyJSON using the
`http` package. API responses are mapped into product models and presented
through reusable screens and widgets. The activity enhancements were:

1. **Enhancement 1:** a dynamic search bar is displayed above the product list
   and filters products as the user types without requiring a new API request.
2. **Enhancement 2:** selecting a product card opens a detail page containing
   the product image, description, and price.
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
   and a Confirm Order action. The interactive cart also records products
   actually added by the user and supports live quantity changes.
2. **Enhancement 2:** navigation connects the catalog, cart, and theme
   settings through the bottom navigation bar, including Aquarium, Cart,
   Theme, and Profile destinations.
3. **Enhancement 3:** carts can be filtered for a specific user through
   `/carts/user/{id}`, and each cart item is clickable and routes to the
   corresponding product detail screen. Cart quantities are maintained by
   Provider after the initial API data is loaded.

The catalog content is aligned with the theme through fish-focused products
such as Royal Blue Betta, Neon Tetra School, Fancy Guppy Pair, and Cherry
Shrimp Colony.

### Lab Activity 4: Authentication and User Profiles

Lab Activity 4 (API Part III) adds authentication, persistent sessions,
profile management, and user-specific data using DummyJSON and
`shared_preferences`:

- **User model:** `models/user.dart` provides null-safe `fromJson` and `toJson`
   support for `id`, `username`, `email`, `firstName`, `lastName`, `gender`,
   `image`, `accessToken`, and `refreshToken`.
- **Authentication service:** `services/user_service.dart` sends credentials
   to `POST /auth/login`, handles API errors, and saves the authenticated user.
   It also provides `saveUserData`, `getUserData`, `getUser`, `isLoggedIn`, and
   `logout` methods.
- **Persistent storage:** the serialized user is stored in
   `SharedPreferences`, allowing the session to survive application restarts.
- **Splash screen:** `splash_screen.dart` provides a custom aquatic startup
   screen, waits 1.5 seconds, checks `isLoggedIn`, and routes to `/home` or
   `/signin`.
- **Sign-in screen:** `signin_screen.dart` provides validated username and
   password inputs, a loading state, API authentication, and readable login
   errors.
- **Profile screen:** `profile_screen.dart` renders the saved user's avatar,
   full name, email, user ID, username, and gender. Its Log Out action clears
   the persisted session and returns to sign-in.
- **User-specific cart binding:** `cart_screen.dart` reads the saved user's
   ID and requests `/carts/user/{id}` for the initial cart contents. Provider
   then preserves the user's real additions, quantity changes, removals, and
   current total during the active session.
