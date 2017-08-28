//
//  ViewController.swift
//  Exemplo1_Rest_iOS_Swift
//
//  Created by Usuário Convidado on 21/08/17.
//  Copyright © 2017 fernando. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var minhaImagem: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var qtd: UILabel!
    @IBOutlet weak var exibir: UIButton!
    
    var session: URLSession?
    var quantidade = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cria uma configuraçäo de sessäo default
        let config = URLSessionConfiguration.default
        
        //Cria uma configuraçäo default - 2017
        session = URLSession(configuration: config)
        
        //Acesso a API feita em PHP criada em meu servidor na Godaddy (API AGESSANDRO, QUE NÁO ESTÁ MAIS FUNCIONANDO)
        //let url = URL(string: https://www.scarpioni.com/webservices/local.php/?id=1")
        //Acesso a API feita em Node.JS criada no Heroku
        let url = URL(string: "https://parks-api.herokuapp.com/parks/577024e4a44821110001ee93")
        let task = session!.dataTask(with: url!){(data, response, error) in
            //açoes que serao efetuadas quando a execucao da task se completa 
            //let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print(texto!)
            if let nPq = self.retornarNomePQ(data: data!){
                DispatchQueue.main.async {
                        self.local.text = nPq
                        self.qtd.text = "Qtd de chaves no Json é \(self.quantidade)"
                }
            }
        }
        //disparo da execucao da task
        task.resume()
    }
    
    func retornarNomePQ(data: Data) -> String? {
        var resposta:String?=nil
        do{
            //faz a leitura dos valores do Json, NSJSONSerialization faz o Parser do Json
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            //cria uma string a partir da chave "nome
            if let nomeParque = json["nome"] as? String{
                resposta = nomeParque
                quantidade = json.count //apenas um exemplo para contar a qtd de chaves do json
            }
        } catch let error as NSError{
            return "Falha ao carregar :\(error.localizedDescription)"
        }
        return resposta
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

