//
//  PlayListDetailsViewModel.swift
//  iOSRefactoringChallenge
//
//  Created by Jawad Ali on 24/08/2021.
//  Copyright © 2021 SoundCloud. All rights reserved.
//
import Combine
import Foundation
protocol PlayListDetailsViewModelType {
  var genre: AnyPublisher<String, Never> { get }
  var trackName: AnyPublisher<String, Never> { get }
  var imageURL: AnyPublisher<URL, Never> { get }
  var artistName: AnyPublisher<String, Never> { get }

}

class PlayListDetailsViewModel: PlayListDetailsViewModelType {

  var genre: AnyPublisher<String, Never> { genreSubject.eraseToAnyPublisher() }
  var trackName: AnyPublisher<String, Never> { trackNameSubject.eraseToAnyPublisher() }
  var imageURL: AnyPublisher<URL, Never> { imageURLSubject.eraseToAnyPublisher() }
  var artistName: AnyPublisher<String, Never> { artistNameSubject.eraseToAnyPublisher() }


  private let genreSubject: CurrentValueSubject<String, Never>
  private let trackNameSubject: CurrentValueSubject<String, Never>
  private let imageURLSubject: CurrentValueSubject<URL, Never>
  private let artistNameSubject: CurrentValueSubject<String, Never>



  init(trackDetail: TrackDetailsType) {
    genreSubject = CurrentValueSubject<String, Never>(trackDetail.genre)
    trackNameSubject = CurrentValueSubject<String, Never>(trackDetail.trackTitle)
    imageURLSubject = CurrentValueSubject<URL, Never>(trackDetail.trackArtwork)
    artistNameSubject = CurrentValueSubject<String, Never>(trackDetail.artistName)

  }
}
