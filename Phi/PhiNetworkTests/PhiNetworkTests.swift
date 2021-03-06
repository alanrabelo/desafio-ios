//
//  PhiNetworkTests.swift
//  PhiNetworkTests
//
//  Created by Lo on 04/03/21.
//

import XCTest
@testable import PhiNetwork

class PhiNetworkTests: XCTestCase {
    
    let networkLayer = NetworkLayer()
    let id = "0B5BFD44-0DF1-4005-A7CF-66C9C0438380"
    let absoluteURL = "https://desafio-mobile-bff.herokuapp.com"
    lazy var cases = [PhiRoutes.balance, PhiRoutes.statement(10, 0), PhiRoutes.details(id)]
    
//    func testRoutes() throws {
//        
//        for route in cases {
//            let expectation = self.expectation(description: "Waiting for \(route)")
//            
//            networkLayer.perform(route: route) { (result: Result<Decodable, Error>) in
//                switch result {
//                case .success(let string):
//                    print(string)
//                    expectation.fulfill()
//                case .failure(let error):
//                    XCTFail(error.localizedDescription)
//                }
//            }
//            
//            self.waitForExpectations(timeout: 20)
//        }
//    }
//    
    func testRequestComposition() throws {
        for route in cases {
            XCTAssertTrue(route.method == "GET")
            XCTAssert(route.header.contains(where: {
                $0.0 == "token"
            }))
        }
    }
    
    func testBalanceURL() throws {
        guard let url = PhiRoutes.balance.request?.url else {
            XCTFail("Route doesn't have a URL")
            return
        }
        let absoluteString = url.absoluteString
        let components = url.pathComponents
        
        XCTAssert(absoluteString == self.absoluteURL+"/myBalance", "\(absoluteString)")
        XCTAssertTrue(components.contains("myBalance"))
        XCTAssertTrue(components.count == 2)

    }
    
    func testStatementURL() throws {
        guard let url = PhiRoutes.statement(10, 0).request?.url else {
            XCTFail("Route doesn't have a URL")
            return
        }
        let absoluteString = url.absoluteString
        let components = url.pathComponents
        
        XCTAssert(absoluteString == self.absoluteURL+"/myStatement/10/0", "\(absoluteString)")
        XCTAssertTrue(components.contains("myStatement"))
        XCTAssertTrue(components.count == 4)
    }
        
    func testDetailsURL() throws {
        guard let url = PhiRoutes.details(id).request?.url else {
            XCTFail("Route doesn't have a URL")
            return
        }
        let absoluteString = url.absoluteString
        let components = url.pathComponents
                
        XCTAssert(absoluteString == self.absoluteURL+"/myStatement/detail/\(id)", "\(absoluteString)")
        XCTAssertTrue(components.contains("myStatement") && components.contains("detail"))
        XCTAssertTrue(components.count == 4)
    }
}
