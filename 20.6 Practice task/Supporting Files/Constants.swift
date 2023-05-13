//
//  Constants.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import UIKit

enum Constants {
    enum Colors {
        static var greenPramary: UIColor? {
            UIColor(named: "GreenPrimary")
        }
        
        static var greenSecondary: UIColor? {
            UIColor(named: "GreenSecondary")
        }
        
        static var gray01: UIColor? {
            UIColor(named: "Gray01")
        }
        
        static var gray02: UIColor? {
            UIColor(named: "Gray02")
        }
        
        static var gray03: UIColor? {
            UIColor(named: "Gray03")
        }
        
        static var gray04: UIColor? {
            UIColor(named: "Gray04")
        }
    }
    
    enum Fonts {
        static var ui30Semi: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 30 )
        }
        
        static var ui30Medium: UIFont? {
            UIFont(name: "Inter-Medium", size: 24 )
        }
        
        static var ui30Regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 30 )
        }
        
        static var ui16Semi: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 16 )
        }
        
        static var ui16Medium: UIFont? {
            UIFont(name: "Inter-Medium", size: 16 )
        }
        
        static var ui16Regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 16 )
        }
        
        static var ui14Semi: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 14 )
        }
        
        static var ui14Medium: UIFont? {
            UIFont(name: "Inter-Medium", size: 14 )
        }
        
        static var ui14Regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 14 )
        }
        
        static var ui10Regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 10 )
        }
        
        static var systemHeading: UIFont {
            UIFont.systemFont(ofSize: 30, weight: .semibold)
        }
        
        static var systemText: UIFont {
            UIFont.systemFont(ofSize: 16)
        }
    }
    
    enum Text {
        static let heading = "Header"
        static let text = "He'll want to use your yacht, and I don't want this thing smelling like fish."
        static let time = "8m ago"
    }
    
    enum Titles {
        static var name = "Имя"
        static var lastname = "Фамилия"
        static var occupation = "Род занятий"
        static var birth = "Год рождения"
        static var country = "Страна"
        static var buttonURLSession = "URLSession"
        static var buttonAlamofire = "Alamofire"
        static var aboutinfo = "Для инициализации запроса заполните все поля"
        static var successLabel = "Запрос выполнен успешно"
        static var errorLabel = "Ошибка выполнения запроса"
    }
}
