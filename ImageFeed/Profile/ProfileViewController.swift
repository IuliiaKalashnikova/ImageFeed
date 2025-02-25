
import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private let token = OAuth2TokenStorage().token
    private let usersAvatar = UIImageView()
    private let usersName = UILabel()
    private let usersLogin = UILabel()
    private let usersDescription = UILabel()
    
    private func setupUI() {
        usersAvatar.image = UIImage(named: "avatar")
        usersAvatar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersAvatar)
        NSLayoutConstraint.activate([
            usersAvatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            usersAvatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            usersAvatar.widthAnchor.constraint(equalToConstant: 70),
            usersAvatar.heightAnchor.constraint(equalToConstant: 70)
        ])
        usersAvatar.clipsToBounds = true
        usersAvatar.layer.cornerRadius = 35
        
        
        usersName.text = "Екатерина Новикова"
        usersName.textColor = .white
        usersName.font = .boldSystemFont(ofSize: 23)
        usersName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersName)
        usersName.topAnchor.constraint(equalTo: usersAvatar.bottomAnchor, constant: 8).isActive = true
        usersName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        usersName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        
        usersLogin.text = "@ekaterina_nov"
        usersLogin.textColor = .gray
        usersLogin.font = .systemFont(ofSize: 13)
        usersLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersLogin)
        usersLogin.topAnchor.constraint(equalTo: usersName.bottomAnchor, constant: 8).isActive = true
        usersLogin.leadingAnchor.constraint(equalTo: usersName.leadingAnchor).isActive = true
        usersLogin.trailingAnchor.constraint(equalTo: usersName.trailingAnchor).isActive = true
        
        usersDescription.text = "Hello, world!"
        usersDescription.textColor = .white
        usersDescription.font = .systemFont(ofSize: 13)
        usersDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usersDescription)
        usersDescription.topAnchor.constraint(equalTo: usersLogin.bottomAnchor, constant: 8).isActive = true
        usersDescription.leadingAnchor.constraint(equalTo: usersLogin.leadingAnchor).isActive = true
        usersDescription.trailingAnchor.constraint(equalTo: usersLogin.trailingAnchor).isActive = true
        
        
        var button = UIButton.systemButton(
            with: UIImage(named: "logout_button")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.tintColor = UIColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: usersAvatar.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profileService.profile {
             updateProfileDetails(profile: profile)
         }
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        setupUI()
        updateAvatar()
    }
    
    @objc
    private func didTapButton() {
    }
    
    
    private func updateAvatar() {
        guard let profileImageURL = ProfileImageService.shared.avatarUrl,
              let url = URL(string: profileImageURL) else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 35)
        usersAvatar.kf.setImage(with: url, placeholder: UIImage(named: "avatar"), options: [.processor(processor)])
    }
    private func updateProfileDetails(profile: Profile) {
        usersName.text = profile.name
        usersLogin.text = profile.loginName
        usersDescription.text = profile.bio
    }
}
