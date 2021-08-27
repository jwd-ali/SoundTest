import Foundation
protocol TracksMappingType {
  func map(_ track: TrackResponse) -> TrackDetailsType
}
struct TrackMapper: TracksMappingType {
    func map(_ track: TrackResponse) -> TrackDetailsType {
      Track(trackId: track.trackId, trackTitle: track.title, artistName: track.user?.username, genre: track.genre, trackArtwork: track.artworkURL)
    }
}
