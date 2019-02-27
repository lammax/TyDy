//
//  Coder.swift
//  TyDy
//
//  Created by Mac on 27/02/2019.
//  Copyright © 2019 Lammax. All rights reserved.
//

import Foundation

class Encoder {
    
    private static var singleton = Encoder()
    static var shared: Encoder {
        return singleton
    }
    
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TyDyItems.plist")

    func saveData(dataToEncode: [TyDyItem]) {
        do {
            let encodedData = try encoder.encode(dataToEncode)
            if let path = dataFilePath {
                try encodedData.write(to: path)
            }
        } catch {
            print(error)
        }
    }
    
    func loadData() -> [TyDyItem]? {
        if let url = dataFilePath {
            do {
                let data = try Data(contentsOf: url)
                let items: [TyDyItem] = try self.decoder.decode([TyDyItem].self, from: data)
                return items
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
}
