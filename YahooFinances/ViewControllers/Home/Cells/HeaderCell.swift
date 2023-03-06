//
//  HeaderCell.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 05/03/23.
//

import UIKit

class HeaderCell: UITableViewCell {
    // MARK: - Views
    let labelDate: UILabel = {
        let label = UILabel();
        label.font = .primary(ofSize: .regular)
        label.textAlignment = .center
        label.text = "Data"
        label.numberOfLines = 0
        return label
    }()

    let labelOpenValue: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
        label.text = "Valor"
        label.numberOfLines = 0
        return label
    }()

    let labelVariationD1: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
        label.text = "Variação D - 1"
        label.numberOfLines = 0
        return label
    }()

    let labelVariationFirstDate: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
        label.text = "Variação primeira data"
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);

        setupAppearance()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupAppearance() {
        selectionStyle = .none
    }

    private func setupViews() {
        self.contentView.addSubview(labelDate)
        self.contentView.addSubview(labelOpenValue)
        self.contentView.addSubview(labelVariationD1)
        self.contentView.addSubview(labelVariationFirstDate)

        labelDate.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }

        labelOpenValue.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(labelDate.snp.right).offset(55)
            make.bottom.equalToSuperview().inset(5)
        }

        labelVariationD1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.left.equalTo(labelOpenValue.snp.right).offset(55)
            make.bottom.equalToSuperview().inset(5)
        }

        labelVariationFirstDate.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.left.equalTo(labelVariationD1.snp.right).offset(20)
            make.right.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
}

