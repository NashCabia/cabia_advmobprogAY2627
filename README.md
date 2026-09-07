# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia
**Course:** INF231 / CTADMOBJ

## Project Overview

This repository contains the Flutter application I developed for Advanced
Mobile Programming. I organized the project using a feature-aligned clean
architecture pattern so the responsibilities stay separated and easier to
maintain:

- `models/` contains typed JSON data objects such as products, carts, and users.
- `providers/` contains reactive app-wide state, including `ThemeModel` and
   the interactive cart model.
- `screens/` contains the catalog, product detail, cart, authentication,
   profile, splash, and settings views.
- `services/` contains DummyJSON API clients and local user-session storage.
- `widgets/` contains reusable presentation components.

I use Provider for reactive application state management. The product, cart,
and authentication data are connected to DummyJSON, while
`shared_preferences` stores the authenticated user locally. The presentation
layer contains the search, product details, theme settings, authentication,
profile, and cart workflows.

## Progressive Lab Discussions and Reflections

### Lab Activity 1: Flutter State Management

In Lab Activity 1, I learned the difference between ephemeral state and
application-wide state. I used `setState` for a local counter, where the state
belongs only to the widget that owns it. I also used `ChangeNotifier` and
Provider for the theme setting so different parts of the application could
respond when the light or dark mode changed.

This activity helped me understand that state management depends on how widely
the data needs to be used. It became the foundation for the settings,
authentication, and cart features that I added later.

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

### Lab Activity 3: Cart Management

In Lab Activity 3, I extended the product catalog into a complete cart
workflow. The main challenge for me was working with the nested JSON returned
by the cart API. A cart contains cart information and a list of products, so I
had to parse the product objects inside the cart instead of treating the
response as a simple flat list. This gave me more practice creating models that
match the actual structure of API data.

I added cart items with product thumbnails, quantities, prices, and totals. I
also made it possible to update quantities and keep track of products added by
the user. The bottom navigation connects the shop, cart, theme, and profile
areas, so the user can move between the main parts of the application without
losing the current cart state.

Another important part of this activity was keeping navigation smooth between
the cart list and the product detail screen. Each cart item can be selected to
open the matching product details, and the user can return to the cart without
confusing the selected product or the cart contents. This activity helped me
understand how API data, Provider state, and navigation need to work together
in one user workflow.

### Lab Activity 4: Authentication and User Profiles

For Lab Activity 4, I built on the catalog and cart features by adding
authentication and user-specific information. I created `UserService` to send
the login request and handle the response from the authentication API. The
service also manages saving and retrieving the logged-in user's details, which
helped me keep authentication logic outside of the sign-in screen.

I used `SharedPreferences` to save the user's tokens and profile details
locally. Because of this, the application can remember the session when it is
opened again instead of requiring the user to log in every time. I also set up
a persistent `SplashScreen` check that runs when the application starts. It
checks whether user data is already saved and then sends the user either to the
home screen or to the sign-in screen.

The stored user ID is also used to load the correct cart dynamically from the
user-specific cart endpoint. This means the cart is connected to the account
that is currently signed in rather than using one fixed user. The profile view
uses the same saved user information to show details such as the user's name,
email, username, gender, and profile image. Adding these features made the
application feel more complete because the data is now connected to an actual
user session.

Looking back at the four activities, I can see the project progressing in
stages. Lab Activity 2 taught me how to organize the code and use product API
data. Lab Activity 3 used that foundation to create a connected cart workflow.
Lab Activity 4 then added authentication and personalized data. Each activity
made the previous features more useful and gave me a better understanding of
how a Flutter application is built step by step.

The catalog uses consumer products such as Wireless Headphones, Classic
Backpack, Smart Watch, and Running Shoes.
