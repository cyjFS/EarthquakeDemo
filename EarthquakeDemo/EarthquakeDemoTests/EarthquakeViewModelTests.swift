//
//  EarthquakeViewModelTests.swift
//  EarthquakeDemo
//
//  Created by ychen327 on 2024/11/11.
//

import XCTest
import Combine
@testable import EarthquakeDemo

class EarthquakeViewModelTests: XCTestCase {
    var viewModel: EarthquakeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        try await super.setUp()
        
        // 异步初始化 @MainActor 隔离的 viewModel
        viewModel = await EarthquakeViewModel()
        cancellables = []
    }

    override func tearDown() async throws {
        viewModel = nil
        cancellables = nil
        try await super.tearDown()
    }

    func testFetchEarthquakesSuccess() async {
        // 测试数据
        let jsonData = """
        {
            "features": [
                {
                    "id": "test1",
                    "properties": {
                        "place": "Test Location 1",
                        "mag": 7.1,
                        "time": 1622520000000
                    },
                    "geometry": {
                        "coordinates": [-115.33, 33.2, 10.0]
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        // 测试解码
        do {
            let decodedData = try JSONDecoder().decode(EarthquakeResponse.self, from: jsonData)
            XCTAssertEqual(decodedData.features.count, 1)
            XCTAssertEqual(decodedData.features.first?.properties.place, "Test Location 1")
            XCTAssertEqual(decodedData.features.first?.properties.mag, 7.1)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
