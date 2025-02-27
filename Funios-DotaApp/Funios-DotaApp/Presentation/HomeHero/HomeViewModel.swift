//
//  HomeViewModel.swift
//  Funios-DotaApp
//
//  Created by Caroline Chan on 20/11/22.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var dotaHero: DotaHeroModel = DotaHeroModel()
    @Published var strHero: DotaHeroModel = []
    @Published var agiHero: DotaHeroModel = []
    @Published var intHero: DotaHeroModel = []
    
    private var dotaServices: DotaHomeServicesProtocol
    
    init(dotaServices: DotaHomeServicesProtocol = DotaHomeServices()) {
        self.dotaServices = dotaServices
        Task {
            await self.getHeroes()
        }
    }
    
    //MARK: Function to get hero data from api and doing the classification
    func getHeroes() async {
        guard let data = try? await dotaServices.getHeroes(endPoint: .getHeroes) else { return }
        
        for item in data {
            switch item.primaryAttr {
            case "str":
                strHero.append(item)
            case "agi":
                agiHero.append(item)
            case "int":
                intHero.append(item)
            default:
                continue
            }
        }
    }
}
