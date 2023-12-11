import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let arrowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "→"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.text = NSLocalizedString("Photos", comment: "")
        return label
    }()
    
    
    let photo1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let photo2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let photo3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        return imageView
    }()
    
    let photo4ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    func configure(with photos: [UIImage?], indexPath: IndexPath) {
        //  compactMap для удаления опциональных значений из массива
        let filteredPhotos = photos.compactMap { $0 }
        
        if indexPath.row < filteredPhotos.count {
            photo1ImageView.image = filteredPhotos[indexPath.row]
        }
        if indexPath.row + 1 < filteredPhotos.count {
            photo2ImageView.image = filteredPhotos[indexPath.row + 1]
        }
        if indexPath.row + 2 < filteredPhotos.count {
            photo3ImageView.image = filteredPhotos[indexPath.row + 2]
        }
        if indexPath.row + 3 < filteredPhotos.count {
            photo4ImageView.image = filteredPhotos[indexPath.row + 3]
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
       
    }
   
    private func setupSubviews() {
    addSubview(nameLabel)
    addSubview(photo1ImageView)
    addSubview(photo2ImageView)
    addSubview(photo3ImageView)
    addSubview(photo4ImageView)
    addSubview(arrowLabel)
    }
   
    private func setupConstraints() {
        photo1ImageView.layer.cornerRadius = 6
        photo1ImageView.layer.masksToBounds = true
        
        photo2ImageView.layer.cornerRadius = 6
        photo2ImageView.layer.masksToBounds = true
        
        photo3ImageView.layer.cornerRadius = 6
        photo3ImageView.layer.masksToBounds = true
        
        photo4ImageView.layer.cornerRadius = 6
        photo4ImageView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            photo1ImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            photo1ImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photo1ImageView.widthAnchor.constraint(equalToConstant: 70), // Ширина 90
            photo1ImageView.heightAnchor.constraint(equalToConstant: 70), // Высота
            
            
            photo2ImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            photo2ImageView.leadingAnchor.constraint(equalTo: photo1ImageView.trailingAnchor, constant: 20),
            photo2ImageView.widthAnchor.constraint(equalToConstant: 70), // Ширина 90
            photo2ImageView.heightAnchor.constraint(equalToConstant: 70),
            
            photo3ImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            photo3ImageView.leadingAnchor.constraint(equalTo: photo2ImageView.trailingAnchor, constant: 20),
            photo3ImageView.widthAnchor.constraint(equalToConstant: 70), // Ширина 90
            photo3ImageView.heightAnchor.constraint(equalToConstant: 70),
            
            photo4ImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            photo4ImageView.leadingAnchor.constraint(equalTo: photo3ImageView.trailingAnchor, constant: 20),
            photo4ImageView.widthAnchor.constraint(equalToConstant: 70), // Ширина 90
            photo4ImageView.heightAnchor.constraint(equalToConstant: 70),
            
            arrowLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 350),
        ])
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
