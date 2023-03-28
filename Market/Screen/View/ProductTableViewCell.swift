//
//  ProductTableViewCell.swift
//  Market
//
//  Created by Ahmet Ali ÇETİN on 28.03.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    var product: ProductModel? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productViewCustomization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        rateButton.setTitle("\(String(describing: product.rating.rate))", for: .normal)
        descriptionLabel.text = product.description
        priceLabel.text = "\(String(describing: product.price)) ₺"
        productImageView.setImage(with: product.image)
    }
    
    private func productViewCustomization() {
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        self.productBackgroundView.backgroundColor = .systemGray6
    }
    
    //ACTION
    @IBAction func buyButtonTapped(_ button: UIButton) {
        print("Buy button tapped in here")
    }
    
}
