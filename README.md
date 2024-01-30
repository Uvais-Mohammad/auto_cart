# auto_cart

### _Seamlessly plan your shopping list with AutoCart_

![Build Status](https://img.shields.io/badge/Flutter-white.svg?logo=Flutter&logoColor=blue) ![Build Status](https://img.shields.io/badge/Riverpod-white.svg?logoColor=blue)

### Features

- Infinite scrolling of products
- Filter products by category, sub-category, brand
- Search products by name
- View product details
- Add products to cart
- Remove products from cart
- View cart

### Project Structure

The codebase adheres to a feature-level architecture, promoting a clean and modular organization that systematically separates concerns for UI components, data storage. The project encompasses the following

- lib/
  - features/
    - home/
      - models/
      - screens/
      - repository/
      - logic/
    - splash/
      - screens/
      - logic/
  - shared/
    - components/
    - constants/
    - themes/
    - utils/
  - main.dart

### How to Run the app

1. Clone the repository

```sh
git clone https://github.com/Uvais-Mohammad/auto_cart.git
```

2. Install dependencies

```sh
flutter pub get
```

3. Run the app

```sh
flutter run
```
