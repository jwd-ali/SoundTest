import Foundation

// MARK: - TracksResponse
struct TracksResponse: Decodable {
    let artworkURL: URL
    let createdAt: String?
    let tracksResponseDescription: String?
    let downloadable: Bool?
    let duration: Int?
    let ean: String?
    let embeddableBy, genre: String?
    let id: Int?
    let kind: String?
    let label, labelID, labelName: String?
    let lastModified, license: String?
    let likesCount: Int?
    let permalink: String?
    let permalinkURL: String?
    let playlistType: String?
    let purchaseTitle, purchaseURL, release, releaseDay: String?
    let releaseMonth, releaseYear: String?
    let sharing: String?
    let streamable: Bool?
    let tagList, tags, title: String?
    let trackCount: Int?
    let tracks: [TrackResponse]
    let tracksURI: String?
    let type: String?
    let uri: String?
    let user: UserResponse?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case artworkURL = "artwork_url"
        case createdAt = "created_at"
        case tracksResponseDescription = "description"
        case downloadable, duration, ean
        case embeddableBy = "embeddable_by"
        case genre, id, kind, label
        case labelID = "label_id"
        case labelName = "label_name"
        case lastModified = "last_modified"
        case license
        case likesCount = "likes_count"
        case permalink
        case permalinkURL = "permalink_url"
        case playlistType = "playlist_type"
        case purchaseTitle = "purchase_title"
        case purchaseURL = "purchase_url"
        case release
        case releaseDay = "release_day"
        case releaseMonth = "release_month"
        case releaseYear = "release_year"
        case sharing, streamable
        case tagList = "tag_list"
        case tags, title
        case trackCount = "track_count"
        case tracks
        case tracksURI = "tracks_uri"
        case type, uri, user
        case userID = "user_id"
    }
}

// MARK: - Tracks
struct TrackResponse: Decodable {
    let artworkURL: String?
    let availableCountryCodes, bpm: String?
    let commentCount: Int?
    let commentable: Bool?
    let createdAt: String?
    let tracksDescription: String?
    let downloadCount: Int?
    let downloadURL: String?
    let downloadable: Bool?
    let duration: Int?
    let embeddableBy: String?
    let favoritingsCount: Int?
    let genre: String?
    let trackId: Int
    let isrc, keySignature: String?
    let kind, labelName, license: String?
    let permalinkURL: String?
    let playbackCount: Int?
    let purchaseTitle, purchaseURL, release: String?
    let releaseDay, releaseMonth, releaseYear, repostsCount: Int?
    let secretURI: String?
    let sharing: String?
    let streamURL: String?
    let streamable: Bool?
    let tagList: String?
    let title: String
    let uri: String?
    let user: UserResponse?
    let userFavorite: Bool?
    let userPlaybackCount: Int?
    let waveformURL: String?
    let access, ref: String?

    enum CodingKeys: String, CodingKey {
        case artworkURL = "artwork_url"
        case availableCountryCodes = "available_country_codes"
        case bpm
        case commentCount = "comment_count"
        case commentable
        case createdAt = "created_at"
        case tracksDescription = "description"
        case downloadCount = "download_count"
        case downloadURL = "download_url"
        case downloadable, duration
        case embeddableBy = "embeddable_by"
        case favoritingsCount = "favoritings_count"
        case genre
        case trackId = "id"
        case isrc
        case keySignature = "key_signature"
        case kind
        case labelName = "label_name"
        case license
        case permalinkURL = "permalink_url"
        case playbackCount = "playback_count"
        case purchaseTitle = "purchase_title"
        case purchaseURL = "purchase_url"
        case release
        case releaseDay = "release_day"
        case releaseMonth = "release_month"
        case releaseYear = "release_year"
        case repostsCount = "reposts_count"
        case secretURI = "secret_uri"
        case sharing
        case streamURL = "stream_url"
        case streamable
        case tagList = "tag_list"
        case title, uri, user
        case userFavorite = "user_favorite"
        case userPlaybackCount = "user_playback_count"
        case waveformURL = "waveform_url"
        case access
        case ref = "$$ref"
    }
}

// MARK: - User
struct UserResponse: Decodable {
    let avatarURL: String?
    let id: Int?
    let kind, lastModified, permalink: String?
    let permalinkURL, uri: String?
    let username, ref: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case id, kind
        case lastModified = "last_modified"
        case permalink
        case permalinkURL = "permalink_url"
        case uri, username
        case ref = "$$ref"
    }
}
