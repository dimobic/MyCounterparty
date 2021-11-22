/*Тестовое задание
Реализовать работу с контрагентами: добавление, удаление, редактирование. У каждого должны быть следующие поля:
1. Имя
2. Контактный телефон
3. Фотография (если отсутствует, отображать изображение на своё усмотрение)
4. Email адрес (может отсутствовать)
Главная страница приложения должна отображать список контрагентов. Список должен быть отсортирован в алфавитном порядке (от А до Я).
По нажатию на элемент списка должна открываться форма с подробной информацией об контрагенте, на этой же форме можно отредактировать эту информацию.
Расположение кнопок для удаления/добавления не принципиально.
Для хранения данных использовать SQLite.
Платформа: iOS
*/

import UIKit

class TableViewCell: UITableViewCell {
    
    func labelCreate (_ label : UILabel) -> UILabel{
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18)
        return labelCreate(label)
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 20)
        return labelCreate(label)
    }()
    lazy var imagePeople : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = contentView.frame.size.width/8.5
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.systemGray4.cgColor
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }

    func initConstraints(){
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(phoneLabel)
        self.contentView.addSubview(imagePeople)
        
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.imagePeople.rightAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 5).isActive = true
        phoneLabel.leftAnchor.constraint(equalTo: self.imagePeople.rightAnchor, constant: 10).isActive = true
        phoneLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        
        imagePeople.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        imagePeople.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        imagePeople.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/5).isActive = true
        imagePeople.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5).isActive = true
        imagePeople.heightAnchor.constraint(equalTo: self.imagePeople.widthAnchor).isActive = true
        
    }
}
