
[![Build Status](https://travis-ci.org/squarezw/demo.svg)](https://travis-ci.org/squarezw/demo)

### Intent

In this project I am going to demonstrate how structure a flexible, reusable, scalable project. although there is no silver ball, maybe it's a way to make it better.

### TODO

#### well-designed REST client networking
1. Remove SwiftInstagram 3rd party
2. Exact pure model definition from SwiftInstagram
3. Exact raw model into Entity
4. Add additional custom functionality to the Model, such as calculation, combine fields etc.

#### Define Communication Protocol
1. Define clear protocol for Viewmodel <-> View <-> Controller, especially TableView or CollectionView
2. Define clear protocol for Model <-> Data Provider <-> Api client
3. Define clear protocol for Router, Notification to handle events like login, logout, page transformation etc.
4. Define clear protocol for page click event to handle event flow to support interaction, track etc. 

#### Performance
1. Loading diff quality picture to show depends on user's Network env.
2. Image render, compress picture size as much less as possible.
3. Dynamic setting up heigh of cell to fit diff pic size. hence cache height of row is required. 
4. No-block things on main thread while rendering the cell, place heavy calculate to the other thread.

#### CI
- [x] Supports fastlane
- [x] Supports travis
