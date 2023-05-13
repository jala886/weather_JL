//
//  MainInfoView.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import SwiftUI

struct MainInfoView: View {
    @ObservedObject var vm: WeatherViewModel
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter
    }()
    
    @ViewBuilder func timeView() -> some View {
        VStack {
            Text(Date(), formatter: dateFormatter)
                .foregroundColor(.red)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
            Text(vm.weatherInfo.cityName ?? "")
                .font(.largeTitle)
        }
    }
    
    @ViewBuilder func temperatureView() -> some View {
        VStack {
            HStack {
                vm.weatherInfo.icon ?? Image(systemName: Global.DEFAULTICON)
                if let temp = vm.weatherInfo.temp {
                    Text(double2string(
                        kelvin2celsius(temp))
                         + "˚C")
                    .font(.largeTitle)
                }
            }
            HStack {
                if let feelsLike = vm.weatherInfo.feelsLike,
                   let main = vm.weatherInfo.main {
                    Text("Feels like" +
                        double2string(
                        kelvin2celsius(feelsLike)) +
                        "˚C. " +
                        main + ". " )
                }
            }
        }
    }
    
    @ViewBuilder func infoView() -> some View {
        HStack {
            Divider().background(.red)
                .frame(maxHeight: 60)
            Spacer().frame(maxWidth: 20)
            VStack(alignment: .leading) {
                // (1)
                if let speed = vm.weatherInfo.windSpeed,
                   let pressure = vm.weatherInfo.pressure{
                    HStack {
                        Image(systemName: "wind" )
                        Text(double2string(speed)+"m/s   ")
                        Text(double2string(pressure)+"hPa")
                    }
                }
                // (2)
                if let humidity = vm.weatherInfo.humidity {
                    Text("Humidity: " + double2string(humidity)+"%   ")
                }
                // (3)
                if let visibility = vm.weatherInfo.visibility {
                    Text("Visibility: " + double2string(visibility/1000)+"km  ")
                }
            }
        }
    }
    
    var body: some View {
        Group {
            if vm.weatherInfo.cityName == nil &&
                vm.weatherInfo.temp == nil {
                ProgressView().scaleEffect(2.0, anchor: .center)
            } else {
                VStack {
                    timeView()
                    Spacer().frame(maxHeight: 20)
                    temperatureView()
                    infoView()
                    Spacer()
                }
            }
        }.onAppear {
            Task {@MainActor () -> Void in
                await vm.loadData()
            }
        }
//        .task { @MainActor in
//            await vm.loadData()
//        }
    }
}

struct MainInfoView_Previews: PreviewProvider {
    static var vm: WeatherViewModel = {
        return WeatherViewModel(networkManager: MockNetworkManager(), locationService: MockLocationService())
    }()
    
    static var previews: some View {
        MainInfoView(vm: vm)
    }
}
