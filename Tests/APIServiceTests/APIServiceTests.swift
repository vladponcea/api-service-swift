import XCTest
@testable import APIService

final class APIServiceTests: XCTestCase {
    func testAPICall() throws {
        let constants = APIConstants(baseURL: "https://rickandmortyapi.com/api", apiKey: "")
        let request = APIRequest(constants: constants, endpoint: "character", pathComponents: [], queryParameters: [])
        
//        APIService.shared.execute(request, expecting: String.self) { result in
//            switch result {
//            case .success(let success):
//                XCTAssertNotNil(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
}
