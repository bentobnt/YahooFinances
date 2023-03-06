//
//  ContentView.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

class ContentView: UIView {
    // MARK: - Properties
    var activityIndicatorStyle: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large
    var isLoading: Bool = false {
        didSet { updateLoadingState() }
    }
    var skipFadeOnFirstLoading: Bool = true

    // MARK: - Views
    private let activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    }()

    private let viewContent: UIView = {
        return UIView()
    }()

    private let viewLoading: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrided method
    override func addSubview(_ view: UIView) {
        viewContent.addSubview(view)
    }

    // MARK: - Private methods
    private func configureLoadingView() {
        activityIndicatorView.color = .appPrimaryColor

        viewLoading.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
    }

    private func setupViews() {
        configureLoadingView()

        super.addSubview(viewContent)
        super.addSubview(viewLoading)

        viewContent.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })

        viewLoading.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }

    private func updateLoadingState() {
        if isLoading {
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicatorView.startAnimating()
            }
            if skipFadeOnFirstLoading {
                skipFadeOnFirstLoading = false
                viewContent.isHidden = true
                viewContent.alpha = 0
                viewLoading.isHidden = false
                viewLoading.alpha = 1
            } else {
                viewContent.fadeOut(completion: { [weak self] in
                    self?.viewLoading.fadeIn()
                })
            }
        } else {
            viewLoading.fadeOut(completion: { [weak self] in
                self?.activityIndicatorView.stopAnimating()
                self?.viewContent.fadeIn()
            })
        }
    }
}
