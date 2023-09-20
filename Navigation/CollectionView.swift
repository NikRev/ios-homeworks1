import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
        static let contentViewCornerRadius: CGFloat = 4.0
    }
  
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let photosImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrowshape.forward") 
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
    }
    
    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(photosImageView)
        contentView.addSubview(arrowImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            
            photosImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.verticalSpacing),
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            photosImageView.heightAnchor.constraint(equalToConstant: 180.0), // Установите желаемую высоту
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20.0), // Установите желаемую ширину
            arrowImageView.heightAnchor.constraint(equalToConstant: 20.0), // Установите желаемую высоту
        ])
    }
    
    func configure(with image: UIImage) {
        photosImageView.image = image
       }
}
