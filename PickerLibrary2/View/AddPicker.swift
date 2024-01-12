//
//  AddPicker.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddPicker: View {
    @Environment(\.modelContext) private var context
    
    @State private var title = ""
    @State private var subTitle = ""
    @State private var date : Date = .init()
    @State private var photoItem : PhotosPickerItem?
    @State private var selectPhoto = false
    @State private var imageData : Data?
    @State private var showAlert = false
    var body: some View {
        NavigationStack{
            ScrollView{
                HStack{
                    Text("New Post")
                        .font(.title)
                        .bold()
                    Spacer()
                    Button{
                        if title != "" && subTitle != "" && imageData != nil && photoItem != nil {
                            kaydet(title: title, subTitle: subTitle, imageData: imageData!, date: date)
                            
                            
                        }else {
                            showAlert = true
                            
                        }
                        
                    }label: {
                        Text("Upload")
                            .fontWeight(.semibold)
                    }
                }.padding()
                VStack{
                    
                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                selectPhoto = true
                            }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                selectPhoto = true
                            }
                    }
                    
                    
                    
                    Spacer()
                    Group{
                        TextField("Title", text: $title)
                        TextField("subTitle", text: $subTitle)
                    }
                    .font(.subheadline)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray6), lineWidth: 1))
                    .padding(.horizontal,24)
                    
                    Section("Date"){
                        DatePicker("",selection: $date,displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                        
                    }.padding(.top,5)
                    
                    
                }.alert(isPresented: $showAlert){
                    Alert(title: Text("Hatta"), message: Text("Eksik bilgi girdiniz!"), dismissButton: .default(Text("Tamam")))
                }
                //                .onAppear(){
                //                    imagePickerPresented.toggle()
                //                }
                
                .photosPicker(isPresented: $selectPhoto, selection: $photoItem)
                .task(id: photoItem){
                       if let data = try? await photoItem?.loadTransferable(type: Data.self){
                        imageData = data
                    }
                }
            }
        }
        
    }

    func kaydet(title: String, subTitle: String, imageData: Data, date: Date) {
        let newPost = Post(title: title, subTitle: subTitle, date: date, image: imageData)
        context.insert(newPost)
        
    }

}
#Preview {
    AddPicker()
}
