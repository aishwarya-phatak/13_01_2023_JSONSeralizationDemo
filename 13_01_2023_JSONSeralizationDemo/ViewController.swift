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
        initViews()
        registerWithXIB()
        fetchDataFromApi()
    }
    func initViews(){
        self.albumTableView.dataSource = self
        self.albumTableView.delegate = self
    }
    
    func registerWithXIB(){
       let uiNib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        self.albumTableView.register(uiNib, forCellReuseIdentifier: "AlbumTableViewCell")
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
            
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
     let albumTableViewCell =   self.albumTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell
        
        //albumTableViewCell?.userIdlabel.text =   String(albums[indexPath.row].userId)
        
        albumTableViewCell?.userIdlabel.text = "1"
        albumTableViewCell?.idLabel.text = String(albums[indexPath.row].id)
        albumTableViewCell?.titleLabel.text = albums[indexPath.row].title
        
        return albumTableViewCell!
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    
}
