//
//  ActiveCell.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import UIKit

class ActiveCell: UITableViewCell {
    // MARK: - Properties
    private var viewModel: ActiveCellModel! {
        didSet { loadData() }
    }

    // MARK: - Views
    let labelDate: UILabel = {
        let label = UILabel();
        label.font = .primary(ofSize: .regular)
        label.textAlignment = .center
        return label
    }()

    let labelOpenValue: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
        return label
    }()

    let labelVariationD1: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
        return label
    }()

    let labelVariationFirstDate: UILabel = {
        let label = UILabel();
        label.font = .primaryBold(ofSize: .regular)
        label.textAlignment = .center
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

    // MARK: - Public methods
    func configure(with viewModel: ActiveCellModel) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods
    private func loadData() {
        labelDate.text = viewModel.data
        labelOpenValue.text = viewModel.openValue
        labelVariationD1.text = viewModel.variationD1
        labelVariationFirstDate.text = viewModel.variationFirstDate

        setupColors()
    }

    private func setupColors() {
        labelVariationD1.textColor = viewModel.variationD1.contains("-") ? UIColor.red : .appGreenColor
        labelVariationFirstDate.textColor = viewModel.variationFirstDate.contains("-") ? UIColor.red : .appGreenColor
    }

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
            make.left.equalTo(labelDate.snp.right).offset(20)
            make.bottom.equalToSuperview().inset(5)
        }

        labelVariationD1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.left.equalTo(labelOpenValue.snp.right).offset(20)
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

