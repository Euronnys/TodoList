//
//  ViewController.swift
//  TodoList1
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tarefas: [String] = []
    let keylista="listadetarefas"
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       tableview.dataSource = self
        if let lista = UserDefaults.standard.value(forKey: keylista) as? [String]{
            tarefas.append(contentsOf: lista)
        }
    }


    @IBAction func addtask(_ sender: Any) {
    let alert = UIAlertController(title: "Nova Tarefa", message: "Adicione uma nova tarefa", preferredStyle: .alert)
        let actionSalve =  UIAlertAction(title: "Salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first,let texto = textField.text{
                self.tarefas.append(texto)
                self.tableview.reloadData()
                UserDefaults.standard.set(self.tarefas, forKey: self.keylista)
            }
        }
        let actioncancel = UIAlertAction(title: "Cancelar", style: .cancel) { (<#UIAlertAction#>) in
            print("Clicou em cancelar")
        }
        
        
        
        alert.addAction(actionSalve)
        alert.addAction(actioncancel)
        alert.addTextField()
        
        
        
        
    present(alert,animated: true)
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tarefas[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.tarefas,forKey: self.keylista)
            
        }
    }
}
