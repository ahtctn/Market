//
//  ViewController.swift
//  Market
//
//  Created by Ahmet Ali ÇETİN on 27.03.2023.
//

import UIKit

class ProductListViewController: UIViewController {

    ///OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    ///PROPERTIES
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProductListViewController {
    
    func configuration() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Cell.id)
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                ///Indicator show
                print("Product Loading")
                break
            case .stopLoading :
                ///Indicator Hide
                print("Stop loading")
                break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .error(let error):
                print(error?.localizedDescription as Any)
            }
            
        }
    }
    
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.products.count)
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = viewModel.products[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.id, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

