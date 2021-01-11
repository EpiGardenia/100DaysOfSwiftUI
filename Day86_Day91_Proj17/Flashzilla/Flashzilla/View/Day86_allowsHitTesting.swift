//
//  Day86_allowsHitTesting.swift
//  Flashzilla
//
//  Created by T  on 2021-01-09.
//

import SwiftUI

struct Day86_allowsHitTesting: View {
    var body: some View {
        VStack{
            Spacer()
            Divider()
            Group{
                Text("Circle and rest rectangle is tapable")
                ZStack{
                    Rectangle()
                        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            print("Rectangle")
                        }
                    
                    Circle()
                        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        .onTapGesture {
                            print("Circle")
                        }
                }
            }
            
            Divider()
            Group{
                Text("Disable Circle AllowsHitTesting")
                ZStack{
                    Rectangle()
                        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            print("Rectangle")
                        }
                    Circle()
                        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        .onTapGesture {
                            print("Circle")
                        }.allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                }
            }
            
            Divider()
            Group {
                VStack{
                    Text("Below space is untappable")
                    Spacer().frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Above space is untappable")
                }
            }.onTapGesture {
                print("Tapped!")
            }
            
            Divider()
            
            Group {
                Text("Space is tappable")
                Spacer().frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("with contentShape")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("Tapped!")
            }
            Divider()

        }
    }
}

struct Day86_allowsHitTesting_Previews: PreviewProvider {
    static var previews: some View {
        Day86_allowsHitTesting()
    }
}
