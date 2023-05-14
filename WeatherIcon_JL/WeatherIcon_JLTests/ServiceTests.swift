//
//  WeatherIcon_JLTests.swift
//  WeatherIcon_JLTests
//
//  Created by jianli on 5/12/23.
//

import XCTest
@testable import WeatherIcon_JL
import UIKit


final class ServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_networkManager_FetchByName() async throws {
        let networkManager = MockNetworkManager()
        let defaultInfo1 = try await networkManager.fetchWeatherInfoByName()
        XCTAssert(defaultInfo1?.name == "Landon")
        let defaultInfo2 = try await networkManager.fetchWeatherInfoByName(cityName: "tokyo")
        XCTAssert(defaultInfo2?.name == "Landon")
    }
    
    func test_networkManager_FetchByPosition() async throws {
        let networkManager = MockNetworkManager()
        let defaultInfo = try await networkManager.fetchWeatherInfoByPosition(lat: 10, lon: 10.3)
        XCTAssert(defaultInfo?.name == "Landon")
    }
    func test_networkManager_FetchIcon() throws {
        // given
        let res = UIImage(systemName: "sun.min")
        // when
        let networkManager = MockNetworkManager()
        // then
        try networkManager.fetchIcon(name: "sun.min") { data in
            XCTAssert(data == res?.pngData())
        }

    }
    
    func test_locationService() throws {
        let locationService = MockLocationService()
        let defaultInfo = locationService.getPosition()
        // (44.3, 10.99)
        XCTAssert(defaultInfo?.lat == 44.3)
        XCTAssert(defaultInfo?.lon == 10.99)
    }

}
