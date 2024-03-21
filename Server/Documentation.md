 # WeCook API Documentation

This is the documentation for the WeCook API. The API is designed to provide a way to interact with the WeCook application's data.

**Base URL:** `https://example.com/api`

**Endpoints:**

### Index

- **GET /**
  - Description: Returns a message indicating that the API is working.
  - Response: `{"Message": "In Home Route"}`

### User

- **PUT /user/register**
  - Description: Registers a new user.
  - Body:
    - `email`: The user's email.
    - `password`: The user's password.
    - `fName`: The user's first name.
    - `lName`: The user's last name.
  - Response: `{"Message": "Account Created"}`

- **PUT /user/login**
  - Description: Logs in a user.
  - Body:
    - `email`: The user's email.
    - `password`: The user's password.
    - `remember`: A boolean indicating whether the user should be remembered.
  - Response: `{"Message": "Login Successful", "cookie": cookie, "id": user.id, "fName": user.first_name, "lName": user.last_name, "email": user.email, "pfp": user.pfp, "bio": user.bio}`

- **PUT /user/logout**
  - Description: Logs out a user.
  - Body:
    - `id`: The user's ID.
  - Response: `{"Message": "Logged Out"}`

- **PUT /user/home**
  - Description: Returns a user's home data.
  - Body:
    - `cookie`: The user's cookie.
  - Response: `{"Recipes": recipes}`

- **PUT /user/home/newrecipe**
  - Description: Creates a new recipe.
  - Body:
    - `name`: The recipe's name.
    - `ingredients`: An array of objects with the name, whole, numerator, denominator, and unit of the ingredient.
    - `meals`: An array of meal names.
    - `uri`: The recipe's URI.
    - `instructions`: The recipe's instructions.
    - `time`: The recipe's cooking time.
  - Response: `{"id": recipe.id}`

- **PUT /user/home/deleterecipe**
  - Description: Deletes a recipe.
  - Body:
    - `id`: The recipe's ID.
  - Response: `{"Message": "Recipe Deleted"}`

- **PUT /user/edit**
  - Description: Edits a user's information.
  - Body:
    - `fName`: The user's first name.
    - `lName`: The user's last name.
    - `email`: The user's email.
    - `bio`: The user's bio.
  - Response: `{"Message": "User could not be updated"}`

### Images

- **GET /images/pfp**
  - Description: Returns a user's profile picture.
  - Query Parameters:
    - `id`: The user's ID.
  - Response: The user's profile picture.

- **PUT /images/pfp**
  - Description: Sets a user's profile picture.
  - Body:
    - `imageData`: The base64 data of the image.
  - Response: `{"Message": "Success"}`

- **GET /images/recipe**
  - Description: Returns a recipe's image.
  - Query Parameters:
    - `name`: The recipe's name.
  - Response: The recipe's image.

- **PUT /images/recipe**
  - Description: Sets a recipe's image.
  - Body:
    - `recipeId`: The recipe's ID.
    - `imageData`: The base64 data of the image.
  - Response: `{"Message": "Success"}`

