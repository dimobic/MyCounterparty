
import UIKit

protocol doneProtocol :AnyObject{
    func doneButton()
    func canselButton()
}

class TableViewControllerAdd: UITableViewController, AddTextProtocol, pictureDelegate, doneKeyboardProtocol {
    func doneButtonKey(_ i: Int) {
        if i == 2 {NewItemDone()
        }else{
            let cell = tableView.cellForRow(at: IndexPath(row: i+1, section: 0))  as! TableViewCellAdd
            cell.textName.becomeFirstResponder()}
    }
    func AddPicture() {
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing = true
        present(imagepicker, animated: true, completion: nil)
    }
    
    func nameEdit(text: String?) {
        if text != nil , text!.trimmingCharacters(in: .whitespaces) != "" {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = false}
    }
    
    weak var delegete : doneProtocol?
    var imagepicker = UIImagePickerController()
    var img :UIImage? = nil
    var index: Int? = nil
    
    @objc func CanselButton(){delegete?.canselButton()}
    @objc func NewItemDone(){
        var cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))  as! TableViewCellAdd
        let name = cell.textName.text!
        cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0))  as! TableViewCellAdd
        let phone = cell.textName.text ?? ""
        cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0))  as! TableViewCellAdd
        let email = cell.textName.text ?? ""
        let cellM = tableView.cellForRow(at: IndexPath(row: 3, section: 0))  as! TableViewCellPhoto
        let image = cellM.imagePeople.image!
        if index == nil{
            insertUser(name, email, phone, image)
        }else{
            updateUser(people[index!].id, name, email, phone, image)
        }
        delegete?.doneButton()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        imagepicker.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(CanselButton))
        tableView.register(TableViewCellAdd.self, forCellReuseIdentifier: "cellAdd")
        tableView.register(TableViewCellPhoto.self, forCellReuseIdentifier: "cellPhoto")
        if index == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(NewItemDone))
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.title = "Новый КонтрАгент"
        }else{
            navigationItem.title = people[index!].Name
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(NewItemDone))
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 4}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPhoto", for: indexPath) as! TableViewCellPhoto
            cell.delegate = self
            if index == nil{
                cell.selectButton.setTitle("Выбрать фото?", for: .normal)
                cell.imagePeople.image = UIImage(named: "picture")
            }else{
                cell.selectButton.setTitle("Изменить фото?", for: .normal)
                cell.imagePeople.image = people[index!].Image
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAdd", for: indexPath) as! TableViewCellAdd
            cell.delegete1 = self
            cell.delegete2 = self
            if index == nil{
                switch indexPath.row{
                case 0:
                    cell.index = 0
                    cell.textName.becomeFirstResponder()
                    cell.nameLabel.text = "Имя:"
                    cell.textName.placeholder = "Введите имя"
                    cell.textName.keyboardType = .default
                    cell.textName.returnKeyType = .next
                case 1:
                    cell.index = 1
                    cell.nameLabel.text = "Телефон:"
                    cell.textName.placeholder = "Введите телефон"
                    //cell.textName.keyboardType = .numberPad
                    cell.textName.returnKeyType = .next
                case 2:
                    cell.index = 2
                    cell.nameLabel.text = "Email:"
                    cell.textName.placeholder = "Введите почту"
                    cell.textName.keyboardType = .emailAddress
                default:
                    break}
            }else{
                switch indexPath.row{
                case 0:
                    cell.index = 0
                    cell.nameLabel.text = "Имя:"
                    cell.textName.text = people[index!].Name
                    cell.textName.keyboardType = .default
                    cell.textName.returnKeyType = .next
                case 1:
                    cell.nameLabel.text = "Телефон:"
                    cell.textName.text = people[index!].Phone
                    //cell.textName.keyboardType = .phonePad
                    cell.textName.returnKeyType = .next
                case 2:
                    cell.nameLabel.text = "Email:"
                    cell.textName.text = people[index!].Email
                    cell.textName.keyboardType = .emailAddress
                default:
                    break}
            }
            return cell
        }
    }
}
extension TableViewControllerAdd : UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            img = image
        }
        let cellM = tableView.cellForRow(at: IndexPath(row: 3, section: 0))  as! TableViewCellPhoto
        cellM.imagePeople.image = img
        dismiss(animated: true, completion: nil)
    }
}


