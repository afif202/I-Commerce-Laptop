//
//  Home.swift
//  foodKavsoft
//
//  Created by Irianda on 28/02/21.
//

import SwiftUI

struct Home: View {
   @StateObject var HomeModel = HomeViewModel()
    var body: some View {
      ZStack{
         VStack(spacing: 10){
         HStack(spacing: 15){
            
            Button (action: {
               withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            }, label: {
               Image(systemName: "line.horizontal.3")
                  .font(.title)
                  .foregroundColor(Color.blue)
            })
            
            
            Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver to")
               .foregroundColor(.black)
            
            Text(HomeModel.userAddress)
               .font(.caption)
               .fontWeight(.heavy)
               .foregroundColor(.blue)
            
            Spacer(minLength: 0)
         }
         
         .padding([.horizontal,.top])
         
         Divider()
         
         HStack(spacing: 15){
            
            Image(systemName: "magnifyingglass")
               .font(.title)
               .foregroundColor(.gray)
            TextField("Search", text: $HomeModel.search)
            
         }
         .padding(.horizontal)
         .padding(.top,10)
         
         Divider()
         
            ScrollView(.vertical, showsIndicators: false, content: {
               VStack(spacing: 25){
                  ForEach(HomeModel.filtered){item in
                     
                     ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                        ItemView(item: item)
                        
                        HStack{
                           Text("Free Delivery")
                              .foregroundColor(.white)
                              .padding(.vertical,10)
                              .padding(.horizontal)
                              .background(Color.blue)
                           
                           Spacer(minLength: 0)
                           
                           Button(action: {},label: {
                              Image(systemName: "plus")
                                 .foregroundColor(.white)
                                 .padding(10)
                                 .background(Color.blue)
                                 .clipShape(Circle())
                           })
                        }
                        .padding(.trailing,10)
                        .padding(.top,10)
                     })
                     
                        .frame(width: UIScreen.main.bounds.width - 30)
                  }
               }
               
               .padding(.top,10)
            })
        
      }
         
         HStack{
            Menu(homeData: HomeModel)
               .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
            
            Spacer(minLength: 0)
         }
         .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
         .onTapGesture(perform:  {
            withAnimation(.easeIn){HomeModel.showMenu.toggle()}
         })
         )
         if HomeModel.noLocation {
            Text("Please Enable Location Access In Settiings To Further Move On !!")
               .foregroundColor(.black)
               .frame(width: UIScreen.main.bounds.width - 100, height: 120)
               .background(Color.white)
               .cornerRadius(10)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .background(Color.black.opacity(0.3).ignoresSafeArea())
         }
      
    }
      .onAppear(perform: {
         
         //calling location delegate
         HomeModel.locationManager.delegate = HomeModel
      })
      
      .onChange(of: HomeModel.search, perform: { value in
         
         // to avoid continues search reqets..
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            if value == HomeModel.search && HomeModel.search != ""{
               // search data
               
               HomeModel.fetchData()
            }
         }
         
         if HomeModel.search == "" {
            withAnimation(.linear) {HomeModel.filtered = HomeModel.items}
         }
      })
}
}
