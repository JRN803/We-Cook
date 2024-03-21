 # WeCook API Documentation

This is the documentation for the WeCook API. The API is designed to provide a way to interact with the WeCook application's data.

**Base URL:** `https://localhost:8080/api`

**Endpoints:**

### Index

- **GET /**
  - Description: Returns a message indicating that the API is working.
  - Response: `{"Message": "In Home Route"}, 200`

### User

- **PUT/POST _/user/register_**
  - Description: Registers a new user.
  - Body:
    - `email`: The user's email.
    - `password`: The user's password.
    - `fName`: The user's first name.
    - `lName`: The user's last name.
  - Response: `{"Message": "Account Created"}, 201`
  - Failed Responses:
    - `{"Message": "Missing Fields"}, 401` Indicates a required field in the body was not given.
    - `{"Message": "Email is taken"}, 400` Indicates the email is already registered in the database.

- **PUT/POST _/user/login_**
  - Description: Logs in a user and returns tokens for future requests.
  - Body:
    - `email`: The user's email.
    - `password`: The user's password.
    - `remember`: A boolean indicating whether the user should be remembered.
  - _If a cookie and id are supplied, the cookie will be matched against the one in the database as an alternative means of authentication._
  - Response: 
  ```
  {
    "Message": "Login Successful", 
    "cookie": cookie, 
    "id": user.id, 
    "fName": user.first_name, 
    "lName": user.last_name, 
    "email": user.email, 
    "pfp": user.pfp, 
    "bio": user.bio
  }, 200
  ```
  - Failed Responses:
    - `{"Message": "Missing Fields"}, 401` Indicates required fields are missing.
    - `{"Message": "Invalid Login"}, 403` Indicates invalid credentials.
  - _Note: The cookie and id will be used in future requests to the server as a means for authentication and the client should store these._
  - _If the _remember_ field was set to True, the cookie has a 7 day expiration date, otherwise 1. On each request to the home recipes route, the cookies are reissued with a reset expiration date if the user is to be remembered._

- **PUT/POST _/user/logout_**
  - Description: Logs out a user.
  - Body:
    - `id`: The user's ID.
  - Response: `{"Message": "Logged Out"}, 200`
  - Failure: `{"Message": "No User Found"}, 401`
  - Invalidates any existing tokens for the associated user.

- ***@auth Routes*** require a user cookie and id in the body as well. Future changes should include these in the header instead. If authentication fails, the server can return one of the following:

  - `{"Message": "No Token or ID provided"}, 403`
  - `{"Message": "Invalid Credentials"}, 401`

- **PUT/POST _/user/home_** @auth
  - Description: Returns a user's recipes.
  - Body:
    - `cookie`: The user's cookie.
  - Response: `{"Recipes": recipes}, 200`
  - Recipe Structure: 
    ```
    {
      "name": String,
      "ingredients": [String],
      "instructions": [String],
      "uri": String,
      "id": String,
      "meals": [String],
      "time": String,
      "likes": Integer,
      "image": String
    }
    ```
    
- **PUT/POST _/user/home/newrecipe_** @auth
  - Description: Creates a new recipe.
  - Body:
    - `name`: The recipe's name.
    - `ingredients`: An array of ingredients
    - `meals`: An array of meal categories.
    - `uri`: The recipe's URI.
    - `instructions`: The recipe's instructions.
    - `time`: The recipe's cooking time.
  - Response: `{"id": recipe.id}, 201`
  - _uri, instructions, and time_ are optional fields and default values will be generated.
  - Failed Responses:
    - `{"Message": "Missing Fields"}, 400`
    - `{"Message": "An Error Occured"}, 500` Indicates an internal error.

- **PUT/POST _/user/home/deleterecipe_** @auth
  - Description: Deletes a recipe.
  - Url params:
    - `id`: The recipe's ID.
  - Response: `{"Message": "Recipe Deleted"}, 200`
  - Failure: `{"Message": "No Recipe Found"}, 404`

- **PUT /user/edit**
  - Description: Edits a user's information.
  - Body:
    - `fName`: The user's first name.
    - `lName`: The user's last name.
    - `email`: The user's email.
    - `bio`: The user's bio.
  - Response: 
  ```
  {
    "Message": "Login Successful",
    "cookie": body["cookie"],
    "id": user.id,
    "fName": user.first_name,
    "lName": user.last_name,
    "email": user.email,
    "pfp": user.pfp,
    "bio": user.bio
    }, 200
  ```
  - _Note: The updated user information is sent back over to aid in client-side updates but this will be changed in future versions._
### Images

- **GET /images/pfp**
  - Description: Returns a user's profile picture.
  - Query Parameters:
    - `id`: The user's ID.
  - Response: The user's profile picture. Status code 200.
  - Failure: A default image is sent with status code 404.

- **PUT/POST _/images/pfp_** @auth
  - Description: Sets a user's profile picture.
  - Body:
    - `imageData`: The base64 data of the image.
  - Response: `{"Message": "Success"}, 201`
  - Failure: `{"Message": "Failed"}, 400`

- **GET /images/recipe**
  - Description: Returns a recipe's image.
  - Query Parameters:
    - `name`: The recipe's image name.
  - Response: The recipe's image, 200
  - Failure: A default image is sent with status code 404.

- **PUT/POST _/images/recipe_** @auth
  - Description: Sets a recipe's image.
  - Body:
    - `recipeId`: The recipe's ID.
    - `imageData`: The base64 data of the image.
  - Response: `{"Message": "Success"}, 201`
  - Failure: `{"Message": "Failed"}, 400`

