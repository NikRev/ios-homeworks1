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
        imageView.contentMode = .scaleAspectFill // Изображение будет заполнять всю доступную область, обрезая при необходимости
        imageView.clipsToBounds = true // Обрезать изображение, чтобы оно не выходило за пределы ячейки
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(postImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        // Ограничения для scrollView
                NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
        
        // Ограничения для postImageView
               NSLayoutConstraint.activate([
                   postImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
                   postImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
                   postImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
                   postImageView.heightAnchor.constraint(equalToConstant: 200) // Размер изображения
               ])

        
        // Ограничения для likesLabel
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        // Ограничения для viewsLabel
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 8),
            viewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    func configure(with publication: Publicantions) {
        postImageView.image = UIImage(named: publication.image)
        likesLabel.text = "Likes: \(publication.likes)"
        viewsLabel.text = "Views: \(publication.views)"
    }
}
