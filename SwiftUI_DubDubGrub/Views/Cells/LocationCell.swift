//
//  LocationCell.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/6/21.
//

import SwiftUI

struct LocationCell: View {
   
    var location: DDGLocation
    
    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    ForEach(0..<5) { item in
                        AvatarView(size: 35)
                    }
                }
            } //VStack
            .padding(.leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location))
    }
}
