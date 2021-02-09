//
//  AstronautView.swift
//  moonshot
//
//  Created by Travis Brigman on 2/9/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let flownMissions: [Mission]
    var astronaut: Astronaut
    
    var body: some View {
        GeometryReader {
            geometry in
            ScrollView(.vertical){
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    ForEach(self.flownMissions){
                        mission in
                        Text(mission.displayName)
                    }
                }
                
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
        
    }
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
    
        let astronautsWhoFlewOnMission = missions.filter({mission in
            return mission.crew.contains(where: {$0.name == astronaut.id })
        }).filter({ $0.crew.count > 0 })
        
        self.flownMissions = astronautsWhoFlewOnMission
       
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
//        AstronautView(mission: missions[0], astronauts: astronauts)
        AstronautView(astronaut: astronauts[0] , missions: missions)
    }
}
