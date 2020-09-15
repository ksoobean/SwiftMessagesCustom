//
//  MessageToastView.swift
//  CustomSwiftMessages
//
//  Created by master on 2020/09/15.
//  Copyright © 2020 ksb. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

enum DzToastTheme {
    case SUCCESS
    case INFO
    case WARNING
    case ERROR
}

@objcMembers class MessageToastView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    
    private var alertType: DzToastTheme = .SUCCESS
    private var content: String = ""
    private var hasButton: Bool = false
    
    private var buttonHandler: (() -> Void)?
    
    public var superViewController: UIViewController?
    
    /// 생성자
    /// - Parameters:
    ///   - alertType: Theme으로 타입 셋팅(success(기본)/info/error/warning)
    ///   - content: 얼럿에 들어갈 내용
    ///   - hasExtraButton: 버튼이 붙는지(기본은 false)
    /// - Returns: MessageToastView
    public class func instance(alertType: DzToastTheme = .SUCCESS,
                               content: String,
                               hasExtraButton: Bool = false,
                               superViewController: UIViewController) -> MessageToastView {
        let view = Bundle.main.loadNibNamed("MessageToastView", owner: self, options: nil)?.first as! MessageToastView
        
        view.alertType = alertType
        view.content = content
        view.hasButton = hasExtraButton
        view.superViewController = superViewController
        
        
        view.loadView()
        
        return view
    }
    
    /// 생성자에 hasButton true로 해주고 버튼 추가하기!
    /// 버튼 액션 추가하기
    /// - Parameters:
    ///   - buttonTitle: 버튼 타이틀
    ///   - handler: 액션
    public func addButton(buttonTitle: String, handler: @escaping () -> Void) {
        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        let stick = UIView()
        stick.frame.size = CGSize(width: 1, height: 18)
        stick.backgroundColor = .white
        
        self.buttonStack.addArrangedSubview(stick)
        self.buttonStack.addArrangedSubview(button)
        
        self.bringSubviewToFront(button)
    }
    
    public func setDefaultConfig() -> SwiftMessages.Config {
        var config = SwiftMessages.Config()
        
        config.presentationStyle = .bottom
        config.presentationContext = .view(self.superViewController!.view)
        config.duration = .seconds(seconds: 3)
        
        
        return config
    }
    
    private func loadView() {
        
        self.containerView.layer.cornerRadius = self.containerView.frame.height / 2
        
        self.contentLabel.text = self.content
        self.contentLabel.textColor = .black
        
        if true == hasButton {
            self.buttonStack.isHidden = false
            self.buttonStack.axis = .horizontal
            self.buttonStack.alignment = .fill
            self.buttonStack.spacing = 4
        } else {
            self.buttonStack.isHidden = true
        }
        
        self.setViewWithTheme()
        
    }
    
    func buttonAction() {
        if nil != buttonHandler {
            buttonHandler!()
        }
    }
    
    private func setViewWithTheme() {
        switch alertType {
            
        case .INFO:
            self.containerView.backgroundColor = .systemBlue
            self.imageView.image = UIImage(named: "icToastInfo")
        case .SUCCESS:
            self.containerView.backgroundColor = .systemGreen
            self.imageView.image = UIImage(named: "icToastSuccess")
        case .WARNING:
            self.containerView.backgroundColor = .systemYellow
            self.imageView.image = UIImage(named: "icToastWarning")
        case .ERROR:
            self.containerView.backgroundColor = .systemRed
            self.imageView.image = UIImage(named: "icToastError")
        }
    }
    
}
