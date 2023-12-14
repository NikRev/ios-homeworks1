import UIKit
import CoreData

protocol ProfileViewControllerDelegate: AnyObject {
    func profileViewController(_ profileViewController: ProfileViewController, didDoubleTapPublication publication: Publications)
}

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, PostTableViewCellDelegate {
    weak var delegate: ProfileViewControllerDelegate?
   
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var viewModel: ProfileViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel()

        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self

        // Добавим распознаватель жестов для обработки двойного касания
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapGesture)
        setupTheme()
        constraintSetup()
    }

    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        // Проверяем, что жест был успешно распознан
        if gesture.state == .recognized {
            let location = gesture.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: location) {
                // Получаем модель представления публикации для выбранной ячейки
                let publicationViewModel = viewModel.publicationViewModel(at: indexPath)
                
                // Создаем новый объект 'FavoriteBase' в контексте CoreData
                let newPublication = FavoriteBase(context: CoreDataService.shared.context)
                
                // Устанавливаем свойства новой публикации из модели представления
                newPublication.author = publicationViewModel.publication.author
                newPublication.description1 = publicationViewModel.publication.description
                // Устанавливаем другие свойства по необходимости
                
                // Сохраняем изменения в CoreData
                CoreDataService.shared.saveContext()
                
                
                 tableView.reloadData()
            }
        }
    }

    private func setupTheme() {
        updateTheme(traitCollection.userInterfaceStyle)
        
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateTheme(traitCollection.userInterfaceStyle)
        }
        
    }

    private func updateTheme(_ userInterfaceStyle: UIUserInterfaceStyle) {
        if userInterfaceStyle == .dark {
            setupDarkTheme()
        } else {
            setupLightTheme()
        }
        
    }

    private func setupLightTheme() {
        view.backgroundColor = .lightBackground
        // Другие настройки для светлой темы
        
    }

    private func setupDarkTheme() {
        view.backgroundColor = .darkBackground
        
        // Другие настройки для темной темы
        
    }
    
    private func constraintSetup() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   
    func didDoubleTapPost(at indexPath: IndexPath) {
        // Ваш код для получения данных о посте из indexPath
        let publicationViewModel = viewModel.publicationViewModel(at: indexPath)
        
        // Вызов делегата для добавления в избранное
        if let delegate = delegate {
            delegate.profileViewController(self, didDoubleTapPublication: publicationViewModel.publication)
        }
        
        // Перезагрузка данных или другие действия
        tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            let photos = [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"), UIImage(named: "photo4")]
            cell.configure(with: photos, indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
            let publicationViewModel = viewModel.publicationViewModel(at: indexPath)
            let publication = Publications(author: publicationViewModel.publication.author, description: publicationViewModel.publication.description, image: publicationViewModel.publication.image, views: publicationViewModel.publication.views, likes: publicationViewModel.publication.likes)
            cell.configure(with: publication)
            return cell

        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let profileView = ProfileView(profileViewModel: self.viewModel)
            return profileView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else if section == 1 {
            return 100
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            let publicationViewModel = viewModel.publicationViewModel(at: indexPath)
            return max(400, viewModel.estimatedHeightForPublication(publicationViewModel.publication))
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true)
        } else if indexPath.section == 1 {
            let publicationViewModel = viewModel.publicationViewModel(at: indexPath)

            if let delegate = delegate {
                delegate.profileViewController(self, didDoubleTapPublication: publicationViewModel.publication)
            }
        }
    }

}

extension UIColor {
    static let lightBackground = UIColor.white
    static let lightText = UIColor.black
    static let darkBackground = UIColor.black
    static let darkText = UIColor.white
    // Добавьте другие цвета по мере необходимости
}
