# Client

# Server

## Structure

The server is built with Flask and a MySql database, structured as a MVC. The server has models and controllers. The models are respective tables in the database and the controllers handle the logic for the routes. The WeCook directory serves to hold all the essential files and serve the Flask application as a package. run.py simply starts the Flask application initialized in WeCook.

## Routes

- _GET /api_ is the root route and doesn't return anything

- _\[PUT,POST\] /api/user/register_ requires a json object in the body containing the following fields: String email, String password, String fName, String lName. The password is hashed before stored in the database. This route will return 201 on success, 400 is the email is already registered, or 401 if there are missing fields.

- _\[PUT,POST\] /api/user/login_ requires a json object in the body containing the following fields: String password, String email, Boolean remember. On success, the route returns 200 and sends over a cookie for the user to use in future actions. If the _remember_ field was set to True, the cookie has a 7 day expiration date, otherwise 1. On each login, the cookies are reissued with a reset expiration date. If _remember_ was set to false, the client should make a call to _/api/user/logout_ with the respective user id in the body when the application closes. If there are missing fields, the route returns 401. If the credentials are invalid, the route exits on 403. If a cookie is sent over with a uid that doesn't match the database, the user's valid cookie is invalidated.

- _\[PUT,POST\] /api/user/logout_ requires an _id_ in the body. It then invalidates the cookie for that user stored in the database.

- _\[PUT,POST\] /api/user/home_ requires a valid cookie and id in the body. It checks this against the one stored for that user in the database. If it is valid, access is granted and recipes for the user are sent over as a json object with key "Recipes" and value as an array of objects containing recipes.

- _\[PUT,POST\] /api/user/home/newrecipe_ requires a valid cookie and id in the body. It checks this against the one stored for that user in the database. If it is valid, users can create a new recipe by supplying the following fields: _String name_, _Array of Objects ingredients_, _String meals_, _String uri_, _String intructions_. _uri_ and _instructions_ are optional. _ingredients_ should be array of objects with _String name_, _Int whole_, _Int numerator_, _Int denominator_, _String unit_. No fields are required but a default will be supplied.

- _\[PUT,POST\] /api/user/home/deleterecipe?id=id_ requires a valid cookie and id in the body. It checks this against the one stored for that user in the database. If it is valid, users can delete an existing recipe by supplying the id as a query param.
