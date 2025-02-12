
import UIKit

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatar = UIImage(named: "avatar")
        let imageView = UIImageView(image: avatar)
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        imageView.widthAnchor.constraint(equalToConstant: 70),
        imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        let name = UILabel()
        name.text = "Екатерина Новикова"
        name.textColor = .white
        name.font = .boldSystemFont(ofSize: 23)
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        name.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        
        let loginName = UILabel()
        loginName.text = "@ekaterina_nov"
        loginName.textColor = .gray
        loginName.font = .systemFont(ofSize: 13)
        loginName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginName)
        loginName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        loginName.leadingAnchor.constraint(equalTo: name.leadingAnchor).isActive = true
        loginName.trailingAnchor.constraint(equalTo: name.trailingAnchor).isActive = true
        
        let usersText = UILabel()
        usersText.text = "Hello, world!"
        usersText.textColor = .white
        usersText.font = .systemFont(ofSize: 13)
        usersText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersText)
        usersText.topAnchor.constraint(equalTo: loginName.bottomAnchor, constant: 8).isActive = true
        usersText.leadingAnchor.constraint(equalTo: loginName.leadingAnchor).isActive = true
        usersText.trailingAnchor.constraint(equalTo: loginName.trailingAnchor).isActive = true
        
        
        let button = UIButton.systemButton(
            with: UIImage(named: "logout_button")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        
        button.tintColor = UIColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc
    private func didTapButton() {
    }
}
