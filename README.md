![Demo Snapshot](./weather_JL
/DemoSnapshot/startScreen.png)
This is  open weather app for a inteview


## 馃殌 Features
```
UIKit mixed with SwiftUI
MVVM pattern
TDD development
```
### 馃柤 Overlays
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
    * Model
        defined data structur
    * Service
        Network:
            URLs
                save the real URLs and return available URLs
            NetworkManager
                send data by async/wait and clouser method
        LocationService:
            Support Location Manager
        MockService
            supply mock data for test and developing
    * Global
        Global
            defined some global preperties, like appId
        Utils
            defined global functiun, like data convert, string operation. Logger. 

TDD: 
    WeatherIcon_JLTests
    WeatherIcon_JLUITests
```
### 馃洜 Appearance / Behavior Customization
![Demo Snapshot](./weather_JL
/DemoSnapshot/searchScreen.png)

### 馃憖 Adapt visibility of:


### 馃獎 Custom controls


## 馃捇 Supported Platforms

| 馃摫 | iOS 13+ |
| :-: | :-: |
| 馃枼 | **macOS 10.15+** | 
| 馃摵 | **tvOS 13+** |
| 鈱氾笍 | **watchOS 6+** |



### 馃搶 Annotations: The old-fashioned approach



## 馃敥 Installation


## 鉁嶏笍 Author

Jian Li

## 馃搫 License


