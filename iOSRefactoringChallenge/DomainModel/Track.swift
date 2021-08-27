import Foundation

protocol TrackType {
    var trackId: Int { get }
    var trackTitle: String { get }
}

protocol TrackDetailsType: TrackType {
  var artistName: String { get }
  var genre: String { get }
  var trackArtwork: URL { get }
}

struct Track: TrackDetailsType {
  let trackId: Int
  let trackTitle: String
  let artistName: String
  let genre: String
  let trackArtwork: URL
}


