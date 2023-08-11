import UIKit
import SnapKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var publications: [Publicantions] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450 // Задайте начальное оценочное значение, но оно будет динамически скорректировано
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        publications = Publicantions.make()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        // End editing on the text field to dismiss the keyboard
        view.endEditing(true)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
