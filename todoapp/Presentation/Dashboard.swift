//
//  Dashboard.swift
//  todoapp
//
//  Created by Qazeem Abiodun on 06/08/2023.
//

import Foundation
import SwiftUI

struct Dashboard : View {
    @State private var progess : Double = 0.0
    var data = [AppData(label: "Cat"), AppData(label: "Dog"),  AppData(label: "House")]
    var body : some View {
        return HStack(alignment: .top){
            ForEach(
                1...5,
                id: \.self
                    ) { data  in
                        Button {} label: {
                            Text("Cat")
                        }
                    }
        }
    }
}


struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}




struct AppData : Identifiable{
    var  label: String
    var id: String { label }
}


struct CustomHstack : Layout{
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        <#code#>
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        <#code#>
    }
    
    
}
