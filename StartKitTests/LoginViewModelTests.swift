//
//  LoginViewModelTests.swift
//  StartKit
//
//  Created by XueliangZhu on 10/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import StartKit

class LoginViewModelTests: QuickSpec {
    
    override func spec() {
        describe("validate the user name and password") {
            var viewModel: LoginViewModel!
            beforeEach {
                viewModel = LoginViewModel(userInfo: UserInfoService(), keychainService: KeychainSecretStore())
            }
            
            it("should return true when user name and password are not empty") {
                let result = viewModel.isUserNameOrPasswordEmpty(userName: "11", password: "22")
                expect(result).to(beFalse())
            }
            
            it("should return false when password is empty but user name is not empty") {
                let result = viewModel.isUserNameOrPasswordEmpty(userName: "11", password: "")
                expect(result).to(beTrue())
            }
            
            it("should return false when user name is empty but password is not empty") {
                let result = viewModel.isUserNameOrPasswordEmpty(userName: "", password: "22")
                expect(result).to(beTrue())
            }
        }
        
        describe("get user info from userInfo") {
            var viewModel: LoginViewModel!
            beforeEach {
                viewModel = LoginViewModel(userInfo: UserInfoService(), keychainService: KeychainSecretStore())
                viewModel.userInfo.removeUserInfo()
            }
            
            afterEach {
                viewModel.userInfo.removeUserInfo()
            }
            
            it("should return nil when there is no user has been stored") {
                let userInfo = viewModel.getUserInfo()
                expect(userInfo).to(beNil())
            }
            
            it("should retun nil when user name is not nil but password is nil") {
                let user = User(name: "11", avatarUrl: "22")
                user.name = nil
                _ = viewModel.userInfo.saveUserInfo(user: user)
                let userInfo = viewModel.userInfo.getUserInfo()
                expect(userInfo).to(beNil())
            }
            
            it("should retun nil when password is not nil but user name is nil") {
                let user = User(name: "11", avatarUrl: "22")
                user.avatarUrl = nil
                _ = viewModel.userInfo.saveUserInfo(user: user)
                let userInfo = viewModel.userInfo.getUserInfo()
                expect(userInfo).to(beNil())
            }
            
            it("should return user as saved to user info service") {
                let user = User(name: "11", avatarUrl: "22")
                _ = viewModel.userInfo.saveUserInfo(user: user)
                let userInfo = viewModel.userInfo.getUserInfo()
                expect(userInfo?.name).to(equal(user.name))
                expect(userInfo?.avatarUrl).to(equal(user.avatarUrl))
            }
        }
    }
}
