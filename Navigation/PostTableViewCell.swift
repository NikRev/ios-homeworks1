import UIKit

class PostTableViewCell: UITableViewCell {

   
    private let scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           return scrollView
       }()
    
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFill // Изображение будет заполнять всю доступную область, обрезая при необходимости
        imageView.clipsToBounds = true // Обрезать изображение, чтобы оно не выходило за пределы ячейки
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
        textDescription.textColor = .black
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
            contentView.addSubview(scrollView) // Сначала добавляем scrollView
            scrollView.addSubview(postImageView) // Затем добавляем postImageView в scrollView
            scrollView.addSubview(likesLabel)
            scrollView.addSubview(viewsLabel)
            scrollView.addSubview(postDescription) // Добавляем postDescription в scrollView
            scrollView.addSubview(authorLabel) // Добавляем authorLabel в scrollView
        }

    private func setupConstraints() {
        // Ограничения для scrollView
        NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
       
        NSLayoutConstraint.activate([
        postDescription.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
        postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        postDescription.heightAnchor.constraint(equalToConstant: 30) 
        ])

        
        // Ограничения для postImageView
        NSLayoutConstraint.activate([
        postImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
        postImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
        postImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
        postImageView.heightAnchor.constraint(equalToConstant: 20) // Размер изображения
        ])

        
        // Ограничения для likesLabel
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        // Ограничения для viewsLabel
        NSLayoutConstraint.activate([
            viewsLabel.trailingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 20),
            viewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
   public func configure(with publication: Publicantions) {
        postImageView.image = UIImage(named: publication.image)
        likesLabel.text = "Likes: \(publication.likes)"
        viewsLabel.text = "Views: \(publication.views)"
        postDescription.text = publication.description // Set the description text
        authorLabel.text = "Author: \(publication.author)"
    }
}
