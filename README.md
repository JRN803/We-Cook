*Updated 2025-02-06*
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

