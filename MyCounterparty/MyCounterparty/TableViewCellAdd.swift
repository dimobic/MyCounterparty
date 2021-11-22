
protocol AddTextProtocol : AnyObject {
    func nameEdit(text:String?)
}

protocol doneKeyboardProtocol :AnyObject{
    func doneButtonKey(_ i: Int)
}

import UIKit

class TableViewCellAdd: UITableViewCell , UITextViewDelegate, UITextFieldDelegate{
    
    var index = -1
    
    weak var delegete1 : AddTextProtocol?
    weak var delegete2 : doneKeyboardProtocol?
    
    func text (_ field : UITextField)-> UITextField{
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17)
        field.returnKeyType = .done
        field.autocapitalizationType = .sentences
        field.backgroundColor = .systemGray6
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.clipsToBounds = true
        field.autocorrectionType = .no
        field.enablesReturnKeyAutomatically = true
        return field
    }
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    lazy var textName : UITextField = {
         let field = UITextField()
        field.addTarget(self, action: #selector(TextFieldDidGange), for: .editingChanged)
         return text(field)
     }()
    
   @objc func TextFieldDidGange(){
       if index == 0 { delegete1?.nameEdit(text: textName.text)}
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegete2?.doneButtonKey(index)
        return true
    }
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
        textName.delegate = self
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }
    
    
    func initConstraints(){
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(textName)
        
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.textName.topAnchor).isActive = true

        textName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        textName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        textName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true        
    }
}

