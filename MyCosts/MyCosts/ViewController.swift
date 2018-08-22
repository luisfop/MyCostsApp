//
//  ViewController.swift
//  MyCosts
//
//  Created by Luis Felipe on 02/07/2018.
//  Copyright © 2018 Luis Felipe Preto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    var costs : [Cost] = [] {
        
        didSet {
            textLabel.text = String(format: "R$: %0.2f", locale: Locale.current, total)
        }
    }
    
    var total : Double {
        let value = costs.reduce(0.0) { (amount, cost) -> Double in
            return amount + cost.price
        }
        return value
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        showCost()
    }
    
    
    func showCost() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cost")
        
        do{
            let result = try context.fetch(fetchRequest)
            let totalCost = (result as? [Cost]) ?? []
            
            
            costs = totalCost
            
            
            tableView.reloadData()
            
        }catch{
            NSLog(error.localizedDescription)
            show(messege: "Erro ao trazer os gastos")
            
        }
        
        
    }
    
    func removeCost(at index: Int) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let cost = costs[index]
        
        context.delete(cost)
        do{
            try context.save()
            
        }catch{
            show(messege: "Nao foi possivel deletar o gasto")
            NSLog(error.localizedDescription)
        }
        
        return true
    }
    
}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cost = costs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cost.name
        cell.detailTextLabel?.text = String(format: "R$: %0.2f ", locale: Locale.current, cost.price)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if removeCost(at: indexPath.row){
                costs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}



