### Intent

In this project I am going to demonstrate how structure a flexible, reusable, scalable project. although there is no silver ball, maybe it's a way to make it better.


### TODO

#### Decouple SwiftInstagram
1. Remove SwiftInstagram 3rd  party
2. Exact pure model definition from SwiftInstagram
3. Exact raw model into Entity
4. Add additional custom functionality to the Model, such as calculation, combine fields etc.

#### Define Base Protocol
1. Define clear protocol for Viewmodel <-> View <-> Controller, especially TableView or CollectionView
2. Define clear protocol for Model <-> Data Provider <-> Api client
3. Define clear protocol for Router, Notification to handle events like login, logout, page transformation etc.
4. Define clear protocol for page click event to handle event flow to support interaction, track etc. 
