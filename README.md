# ios-upcoming-movies
An iOS application for cinephiles and movie hobbyists.

### Run the project

To run the project on your local machine clone the repo and change the bundle ID to an unique identifier.

### Project Structure

-- The folder architecture was structured as follows:

    ├─ Models
    ├─ Views
    ├─ Controllers 
    ├─ API
    ├─ Helpers
    ├─ Assets

### External libraries

No external libraries were used to keep the application as simple and with the least dependencies as possible.

Instead of using the popular Alamofire framework, the HTTP calls the app makes were based on [this tutorial][tutorial]. 

[tutorial]: https://medium.com/ios-os-x-development/minimal-networking-layer-from-scratch-in-swift-4-a151af786dc5

### Screenshots

![Home Screen](https://raw.githubusercontent.com/mdemattos/ios-upcoming-movies/development/screenshots/iPhoneX-home.png)

![Movie Detail](https://raw.githubusercontent.com/mdemattos/ios-upcoming-movies/development/screenshots/iPhoneX-movie.png)