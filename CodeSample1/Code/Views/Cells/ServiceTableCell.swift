//
//  ServiceTableCell.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import UIKit

class ServiceTableCell: UITableViewCell {
    fileprivate var title: UILabel!
    fileprivate var artist: UILabel!
    fileprivate var country: UILabel!
    fileprivate var company: UILabel!
    fileprivate var price: UILabel!
    fileprivate var year: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        title = UILabel()
        artist = UILabel()
        country = UILabel()
        company = UILabel()
        price = UILabel()
        year = UILabel()
       
        [title, artist, country, company, price, year].forEach {
            if let label = $0 {
                contentView.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            }
        }
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        country.topAnchor.constraint(equalTo: artist.bottomAnchor, constant: 4).isActive = true
        company.topAnchor.constraint(equalTo: country.bottomAnchor, constant: 4).isActive = true
        price.topAnchor.constraint(equalTo: company.bottomAnchor, constant: 4).isActive = true
        year.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 4).isActive = true
    }
    
    func update(model: ServiceItemModel) {
        title?.text = model.title
        artist?.text = model.artist
        country?.text = model.country
        company?.text = model.company
        price?.text = "$\(model.price)"
        year?.text = "\(model.year)"
    }
}
