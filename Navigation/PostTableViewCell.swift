import UIKit

class PostTableViewCell: UITableViewCell {
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    private let postDescription: UITextView = {
        let textDescription = UITextView()
        textDescription.font = UIFont.boldSystemFont(ofSize: 16)
        textDescription.textColor = .lightGray
        textDescription.translatesAutoresizingMaskIntoConstraints = false
        textDescription.clipsToBounds = true
        return textDescription
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        // Добавляем все подпредставления на contentView ячейки
        contentView.addSubview(postImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(postDescription)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
   
    private func setupConstraints() {
           NSLayoutConstraint.activate([
               postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
               postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
               postImageView.heightAnchor.constraint(equalToConstant: 250),
               
               authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               
               postDescription.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
               postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
               
               postDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 30), // Минимальная высота для предотвращения сворачивания
               
               likesLabel.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 8),
               likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
               
               viewsLabel.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 8),
               viewsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 220),
           ])
       }




    public func configure(with publication: Publications) {
        // Настройка содержимого ячейки на основе данных публикации
        postImageView.image = UIImage(named: publication.image)
        likesLabel.text = "Likes: \(publication.likes)"
        viewsLabel.text = "Views: \(publication.views)"
        postDescription.text = publication.description
        authorLabel.text = "Author: \(publication.author)"
    }
}

