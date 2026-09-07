# Advanced Mobile Programming

**Student:** Nash Daniel S. Cabia
**Course:** INF231 / CTADMOBJ

## Project Overview

This repository contains the Flutter application I developed for Advanced
Mobile Programming. I organized the project using a feature-aligned clean
architecture pattern so the responsibilities stay separated and easier to
maintain:

- `models/` contains typed JSON data objects such as products and carts.
- `providers/` contains reactive app-wide state, including `ThemeModel` and
   the interactive cart model.
- `screens/` contains the catalog, product detail, cart, and settings views.
- `services/` contains the DummyJSON API clients.
- `widgets/` contains reusable presentation components.

I use Provider for reactive application state management. The product and cart
data are connected to DummyJSON, while the presentation layer contains the
search, product details, theme settings, and cart workflows completed so far.

## Progressive Lab Discussions and Reflections

### Lab Activity 1: Flutter State Management

In Lab Activity 1, I learned the difference between ephemeral state and
application-wide state. I used `setState` for a local counter, where the state
belongs only to the widget that owns it. I also used `ChangeNotifier` and
Provider for the theme setting so different parts of the application could
respond when the light or dark mode changed.

This activity helped me understand that state management depends on how widely
the data needs to be used. It became the foundation for the settings, API, and
cart features that I added later.

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

The catalog currently uses consumer products such as Wireless Headphones,
Classic Backpack, Smart Watch, and Running Shoes.
