import XCTest
@testable import iOSRefactoringChallenge
class TrackMapperTests: XCTestCase {
    private var sut: TrackMapper!
    override func setUpWithError() throws {
        sut = TrackMapper()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testMapping() {
        let trackResponse = TracksResponse.parse(jsonFile: "fakeTracks")?.tracks[0]
        let track = sut.map(trackResponse!)
        
        XCTAssertEqual(trackResponse?.title, track.trackTitle)
        
    }
}

extension Decodable {
  static func parse(jsonFile: String) -> Self? {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }

    return output
  }
}
