# meal-delights

### Project Overview

MealDelights is a Swift-based iOS app that allows users to browse and view detailed information about various meals, particularly focusing on desserts. The app is designed in such a way that leverages Swift Concurrency (async/await), modular view models, and a flexible network client architecture. The UI is built using SwiftUI, with custom view modifiers to enhance the design.

### Key Features

-   **Network Requests**: The app fetches meal data from an external API.
-   **Meal Categories**: Displays a list of meal categories.
-   **Desserts**: Users can browse a list of desserts and view details about each.
-   **Custom View Modifiers**: Uses  `CustomTitleModifier`  and  `CustomCardModifier`  for consistent styling across the app.
-   **Image Caching**: The app uses URL-based image loading, with caching enabled to ensure efficient loading of dessert images, reducing network requests and improving performance.
-   **Nil or Empty Filtering**: The app performs filtering to ensure that meal and category entries with empty or nil values for critical fields like name and id are excluded, ensuring only valid data is displayed to the user. This helps maintain data integrity and avoids displaying incomplete information in the UI.
-   **Unit Tests**: Comprehensive test coverage for view models, network interactions, and data parsing.
-   **Preview Support**: SwiftUI views have preview configurations to visualize UI changes during development.

### App demo

![MealDelights](https://github.com/user-attachments/assets/2cbd2af7-772d-4ca3-8ec0-680e084a86e4)


### App Architecture

1.  **View Models**:
    
    -   **MealCategoriesViewModel**: Manages fetching and displaying meal categories.
    -   **DessertViewModel**: Handles fetching dessert listings and managing their state.
    -   **DessertDetailsViewModel**: Responsible for fetching details of a selected dessert.
    
    Each view model interacts with the  `NetworkClient`  to fetch data, handles error states, and processes results for the UI.
    
2.  **Network Client**:
    
    -   The  `NetworkClient`  is responsible for making asynchronous network requests. It is decoupled from the view models through protocols to allow flexible injection and easy testing.
    -   A  **MockNetworkClient**  is used for unit testing network-related functionality.
3.  **Custom View Modifiers**:
    
    -   `CustomTitleModifier`: Applies a consistent title style to  `Text`  views.
    -   `CustomCardModifier`: Adds padding, background, shadow, and border styles to views, useful for cards displaying content.

### Testing

-   **Unit Tests**:
    -   **DessertViewModelTests**: Ensures proper fetching of meals, handling of network errors, and data sorting.
    -   **DessertDetailsViewModelTests**: Verifies the fetching of dessert details, including invalid data handling.
    -   **MealCategoriesViewModelTests**: Tests fetching meal categories, handling errors, and filtering invalid categories.
-   **Mock Network Client**: A mock implementation of  `NetworkClientProtocol`  simulates network responses, allowing for predictable and isolated tests.


### How to Run the App

1.  Clone the repository and open it in Xcode.
2.  Run the project using the iOS simulator or a physical device.
3.  Tests can be run via the  `Test Navigator`  or using  `⌘ + U`.

### How to Run Tests

1.  Open the project in Xcode.
2.  Select  `Product -> Test`  or use the  `⌘ + U`  shortcut.
3.  All tests, including network-related ones with mock clients, will run, and the results will be displayed.

### Project Structure

-   **Models**: Contains data models such as  `MealCategory`,  `Meal`, and  `DessertDetail`.
-   **View Models**: Holds view models like  `DessertViewModel`,  `MealCategoriesViewModel`, and  `DessertDetailsViewModel`.
-   **Views**: SwiftUI views for displaying meals, categories, and meal details.
-   **Network**: A flexible network client architecture that supports async/await for making API requests, with reusable components for different endpoints and error handling.
-   **Image Caching**: Implements image caching to reduce redundant network requests and improve performance when loading images across the app.
-   **Tests**: Unit tests for view models and network interactions using mock data.

### Preview Configuration

The SwiftUI views come with preview setups, allowing you to see how the UI looks with different meal data. These previews are located within each SwiftUI view file.

### Custom Styling

The project uses  `ViewModifier`  extensions to maintain a consistent and reusable style throughout the app:

-   `customTitleStyle()`: Applies a title style to  `Text`  views.
-   `customCardStyle()`: Provides a card-like appearance to views, including rounded corners, shadows, and a border.
