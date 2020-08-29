//
//  MovieDetailView.swift
//  watchlist
//
//  Created by Reed Metzler-Gilbertz on 8/26/20.
//  Copyright © 2020 Reed Metzler-Gilbertz. All rights reserved.
//

import SwiftUI
import URLImage

//class MovieDetailViewModel: ObservableObject {
//  let omdb: OMDB
//  @Published var movieDetail: MovieDetailed?
//  
//  init(omdb: OMDB) {
//    self.omdb = omdb
//  }
//  
//  func getMovieDetail(movie: Movie?) {
//    guard let movie = movie else { return }
//    omdb.movieDetails(movie: movie) { response in
//      guard let details = response else { return }
//      DispatchQueue.main.async {
//        self.movieDetail = details
//      }
//    }
//  }
//}

struct MovieDetailView: View {
//  @Environment(\.imageCache) var cache: ImageCache
  //@EnvironmentObject var app: AppController
  //@ObservedObject var viewModel: MovieDetailViewModel
  var movie: MovieDetailed?
  
  var body: some View {
    Group {
      if (movie == nil) {
        Text("Movie Details")
          .font(.system(size: 25, weight: .bold, design: .default))
          .foregroundColor(.gray)
      } else {
        self.detail
      }
    }.navigationBarTitle(Text("Details"))
  }
  
  var detail: some View {
    VStack(alignment: .leading) {
      Text(movie!.title)
        .font(.system(size: 27, weight: .bold, design: .default))
        .fixedSize(horizontal: false, vertical: true)
      HStack(alignment: .center) {
        MovieImage(imageUrl: movie!.posterUrl, width: 200, radius: 0)
        VStack(alignment: .leading, spacing: 4) {
          Text(movie!.year).fontWeight(.bold)
          if (movie!.director != nil) {
            Text(movie!.director!)
              .font(.headline)
              .fixedSize(horizontal: false, vertical: true)
          }
          if (movie!.runtime != nil) {
            Text(movie!.runtime!)
          }
          if (movie!.rated != nil) {
            Text(movie!.rated!).fontWeight(.semibold)
          }
          movie!.genres.reduce(Text(""), { $0 + Text($1) + Text(" ")} )
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.top, 5)
            .fixedSize(horizontal: false, vertical: true)
          VStack(spacing: 10) {
            ForEach(movie!.ratings, id: \.self.source) { rating in
              MovieRatingView(rating: rating)
            }
          }.padding(.top, 15)
        }.padding(.leading, 5)
        Spacer()
      }
      if (movie!.plot != nil) {
        Text(movie!.plot!)
          .fixedSize(horizontal: false, vertical: true)
          .padding(10)
      }
      //Spacer()
    }.padding()
  }
}

struct MovieRatingView: View {
  var rating: MovieRating
  
  var body: some View {
    HStack {
      if rating.source == "rottenTomatoes" {
        Image("rt-icon")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 29)
          .fixedSize()
      } else if rating.source == "metacritic" {
        Image("metacritic-icon")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 30)
          .fixedSize()
      } else if rating.source == "imdb" {
        Image("imdb-icon")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 45)
          .fixedSize()
      } else {
        Text(rating.source)
      }
      Text(rating.value).font(.system(size: 17, weight: .semibold, design: .default))
      Spacer()
    }
  }
}

//struct MovieDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    VStack {
//      Image("poster-placeholder")
//        .resizable()
//        .aspectRatio(2/3, contentMode: .fit)
//        .frame(height: 400)
//      Text("Movie title").font(.title).padding()
//      Text("This is a movie description. It is not a real description but it is significantly long to maybe look like one.")
//      Spacer()
//    }
//    .padding()
//    .navigationBarTitle(Text("Details"))
//  }
//}
