
import UIKit

protocol pictureDelegate : AnyObject {
   func AddPicture()
}

class TableViewCellPhoto: UITableViewCell {
   
    
    weak var delegate :  pictureDelegate?

    lazy var imagePeople : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.systemGray4.cgColor
        return image
    }()
    
    lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(SelPic), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }()
    
    @objc func SelPic(){
        delegate?.AddPicture()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }

    func initConstraints(){
        self.contentView.addSubview(selectButton)
        self.contentView.addSubview(imagePeople)
        
        imagePeople.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        imagePeople.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        imagePeople.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/8).isActive = true
        imagePeople.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5).isActive = true
        imagePeople.heightAnchor.constraint(equalTo: self.imagePeople.widthAnchor).isActive = true
        
        selectButton.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 5).isActive = true
        selectButton.leftAnchor.constraint(equalTo: self.imagePeople.rightAnchor, constant: 10).isActive = true
        selectButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: self.contentView.topAnchor,constant: -5).isActive = true
        selectButton.heightAnchor.constraint(equalTo: self.imagePeople.widthAnchor).isActive = true

    }
}
