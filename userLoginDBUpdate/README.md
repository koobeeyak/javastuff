User Login & Database Update
============================

- Web Servlet Check.java will check whether user's credentials exist in an external database. An HTML attribute "session" will be set to allow us to track the user.
- Every page thereafter will initially check whether the session attribute is still existing, thus the user is logged in and authorized to make changes.
- Values in "SEMESTER_SR" database table can be updated and displayed.
- User may log out, resetting the session attribute.
