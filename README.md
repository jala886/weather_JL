<img src="./DemoSnapshot/appIcon.jpeg" width="100">
This is  an app to fetch and show data from OpenWeather


[Demo](./DemoSnapshot/SimulatorScreenRecording.gif)


## 🚀 Features
```
UIKit mixed with SwiftUI
MVVM pattern
TDD development
```
### 🖼 Overlays
```
Based on MVVM pattern
    * Views
        RootViewController
            Used UIKit, UISearchBar, UIButton
            // this view split two parts
            // (1)   up part based on UIKit and will show search bar
            // (2)   bottom part based on SwiftUI
            // (2.1) show time bar
            // (2.2) show weather information
           // (2.3) show location or map information
        MainInfoView
            Used SwiftUI             
    * ViewModel
        load data and combine with views
	In loadData function, It will followed this sequence to fetch data
	(1) searched city Name.If it is not nil, it will saved into userDefault.
	(2) userDefault value
	(3) user's location
	(4) default cityName (Landon)
    * Model
        defined data structure
    * Service
        Network:
            URLs
                save the real URLs and return available URLs
            NetworkManager
                send data by async/wait and closure method
        LocationService:
            Support Location Manager
        MockService
            supply mock data for test and developing
    * Global
        Global
            defined some global properties, like appId
        Utils
            defined global function, like data convert, string operation. Logger. 

TDD: 
    WeatherIcon_JLTests
    WeatherIcon_JLUITests
```
### 🛠 Appearance / Behavior Customization
![Demo Snapshot](./DemoSnapshot/startScreen.png)
![Demo Snapshot](./DemoSnapshot/searchScreen.png)

### 👀 Adapt visibility of:


### 🪄 Custom controls


## 💻 Supported Platforms

| 📱 | iOS 13+ |
| :-: | :-: |
| 🖥 | **macOS 10.15+** | 
| 📺 | **tvOS 13+** |
| ⌚️ | **watchOS 6+** |



### 📌 Annotations: The old-fashioned approach



## 🔩 Installation


## ✍️ Author

Jian Li

## 📄 License