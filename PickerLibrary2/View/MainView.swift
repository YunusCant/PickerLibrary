//
//  MainView.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query private var posts : [Post]
    var screenSize = UIScreen.main.bounds
    var body: some View {
        var dateFormatter : DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }
        NavigationStack{
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .leading)
                    .padding(10)
                    .background(Color.black)
                    .foregroundStyle(Color.white)
                    .overlay(Circle().stroke(Color.primary,lineWidth: 3))
                    .clipShape(Circle())
                Spacer()
                Text("Picker Library")
                    .bold()
                    .font(.title3)
                Spacer()
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .foregroundStyle(Color.black)
                    .frame(width: 35, height: 35, alignment: .trailing)
            }.padding(.horizontal,10)
                .background(Color.orange)
            List(posts){ post in
                VStack{
                    if let imageData = post.image, let uiImage = UIImage(data: imageData) {
                        Divider().background(Color.black).frame(height: 4)
                        Text("Tarih: \(post.date, formatter: dateFormatter)")
                        
                        Divider().background(Color.black).frame(height: 4)
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: screenSize.width, height: 300, alignment: .center)
                        Divider()
                        
                        HStack{
                            Text(post.title)
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                            Spacer()
                        }
                        HStack{
                            Text(post.subTitle)
                                .font(.subheadline)
                                .padding(.leading)
                            Spacer()
                            
                        }
                    }
                }.padding(.bottom)
            }.padding(-20)
        }
    }
}

#Preview {
    MainView()
}
