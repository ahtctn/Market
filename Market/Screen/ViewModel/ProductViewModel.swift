//
//  ProductViewModel.swift
//  Market
//
//  Created by Ahmet Ali ÇETİN on 27.03.2023.
//

import UIKit

final class ProductViewModel {
    
    var products: [ProductModel] = []
    var eventHandler: ((_ event: Event) -> Void)? ///Data binding closure
    
    func fetchProducts() {

        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case dataLoaded
        case stopLoading
        case error(_ error: Error?)
    }

}
