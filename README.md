# We Cook

IOS application for managing recipes. Future developments include friends and sharing recipes.

## Account Information
Users can create an account, sign in, and edit their profile information.

Create an Account|Edit Profile
--|--
![auth](https://github.com/JRN803/WeCook/assets/159984068/a0b1a0ff-c9d9-4dcc-923a-d930801c62ce)|![profile](https://github.com/JRN803/WeCook/assets/159984068/32592ffa-e4c3-46af-b8c4-10f2212b8fbb)

## Recipe Information
Create new recipes and filter through existing ones.

Create a Recipe|Filter Recipes
--|--
![createRecipe](https://github.com/JRN803/WeCook/assets/159984068/f9876bda-a24b-453d-9ef0-2179887e7a1a)|![filter](https://github.com/JRN803/WeCook/assets/159984068/1b546776-655f-4b1c-b75e-78234888d5eb)

---

## Usage

### Requirements
- XCode 15
- SF Symbols 5.1
- Docker
- MySql

### Running the Server
The server can be run via a Docker container. Simply build the Docker image using `docker build --tag wecook-server .` When in the _Server_ directory. This should create an available Docker image that should be run using the following command: `docker run -p 8080:8080 wecook-server`. Note this image does not use Docker Volumes so data will not persist between containers.

### Running the Client
To run the client, open Client/WeCookClient in XCode. Choose a simulator of your choice or connect a device to run the application on. In the NetworkManager file, change line 15 to match the respective local IP address of the machine running the server. The application should now be running. It is important to note the application will only be available to devices on the local network.

# Server

## Structure

The server is built with Flask and a MySql database, structured as a MVC. The server has models and controllers. The models are respective tables in the database and the controllers handle the logic for the routes. The WeCook directory serves to hold all the essential files and serve the Flask application as a package. run.py simply starts the Flask application initialized in WeCook.

## Routes

- _GET /api_ is the root route and doesn't return anything

- _\[PUT,POST\] /api/user/register_ requires a json object in the body containing the following fields: String email, String password, String fName, String lName. The password is hashed before stored in the database. This route will return 201 on success, 400 is the email is already registered, or 401 if there are missing fields.

```
{
    "email": String,
    "fName": String,
    "lName": String,
    "password": String,
}
```

- _\[PUT,POST\] /api/user/login_ requires a json object in the body containing the following fields: String password, String email, Boolean remember. On success, the route returns 200 and sends over a cookie for the user to use in future actions. If the _remember_ field was set to True, the cookie has a 7 day expiration date, otherwise 1. On each login, the cookies are reissued with a reset expiration date. If _remember_ was set to false, the client should invoke a call to _/api/user/logout_ with the respective user id in the body when the application closes. If there are missing fields, the route returns 401. If the credentials are invalid, the route exits on 403. If a cookie is sent over with a uid that doesn't match the database, the user's valid cookie is invalidated. On successful login, the server returns status code 200 and a json object with fields *cookie* and *id* to be used when making requests to */api/user/home*.

```
{
    "Message": "Login Successful",
    "cookie": cookie,
    "id": user.id,
    "fName": user.first_name,
    "lName": user.last_name
}
```

- _\[PUT,POST\] /api/user/logout_ requires an _id_ in the body. It then invalidates the cookie for that user stored in the database.

### @auth wrapped routes

Routes wrapped with auth require a valid cookie and id in the body. It checks this against the one stored for that user in the database. If the credentials are expired or invalid, the route exits with status code 401. If the cookie or id are not present, the route exits with status code 403.

```
{
    "cookie": String,
    "id": Int
}
```

- _\[PUT,POST\] /api/user/home_ Recipes for the user are sent over as a json object with key "Recipes" and value as an array of objects containing recipes along with status code 200.

```
{
    "Recipes": [Recipes]
}
```

- _\[PUT,POST\] /api/user/home/newrecipe_ Users can create a new recipe by supplying the following fields: _String name_, _Array of Objects ingredients_, _String meals_, _String uri_, _String intructions_. _uri_ and _instructions_ are optional. _ingredients_ should be array of objects with _String name_, _Int whole_, _Int numerator_, _Int denominator_, _String unit_. No fields except name are required but a default will be supplied. Success returns status code 200 and the new recipe's id.
```
example
{
    name: String,
    meals: ["Breakfast","Lunch"].
    uri: _optional string_,
    instructions: _optional string_,
    ingredients: [
        {
            "name": String,
            "whole": _optional int_,
            "numerator": _optional int_,
            "denominator": _optional int_, 
            "unit": _optional string_
        }
    ]
}
```
- _\[PUT,POST\] /api/user/home/deleterecipe?id=id_ requires a valid cookie and id in the body. It checks this against the one stored for that user in the database. If it is valid, users can delete an existing recipe by supplying the id as a query param. Success returns status code 200.
