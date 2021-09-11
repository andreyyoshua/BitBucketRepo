//
//  ClosureSleeve.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import UIKit

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    public func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}


extension UIControl {
    public func onTap(_ closure: @escaping ()->()) {
        self.removeTarget(nil, action: nil, for: .touchUpInside)
        self.addAction(for: .touchUpInside, closure)
    }
}
