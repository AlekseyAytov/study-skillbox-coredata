//
//  SettingsStorage.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/19/23.
//

import Foundation

class SettingsStorage {
    
    private var storage = UserDefaults.standard
    
    var storageKey = "settings"
    
    func loadSettings() -> Settings? {
        guard let data = storage.data(forKey: storageKey) else { return nil }
        guard let decode = try? JSONDecoder().decode(Settings.self, from: data) else { return nil }
        print("Settings loaded")
        return decode
    }
    
    func saveSettings(settings: Settings) {
        guard let storageData = try? JSONEncoder().encode(settings) else { return }
        storage.set(storageData, forKey: storageKey)
        print("Settings saved")
    }
}
