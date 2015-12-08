//
//  LoginViewController.swift
//  csodSwiftREST
//
//  Created by Chalama Challa on 2015-11-30.
//

import UIKit

protocol LoginViewDelegate: class {
  func didTapLoginButton()
  func didTapODataButton()
}

class LoginViewController: UIViewController {
  weak var delegate: LoginViewDelegate?
  
  @IBAction func tappedLoginButton() {
    if let delegate = self.delegate {
    delegate.didTapLoginButton()
    }
  }
    
    @IBAction func tappedGetOData(){
        if let delegate = self.delegate{
            delegate.didTapODataButton()
        }
    }
}