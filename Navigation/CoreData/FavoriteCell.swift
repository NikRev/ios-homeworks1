import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseIdentifier = "FavoriteCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Добавьте ваши элементы интерфейса, такие как titleLabel и authorLabel, в ячейку
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            // Установите констрейнты для titleLabel и authorLabel
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        // Установите максимальную ширину для корректного переноса текста
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 16
        authorLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 16
    }
    
    func configure(with title: String, author: String, imageURL: String) {
        titleLabel.text = title
        authorLabel.text = "Author: \(author)"
        // Дополнительная конфигурация, если необходимо
    }
}
