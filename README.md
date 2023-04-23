# Rick And Morty App

## Project Overview

| **SplashView(First)** | **SplashView(After First)** | **Character List** |
|:---:|:---:|:---:|
| ![SplashView(First)](https://media.giphy.com/media/issxSxna14MRHAywKZ/giphy.gif) | ![SplashView(After First)](https://media.giphy.com/media/5IVOYBJ1SQcNbviNlp/giphy.gif) | ![Character List](https://i.ibb.co/vP3gYNM/IMG-7879-2.png) |
| **Locations 1** | **Locations 2** | **Character Detail** |
| ![Locations 1](https://i.ibb.co/TBPYHVw/IMG-7881-2.png) | ![Locations 2](https://i.ibb.co/3f4ybVR/IMG-7882-2.png) | ![Character Detail](https://i.ibb.co/16W4Cfm/IMG-7880-2.png) |

## Project Design

I used SwiftUI and MVVM design pattern in this project.

### Models
- Character
- Location

### Views
- CharacterListView
- LocationListView
- CharacterDetailView
- CharacterRowView
- SplashView
- MainView
- RootView

### ViewModels
- CharacterListViewModel
- LocationListViewModel
- CharacterDetailViewModel

### Network
- NetworkManager


## Project Features

### Main Screen 

- User can see list of location at horizontal list.
- User can see list of characters any location at vertical list.
- User can click on any character in the list and can see Character Detail Screen.

### Character Detail Screen

- User can see detail of selected character.
