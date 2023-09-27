import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    
    private var publications: [Publicantions] = []

    


    var currentUser: User? {
           didSet {
               // Когда устанавливается новое значение для currentUser,
               // обновляем отображение данных на экране
               updateHeaderView()
           }
       }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
           tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
           view.addSubview(tableView)
           tableView.rowHeight = UITableView.automaticDimension
           constraintSetup()
           tableView.delegate = self
           tableView.dataSource = self
           publications = Publicantions.make()
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           tapGesture.delegate = self
           view.addGestureRecognizer(tapGesture)
       }


    public func updateHeaderView() {
        if let user = currentUser, let profileView = tableView.headerView(forSection: 0) as? ProfileView {
            profileView.setUserData(user: user)
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeaderView()
    }

    @objc private func handleTap() {
            // End editing on the text field to dismiss the keyboard
            view.endEditing(true)
        }

    private func constraintSetup() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return publications.count
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            let photos = [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"), UIImage(named: "photo4")]
            cell.configure(with: photos, indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
            let publication = publications[indexPath.row]
            cell.configure(with: publication)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let profileView = ProfileView()
            return profileView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else if section == 1 {
            return 100 //  высоту секции с фотографиями
        } else {
            return 0
        }
    }

    
    // Динамический расчет высоты ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            // Высота ячеек с фотографиями должна быть достаточной для отображения всех фотографий
            return UITableView.automaticDimension
        } else {
            // Высота ячеек с постами должна быть рассчитана на основе их содержимого
            let publication = publications[indexPath.row]
            // рассчитать высоту на основе текста и других элементов в ячейке
            // Возвращаем минимальную высоту, чтобы избежать сворачивания
            return max(400, estimatedHeightForPublication(publication))
        }
    }

    // Функция для оценки высоты ячейки с постом на основе ее содержимого
    private func estimatedHeightForPublication(_ publication: Publicantions) -> CGFloat {
        // Рассчитайте высоту на основе содержимого вашей ячейки (текста, изображений и т. д.)
        // Верните вычисленную высоту
        return 400// Здесь возвращается минимальная высота в примере
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 { // Проверяем, что нажата секция с фотографиями
            let photosVC = PhotosViewController()
            navigationController?.pushViewController(photosVC, animated: true) // Переходим на экран PhotosViewController
        }
        
    }
}
