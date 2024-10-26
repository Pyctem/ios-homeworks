//
//  LogInViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/10/24.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate {
    func check(_ login: String, _ password: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ login: String, _ password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}

class LogInViewController: UIViewController {
    var loginDelegate: LoginViewControllerDelegate?
    private let userService: UserService
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let contentView = UIView()
       
       contentView.translatesAutoresizingMaskIntoConstraints = false
       
       return contentView
   }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.backgroundColor = .systemGray6
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "mainColor")
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.layer.masksToBounds = true
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "mainColor")
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.layer.masksToBounds = true
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        func imageWithAlpha(originalImage: UIImage, alpha: CGFloat = 1) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(originalImage.size, false, originalImage.scale)
            let context = UIGraphicsGetCurrentContext()!
            let area = CGRect(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height)
            
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0, y: -originalImage.size.height)
            context.setBlendMode(.multiply)
            context.setAlpha(alpha)
            context.draw(originalImage.cgImage!, in: area)
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "mainColor")
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .disabled)

        button.setBackgroundImage(imageWithAlpha(originalImage: UIImage(named: "blue_pixel")!), for: .normal)
        button.setBackgroundImage(imageWithAlpha(originalImage: UIImage(named: "blue_pixel")!, alpha: 0.8), for: .selected)
        button.setBackgroundImage(imageWithAlpha(originalImage: UIImage(named: "blue_pixel")!, alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(imageWithAlpha(originalImage: UIImage(named: "blue_pixel")!, alpha: 0.8), for: .disabled)

        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(userService: CurrentUserService) {
        #if DEBUG
        self.userService = TestUserService()
        #else
        let currentUser = User(username: "MyLogin", fullName: "MyPassword", avatar: UIImage(), status: "User status")
        self.userService = CurrentUserService(user: currentUser)
        #endif
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: -1),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func logInButtonTapped() {
        guard let login = loginTextField.text, !login.isEmpty else {
            showAlert("Please enter a login.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert("Please enter a password.")
            return
        }
        
        if let user = userService.getUser(by: login), loginDelegate?.check(user.username, password) ?? false {
            let profileViewController = ProfileViewController(user: user)
            navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            showAlert("User not found.")
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func willShowKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }
    
    @objc func willHideKeyboard(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

