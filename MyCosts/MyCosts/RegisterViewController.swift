//
//  RegisterViewController.swift
//  MyCosts
//
//  Created by Luis Felipe on 02/07/2018.
//  Copyright © 2018 Luis Felipe Preto. All rights reserved.
//

import UIKit
import CoreData


class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameCost: UITextField!
    
    @IBOutlet weak var priceCost: UITextField!
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(_ sender: UIButton) {
        saveSpent()
        
    }
    
    //Done editing,keyboard down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Methods
    
    func saveSpent(){
        print(context)
        let custo = Cost(context: context)
        
        let nameGasto = nameCost.text ?? ""
        
        let preco = Double(priceCost.text!.replacingOccurrences(of: ",", with: ".")) ?? 0
        
        
        if nameGasto.isEmpty || preco <= 0.0 {
            show(messege: "Preencha os campos corretamente")
            
            
        } else {
            custo.name = nameGasto
            custo.price = preco
            
            do {
                try context.save()
                nameCost.text = ""
                priceCost.text = ""
                show(messege: "Gasto cadastrado com sucesso")
                
            } catch {
                NSLog(error.localizedDescription)
                show(messege: "Erro ao cadastrar o gasto")
            }
        }
        
    }
    
    
    
    

}
