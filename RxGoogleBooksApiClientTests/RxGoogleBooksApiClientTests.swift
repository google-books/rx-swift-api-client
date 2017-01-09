import XCTest
import RxSwift
import GoogleBooksApiClient
@testable import RxGoogleBooksApiClient

class RxGoogleBooksApiClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        _ = URLSession.shared
            .rx.response(request: GoogleBooksApi.VolumeRequest.Get(id: Id("EFXMMgEACAAJ")))
            .subscribe(
                onNext: ({ n in NSLog("\(n)") })
            )
        sleep(1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
