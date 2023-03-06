//
//  HomeView.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

class HomeView: UIView {
    // MARK: - Views
    let viewContent: ContentView = {
        let view = ContentView()
        view.backgroundColor = .clear
        return view
    }()

    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .appSecondaryColor
        return tableView
    }()

    private var buttonFlutter: UIButton = {
        let button = UIButton()
        button.setTitle("Ver gráfico no Flutter", for: .normal)
        button.backgroundColor = .appPrimaryColor
        button.addTarget(target, action: #selector(didTapGoToFlutterButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    let viewModel: HomeViewModel

    // MARK: - Closures
    @objc var didTapFlutterButton: () -> Void = { }

    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupTableView()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80;
        tableView.rowHeight = UITableView.automaticDimension;

        tableView.register(ActiveCell.self,
                           forCellReuseIdentifier: ActiveCell.uid());
        tableView.register(HeaderCell.self,
                           forCellReuseIdentifier: HeaderCell.uid());
    }

    private func cellActiveWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let uid = ActiveCell.uid();
        let cell = tableView.dequeueReusableCell(withIdentifier: uid) as! ActiveCell;

        if let active = viewModel.response?[indexPath.row - 1],
           let firstActive = viewModel.response?[0] {
           let dayAgoActive = indexPath.row > 1 ? viewModel.response?[indexPath.row - 2] : nil
           let viewModel = ActiveCellModel(active: active,
                                            firstDateActive: firstActive,
                                            dayAgoActive: dayAgoActive)
            cell.configure(with: viewModel)
        }

        return cell;
    }

    private func cellHeaderWithIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        let uid = HeaderCell.uid();
        let cell = tableView.dequeueReusableCell(withIdentifier: uid) as! HeaderCell;

        return cell;
    }

    // MARK: - Public methods
    @objc func didTapGoToFlutterButton() {
        didTapFlutterButton()
    }
}

// MARK: - Create view
extension HomeView {
    private func setupView() {
        addSubview(viewContent)

        viewContent.addSubview(tableView)
        viewContent.addSubview(buttonFlutter)

        viewContent.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }

        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        buttonFlutter.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.right.bottom.left.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Table view delegate methods
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewActiveName = UIView(frame: .zero)
        let labelActiveName = UILabel(frame: .zero)
        labelActiveName.text = "Apple Inc. (APPL)"
        labelActiveName.font = .primary(ofSize: .big)
        labelActiveName.textColor = .appPrimaryColor

        viewActiveName.addSubview(labelActiveName)

        viewActiveName.snp.makeConstraints { make in
            make.height.equalTo(70)
        }

        labelActiveName.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        return viewActiveName
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.response?.count ?? 0 + 1)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return cellHeaderWithIndexPath(indexPath)
        }

        return cellActiveWithIndexPath(indexPath)
    }
}
