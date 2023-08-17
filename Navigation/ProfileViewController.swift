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
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
            view.addSubview(tableView)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 450 // Задайте начальное оценочное значение, но оно будет динамически скорректировано
            constraintSetup()
            tableView.delegate = self
            tableView.dataSource = self
            publications = Publicantions.make()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapGesture.delegate = self
            view.addGestureRecognizer(tapGesture)
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "ProfileView")

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
        // Возвращаем количество секций в таблице (1 для профиля)
        return 1
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Возвращаем количество строк в секции (количество публикаций)
        return publications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        let publication = publications[indexPath.row]
        cell.configure(with: publication)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Здесь устанавливаем высоту ячейки на основе содержимого
        return 400
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           if section == 0 {
               let profileView = ProfileView()
               let headerHeight: CGFloat = 220
               profileView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerHeight)
               
               // Отображаем информацию о пользователе в заголовке
               if let user = currentUser {
                   profileView.profileImageView.image = user.avatar
                   profileView.nameLabel.text = user.userName
               }
               return profileView
           }
           return nil
       }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        }
        return 0
    }
  
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           
           tableView.deselectRow(at: indexPath, animated: true)
    }

}

