//
//  String+Extionsion.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/14.
//

import AsyncDisplayKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: self)
    }
}
