//
//  ViewController.swift
//  CustomSwiftMessages
//
//  Created by master on 2020/09/15.
//  Copyright © 2020 ksb. All rights reserved.
//

import UIKit
import SwiftMessages

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showToastAction(_ sender: Any) {
        
        let toast = MessageToastView.instance(alertType: .ERROR,
                                              content: "완료액션토스트",
                                              hasExtraButton: false,
                                              superViewController: self)
        
        SwiftMessages.show(config: toast.setDefaultConfig(), view: toast)
        
    }
    @IBAction func showToastWithButton(_ sender: Any) {
        let buttonToast = MessageToastView.instance(alertType: .SUCCESS,
                                                    content: "버튼도나올것",
                                                    hasExtraButton: true,
                                                    superViewController: self)
        
        buttonToast.addButton(buttonTitle: "편집") {
            print("편집 버튼 클릭")
        }
        SwiftMessages.show(config: buttonToast.setDefaultConfig(), view: buttonToast)
    }
}

