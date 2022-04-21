//
//  ContentView.swift
//  SpotifySwiftUI
//
//  Created by Berke Sarıtaş on 19.04.2022.
//

import SwiftUI
import AVFoundation
import AVFAudio


struct Song: Identifiable {
    var id : String {title}
    let title : String
    let artist : String
    let coverString : String
}



struct ContentView: View {


    func playAudioAsset(_ assetName : String) {
        var audioPlayer: AVAudioPlayer!

         guard let audioData = NSDataAsset(name: assetName)?.data else {
            fatalError("Unable to find asset \(assetName)")
         }

         do {
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer.play()
         } catch {
            fatalError(error.localizedDescription)
         }
        
    }
    let songs = [
        Song(title: "SongOne", artist: "Berke", coverString: "cover"),
        Song(title: "SongTwo", artist: "Berke", coverString: "cover"),
        Song(title: "SongThree", artist: "Berke", coverString: "cover"),
        Song(title: "SongFour", artist: "Berke", coverString: "cover"),
        Song(title: "SongFive", artist: "Berke", coverString: "cover")

    ]
    
    let bgColor = Color(hue: 0, saturation: 0, brightness: 0.071)
    
    @State private var isPlaying = false
    @State private var isLiked = false

     
    
    func getOffSetY(reader: GeometryProxy) -> CGFloat {
        let offSetY : CGFloat = -reader.frame(in: .named("srollView")).minY
        
        if offSetY < 0 {
            return offSetY / 1.3
        }
        return offSetY
        
    }
    
    var body: some View {
        ScrollView( showsIndicators: false){
            
            GeometryReader{ reader in
                
                let offSetY = getOffSetY(reader : reader)
                let heigth : CGFloat  = (reader.size.height - offSetY) - offSetY / 3
                let minHeigth : CGFloat = 120
                let opacity = (heigth - minHeigth) / (reader.size.height - minHeigth)
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.red , Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        .scaleEffect(7)
                    Image("cover")
                        .resizable()
                        .frame(width: heigth, height: heigth)
                        .offset(y: offSetY)
                        .opacity(opacity)
                        .shadow(color: Color.black, radius: 30)
                        .padding()
                }.frame(width : reader.size.width)
                
            }.frame(height: 250)
            
            Spacer().frame(height : 25)
            albumDetailsView.padding()
            Spacer().frame(height : 25)
            songListView.padding(.horizontal)
        }.background(bgColor.ignoresSafeArea())
            .coordinateSpace(name: "scrollView")
    }
    
    var songListView: some View {
        ForEach(songs) { song in
            
            HStack{
                Image(song.coverString)
                    .resizable()
                    .frame(maxHeight : .infinity)
                    .aspectRatio(1, contentMode: .fit)
                
                VStack(alignment : .leading , spacing: 5){
                    Text(song.title )
                        .font(.title3)
                        .bold()
                    
                    Text(song.artist)
                        .font(.subheadline)
                        .opacity(0.8)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 25))
                    .frame(maxHeight : .infinity)
                    .opacity(0.8)
                
            }
            .frame(height : 60)
            .foregroundColor(.white)
            
        }
    }
    
    var albumDetailsView: some View {
        HStack{
            VStack(alignment: .leading , spacing: 10){
                Text("trip")
                    .font(.title)
                    .bold()
                
                HStack{
                    Image("cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text("Berke")
                        .font(.title2)
                        .bold()
                }
                Text("Album • 2022")
                
                HStack(spacing : 30){
                    
                    Button(action: {
                        isLiked.toggle()
                    }, label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 30))
                            .padding(.top , 10)
                    })
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .offset(y:5)
                }
            }.foregroundColor(.white)
            Spacer()
            
            Button(action: {
               playAudioAsset("deneme")
                isPlaying.toggle()
               
            }, label: {
                ZStack{
                    Circle()
                        .foregroundColor(.green)
                    
                    Image(systemName: isPlaying ?  "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                }.frame(width: 80, height: 80)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
