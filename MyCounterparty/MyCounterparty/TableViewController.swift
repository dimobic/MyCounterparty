
import UIKit

class TableViewController: UITableViewController, doneProtocol {
    func doneButton() {
        navigationController?.popViewController(animated: true)
        loadUsers()
        tableView.reloadData()
    }
    func canselButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func NewItem(){
        let viewController = TableViewControllerAdd()
        viewController.delegete = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "КонтрАгенты"
        view.backgroundColor = .systemBackground
        createTable()
        loadUsers()
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(NewItem))
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = TableViewControllerAdd()
        viewController.index = indexPath.row
        viewController.delegete = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = people[indexPath.row].Name
        cell.phoneLabel.text = people[indexPath.row].Phone
        cell.imagePeople.image = people[indexPath.row].Image
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{return "Удалить"}
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {return false}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        deleteUser(people[indexPath.row].id)
        people.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
