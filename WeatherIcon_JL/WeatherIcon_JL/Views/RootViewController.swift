//
//  RootViewController.swift
//  WeatherIcon_JL
//
//  Created by jianli on 5/12/23.
//

import UIKit
import SwiftUI

// MARK: this is root view controller
// this view split two parts
// (1)   up part based on UIKit and will show search bar
// (2)   bottom part based on SwiftUI
// (2.1) show time bar
// (2.2) show weather information
// (2.3) show location or map information

class RootViewController: UIViewController {
    
    // MARK: Properties defined
    
    private lazy var locationBtn = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        btn.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        return btn
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private var swiftUIView: UIHostingController<MainInfoView>?
    
    private var viewModel: WeatherViewModel?
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        assembleMVVM()
        setupUI()
    }
    
    private func assembleMVVM() {
        // let networkManager = MockNetworkManager()
        // let locationService = MockLocationService()
        let networkManager = NetworkManager()
        let locationService = LocationService()
        viewModel = WeatherViewModel(networkManager: networkManager,
                                         locationService: locationService)
        if let vm = viewModel {
            swiftUIView = UIHostingController(rootView: MainInfoView(vm: vm))
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        // (1) search bar
        // searchBar.backgroundColor = .red
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationBtn)
        locationBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            //searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:-20)
            locationBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            locationBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            locationBtn.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 20)
            ])
        // (2) swiftUIView
        if let swiftUIView = swiftUIView{
            // swiftUIView.view.backgroundColor = .blue
            view.addSubview(swiftUIView.view)
            self.addChild(swiftUIView)
            swiftUIView.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                swiftUIView.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
                swiftUIView.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                swiftUIView.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                swiftUIView.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
            ])
        }
    }
    
    @objc func locationAction() {
        self.viewModel?.weatherInfo.cityName = nil
        updateData()
    }
    
    private func updateData() {
        Task { @MainActor () -> Void in
            await self.viewModel?.loadData()
        }
    }
}

extension RootViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.viewModel?.weatherInfo.cityName = searchText
            updateData()
        }
    }
}
