## COMP3130 Major Work Deliverable 2 (Implementation and Testing)
Author: Intarawat Thanundornwat

### Library Space Booking Application

This application allows users (students) to log in, create, view, update, and delete their library space bookings. It was developed using the iOS simulator with an iPhone 13 as the target device.

#### Main Sections

1. **Login/Signup**
   - Users can sign up using their email and password to create a new account. Authentication is provided by Firebase.

2. **Home**
   - After logging in, users are welcomed by the Home screen displaying their current bookings. Initially, there may be no bookings shown.

3. **Book**
   - Users can create a new booking by selecting a room from a dropdown menu (Library Floor G-3) and choosing a time. The start time must be earlier than the end time, and bookings must be for the same date.

4. **Map**
   - Users can view and zoom in on a map of the campus, using special controls on the simulator or normal zoom functions on the phone.

5. **MySpace**
   - Users can view their bookings in detail, swipe to see other bookings, and edit bookings by clicking on the pencil icon.

6. **Edit**
   - After clicking the pencil icon in MySpace, users are redirected to the Edit screen where they can change room details, start and end times, and save their changes.

7. **Account**
   - Displays the user’s name, email, and booking number. Users can log out from here, returning to the login page.

#### Differences Between Mockup and Real Application

1. **Addition of Login/Signup Page**
   - Introduced based on feedback that the app should have a login page, as it is intended for students only.

2. **Removal of Home Screen Button**
   - The button next to bookings that redirected to MySpace was removed to simplify the code.

3. **Change to Deletion Method**
   - Replaced the manage button and trash icon with a swipe-to-delete feature for ease of use and intuitive design.

4. **Removal of Navigation Arrows in MySpace**
   - Simplified the interface by using side scrolling instead of left and right arrows.

5. **Relocation of Edit Button**
   - Moved from Manage Booking to MySpace, where users click a pencil icon to edit bookings.

6. **Time Picker Change**
   - Replaced dropdown time selection with a date picker, as recommended.

7. **Implementation of Map Feature**
   - Added a campus map of Macquarie University, which was not present in the original mockup.

8. **Removal of Settings in Account Screen**
   - Due to time constraints and complexity, the settings feature was not implemented.

9. **Theme Selection**
   - Added a function for users to toggle between light (default) and dark themes.

#### Notes for Future Developers

- **Testing Suite Limitations**
  - The test suite is limited due to the use of fixed dimensions, making the application inflexible. To improve, standardize the screen styles for better testability.
  
- **Future Enhancements**
  - Implement functionality to retrieve user data and fetch appropriate booking details for each user.