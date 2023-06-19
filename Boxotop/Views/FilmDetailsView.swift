//
//  FilmDetailsView.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import SwiftUI

struct RatingStars: View {
    @State var rate: Int
    var isTouchable: Bool
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rate {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1..<5 + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rate ? offColor : onColor)
                    .onTapGesture {
                        if isTouchable {
                            rate = number
                        }
                    }
            }
        }
    }
    
}

struct FilmDetailsView: View {
    @StateObject private var viewModel = FilmViewModel()
    @State var id: String
    @State var dominantColor:Color = .clear
    var body: some View {
            ScrollView {
                if let film = viewModel.film {
                    AsyncImage(url: URL(string: film.poster)) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "photo")
                                .resizable()
                            
                        case .success(let image):
                            image
                                .resizable()
                                .cornerRadius(50)
                                .shadow(radius: 50)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundColor(.red)
                        @unknown default:
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
                    
           
                    Text(film.title)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    HStack {
                        Text("Rating : ")
                        RatingStars(rate: (film.imdbRating as NSString).integerValue / 2, isTouchable: false)
                    }
                    Spacer()
                    HStack(alignment: .center) {
                        VStack{
                            Text(film.director)
                            Text("Director")
                                .font(.subheadline)
                        }.padding()
                            Spacer()
                        VStack {
                            Text(film.released)
                            Text("Released")
                        }.padding()
                        VStack {
                            Text(film.runtime)
                            Text("Duration")
                            
                        }.padding()
                        Spacer()
                    }
                    HStack {
                        Text("My Rating : ")
                        RatingStars(rate: 0, isTouchable: true)
                    }.padding()
                    VStack {
                        Text("Synopis :")
                            .underline()
                        Text(film.plot)
                            .padding()
                        Text("Casting :")
                            .underline()
                        Text(film.actors)
                            .padding()
                        Text("Awards :")
                            .underline()
                        Text(film.awards)
                            .padding()
                    }.padding()
                } else {
                    Text("loading..")
                }
            }
            .background(dominantColor)
            .onAppear {
                viewModel.getFilm(id: id) {
                       if let film = viewModel.film {
                           self.setAverageColor(url: film.poster)
                       }
                   }
                
            }
            .ignoresSafeArea()
    }
    
    private func setAverageColor(url: String) {
        guard let url = URL(string: url) else {
                   print("invalid url")
                   return
               }
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: url) {
                       DispatchQueue.main.async {
                           let image = UIImage(data: data)
                           dominantColor =  Color(image!.averageColor!)
                           print(dominantColor)
                       }
                   }
               }
       }
}

struct FilmDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailsView(id: "tt3076658")
    }
}
