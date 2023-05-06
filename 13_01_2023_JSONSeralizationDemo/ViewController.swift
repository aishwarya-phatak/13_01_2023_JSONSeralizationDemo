//
//  ViewController.swift
//  13_01_2023_JSONSeralizationDemo
//
//  Created by Vishal Jagtap on 05/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var albumTableView: UITableView!
    var albums : [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       registerWithXIB()
        fetchDataFromApi()
    }
    
    func registerWithXIB(){
       let uiNib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        self.albumTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
    }
    
    func fetchDataFromApi(){
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask = urlSession.dataTask(with: request) { data, response, error in
            let getJSONObjectArray = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            print("========================")
            print(response)
            print("========================")
            for eachJSONObject in getJSONObjectArray{
                let eachAlbumObject = eachJSONObject as! [String : Any]
                let eachAlbumUserId = eachAlbumObject["userId"] as! Int
                let eachAlbumId = eachAlbumObject["id"] as! Int
                let eachAlbumTitle = eachAlbumObject["title"] as! String
                self.albums.append(Album(userId: eachAlbumUserId, id: eachAlbumId, title: eachAlbumTitle))
                print("userid -- \(eachAlbumUserId) eachAlbumId -- \(eachAlbumId) title -- \(eachAlbumTitle)")
            }
        }
        dataTask.resume()
    }
}

