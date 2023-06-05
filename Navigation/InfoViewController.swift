//
//  InfoViewController.swift
//  Navigation
//
//  Created by Никита  on 05.06.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Модальный контроллер"
        view.backgroundColor = .white
        let showAlertButton = UIButton (type: .system)
        showAlertButton.setTitle("Я кнопка показа alert", for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(showAlertButton)
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        // Do any additional setup after loading the view.
    }
    @objc private func showAlert(){
        let alertController = UIAlertController(title: "Сообщение", message: "Привет", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Сообщение номер раз", style: .default){[weak self] _ in
            guard let self = self else { return }
            print("Сообщение 1")
        }
        
        let action2 = UIAlertAction (title: "Сообщение номер два", style: .default){ [weak self] _ in
            guard let self = self else { return }
            print("Сообщение 2")
        }
            alertController.addAction(action1)
            alertController.addAction(action2)
            present(alertController, animated: true,completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


