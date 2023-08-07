//
//  Dashboard.swift
//  todoapp
//
//  Created by Qazeem Abiodun on 06/08/2023.
//

import Foundation
import SwiftUI

struct CustomH : View {
    @State private var progess : Double = 0.0
    @State private var showPopOver : Bool = false
    @State private var name : String = "Qazeem Abiodun"
    @Environment(\.colorScheme) var cat
    var data = [AppData(label: "Cat"), AppData(label: "Dog"),  AppData(label: "House")]
    var body : some View {
        return HStack(alignment: .top){
            ForEach(
                1...5,
                id: \.self
                    ) { data  in
                        Button {
                            print(cat)
                            showPopOver.toggle()
                        } label: {
                            Text("Cat")
                        }
                    }
        }.popover(isPresented: $showPopOver){ VStack(alignment: .leading){
            VStack{
                Text("Welcome ooo")
                ChildView(name: $name)
            }
            
        }.environment(\.colorScheme, .dark)
        }
        
    }
}


struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        CustomH()
    }
}





struct ChildView : View {
    @Binding var name: String
    
    var body : some View  {
        return VStack{
            Text("My name is \(name)")
            Button{
              name = "Adelani adegoke"
            } label : {
                Text("Tap me ooo")
            }
        }
    }
}




struct ItemsPerPageKey: EnvironmentKey {
    static var defaultValue: Int = 10
}

extension EnvironmentValues {
    var itemsPerPage: Int {
        get { self[ItemsPerPageKey.self] }
        set { self[ItemsPerPageKey.self] = newValue }
    }
}


/// For app data
struct AppData : Identifiable{
    var  label: String
    var id: String { label }
}


struct CustomHstack : Layout{
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        let maxsize = computeMaxSize(subviews: subviews)
      
        let spacing =  computeSpacing(subviews: subviews)
        
        let totalSpacing = spacing.reduce(.zero) { $0 + $1}
    
        return CGSize( width: (maxsize.width * CGFloat(subviews.count)) + totalSpacing, height: maxsize.height )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxsize = computeMaxSize(subviews: subviews)
      
        let spacing =  computeSpacing(subviews: subviews)
        
        let sizeProposal = ProposedViewSize( width: maxsize.width, height: maxsize.height)
        
        var x  = bounds.minX + maxsize.width / 2
        
        for index in  subviews.indices {
            subviews[index].place(at: CGPoint( x: x, y: bounds.midY), anchor: .leading,  proposal:  sizeProposal)
            x += maxsize.width + spacing[index]
        }
    }
    
    
    func computeMaxSize(subviews : Subviews) -> CGSize{
        let subviewSizes = subviews.map{ $0.sizeThatFits(.unspecified)}
        
        let maxsize = subviewSizes.reduce(.zero){
            currentMax, subViewSize in CGSize(width: max(currentMax.width, subViewSize.width), height:  max(currentMax.height, subViewSize.height))
        }
        return maxsize
    }
    
    func computeSpacing(subviews: Subviews) -> [CGFloat]{
        let spacing = subviews.indices.map{
            index in  return  subviews[index].spacing.distance(to:  subviews[index + 1].spacing, along: .horizontal)
        }
        return spacing
    }
    
    
    
}
