//
//  HomeView.swift
//  Cryptobites
//
//  Created by VENOM on 3/23/23.
//

import SwiftUI

struct HomeView: View {
    @State private var Showportfolio: Bool = false
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selection = 0
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24] // Data to display in the cells
    private let images = ["plus.circle.fill", "2", "3", "4"]
        let columns = [
            GridItem(.fixed(80)),
            GridItem(.fixed(80)),
            GridItem(.fixed(60))
        ] //
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.init(Color.theme.red)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
      }
    init() {
        UITabBar.appearance().backgroundColor = UIColor.init(Color.theme.background)
        
        }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                ZStack(alignment:.bottomTrailing){
                    //background layer
                    Color.theme.background.ignoresSafeArea()
                    
                    //content layer
                    VStack{
                        HomeHeader
                        
                        SearchBarView(SearchText: $vm.SaerchText)
                        
                        ColumnTitles
                        
                        if !Showportfolio{
                            allCoinsList
                                .transition(.move(edge: .leading))
                        }
                        if Showportfolio{
                            PortfolioCoinsList
                                .transition(.move(edge: .trailing))
                        }
                        
                        Spacer(minLength: 0)
                    }
                    
                    Image(systemName: "plus.circle.fill").frame(width: 50, height: 50)
                        .font(.system(size: 50))
                        .foregroundColor(Color.theme.accent)
                        .padding()
                        .rotationEffect(Angle(degrees: Showportfolio ? 180: 0))
                        .onTapGesture {
                            withAnimation(.spring()){
                                Showportfolio.toggle()
                            }
                        }
                    
                    
                    
                }
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("First")
            }
            .tag(0)
            
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns, alignment: .top, spacing: 40) {
                    ForEach(data, id: \.self) { item in
                        VStack{
                            Text("\(item)")
                                .font(.headline)
                            
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                        .padding()
                        
                    }
                }
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Second")
                
            }
            .tag(1)
            
            
            NavigationView{
                // 2
               
                List{
                    TabView {
                        ForEach(images, id: \.self) { item in
                            //3
//                            Image(systemName: item)
//
//
//                                .font(.system(size: 200))
                            
                            ZStack{
                               
                                VStack{
                                    Text(item).foregroundColor(Color.black)
                                }
                            }.frame(width: 420, height:120 ).background(
                            Rectangle())
                                .foregroundColor(Color.theme.red)
                                .padding()
                        }
                        
                    }
                    .onAppear
                    {setupAppearance()
                    }
                    
                    .background(Color.theme.background)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 300)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                } .listStyle(PlainListStyle())
                     //: List
                        .navigationBarTitle("Image Slider", displayMode: .large)
                      
                        
                }
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third")
                }
                .tag(2)
                
            }
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView().navigationBarHidden(true)
        }.environmentObject(dev.homeVM)
    }
}

extension HomeView {
    
    private var HomeHeader : some View {
        HStack{
            CircleButtonView(IconName: Showportfolio ? "plus" : "info")
                .animation(.none)
                .background{
                    CircleButtonAnimationView(animate: $Showportfolio)
                }
            Spacer()
            Text(Showportfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent).animation(.none)
            Spacer()
            CircleButtonView(IconName: "chevron.right").rotationEffect(Angle(degrees: Showportfolio ? 180: 0)).onTapGesture {
                withAnimation(.spring()){
                    Showportfolio.toggle()
                }
            }
        }.padding(.horizontal)
        
    }
    
    private var allCoinsList : some View{
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowPreview(coin: coin, ShowHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
    
    
    private var PortfolioCoinsList : some View{
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowPreview(coin: coin, ShowHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
    
    private var ColumnTitles : some View{
        HStack{
            Text("Coin")
            Spacer()
            if Showportfolio{
                Text("Holdings")
            }
            Text("Price").frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
    }
}
