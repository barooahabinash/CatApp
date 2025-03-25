# CatApp
This is a simple app where a user can see different breeds of cat and also information and images of the breeds . The app utilizes the The Cat API (https://thecatapi.com) to retrieve cat related information.

The app is built using SwiftUI and uses the MVVM design pattern. There are viewmodels for the home screen with the cat breeeds list view and the breed images view. There are separate classes for Network calls and Caching data. For the network call class I have used protocols so that those can be mocked for testing. I have made most of the UI components as separate entities so that they can be reused later if needed.

Features:
* Shows different breeds of cats
* Display images and information of the different breeds.
* Caches the network response.
* Uses pagination to display the list.
* Error handling.Log errors in console
* Animation added in the cat breed images view whilst scrolling.

Additional features that I think can be added:
* Add tests
* The home screen with the cat breed list can be customized further to give it a better look and feel
* Features like share cat breed details to social media
* Add and post cat images to the API

  
  *Note: Currently, there are no tests included in the project,
  Does not cache image data
  Cache is not deleted . Uncomment the code in CatBreedsViewModel to clear cache(line20)*
