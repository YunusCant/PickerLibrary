//
//  Login.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//
import SwiftData
import SwiftUI

struct Login: View {
    @Environment(\.modelContext) private var context
    @Query private var persons : [Person]
    @State private var giris : Bool = false
    @State var isim : String = ""
    @State var sifre : String = ""
    @State var showView : Bool = false
    @State private var showAlert : Bool = false
    @State private var logIn = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("KullaniciAdi") var kullaniciAdi = ""
    var body: some View {
        NavigationStack{
            VStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .foregroundStyle(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding()
                
                ScrollView{
                    HStack{
                        Picker(selection: $giris, label: Text("")) {
                            Text("Giriş Yap").tag(true)
                            Text("Kayıt Ol").tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                    }.padding()
                    
                    Group{
                        TextField("isim", text: $isim)
                            .keyboardType(.default)
                            .textInputAutocapitalization(.never)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        SecureField("Şifre", text: $sifre)
                            .textInputAutocapitalization(.never)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }.padding(5)
                }
            }
            
            Button {
                if giris {
                    login()
                }else{
                    register(x: isim, y: sifre)
                }
                
            } label: {
                if giris {
                    Text("Giriş Yap")
                }else{
                    Text("Kayıt Ol")
                }
            }
            .alert(isPresented: $showAlert){
                if giris {
                    alert(title: "Hatta", message: "Kullanıcı adı veya şifre Hatalı!", disMissButton: "Tamam")
                }else{
                    alert(title: "Hatta", message: "Bu kullanıcı adı zaten mevcut.", disMissButton: "Tamam")
                }
            }
            .fullScreenCover(isPresented: $isLoggedIn) {
                ContentView()
                    
            }
            .onAppear{
                if UserDefaults.standard.bool(forKey: "isLoggedIn"){
                    isLoggedIn = true
                }
            }
        }

    }
    func login() {
        if persons.first(where: { $0.name == isim && $0.passWord == sifre }) != nil {
            // Giriş başarılı, istenen işlemleri yapabilirsiniz.
            UserDefaults.standard.set(true, forKey: "isLoggedIn")// Giriş yapıldığında UserDefaults kullanarak işaretlemeyi yapar
            kullaniciAdi = isim // Kullanıcı adını AppStorage'a kaydet
            
        } else {
            // Kullanıcı adı veya şifre hatalı, uyarı gösterebilir veya başka bir işlem yapabilirsiniz.
            showAlert = true
        }
    }
    func register(x: String, y: String) {
        if persons.contains(where: { $0.name == x }) {
            showAlert = true
        } else {
            let newPerson = Person(name: x, passWord: y)
            context.insert(newPerson)
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
        }
        
    }
    func alert(title: String = "Hatta" ,message : String = "Tekrar deneyin!",disMissButton : String = "Tamam") -> Alert {
        return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text(disMissButton)))
        
    }
    
}

#Preview {
    Login()
}
