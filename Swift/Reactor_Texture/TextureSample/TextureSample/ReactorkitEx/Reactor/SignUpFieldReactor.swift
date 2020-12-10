//
//  SignUpFieldReactor.swift
//  TextureSample
//
//  Created by sro on 2020/12/10.
//

import ReactorKit

class SignUpFieldReactor: Reactor {
    
    struct Const {
        static let passwordMinimumValidCount: Int = 6
    }
    
    enum Scope {
        case email
        case password
        
        var returnKeyType: UIReturnKeyType {
            return self == .email ? .next : .join
        }
        
        var keyboardType: UIKeyboardType {
            return self == .email ? .emailAddress :  .default
        }
        
        var clearOnInsertion: Bool {
            return self == .password ? true : false
        }
        
        var isSecureTextEmtry: Bool {
            return self == .password ? true : false
        }
        
        var placeholderString: String {
            switch self {
            case.email: return "What`s your email?"
            case .password: return "Password"
            }
        }
    }
    
    enum FieldStatus {
        case wrong
        case valid
        
        var attribute: [NSAttributedString.Key: Any] {
            switch self {
            case .wrong: return [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.invalid]
            case .valid: return [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.valid]
            }
        }
        
        func text(_ scope: Scope) -> String {
            switch self {
            case .wrong:
                return scope == .email ? "Pleas enter a valid email address" : "Please enter a valid password"
            case .valid:
                return scope == .email ? "Email looks great" : "Password looks great"
            }
        }
        
        func message(_ scope: Scope) -> NSAttributedString {
            return NSAttributedString.init(string: self.text(scope), attributes: self.attribute)
        }
    }
    
    enum Action {
        case editingChanged(Scope?, String?)
    }
    
    enum Muataion {
        case setStatus(Scope?, String?)
    }
    
    struct State {
        var message: NSAttributedString?
        var fieldStatus: FieldStatus = .wrong
    }
    
    let initialState: State = State()
}


extension UIColor {
    
    static var valid: UIColor {
        return UIColor.init(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
    }
    
    static var invalid: UIColor {
        return UIColor.init(red: 0.8, green: 0.2, blue: 0.3, alpha: 1.0)
    }
}
