//
//  HomeViewController.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: HomeViewModel
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.homeViewIdentifier.rawValue, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureObservables()
        viewModel.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.largeTitles(enabled: false)
    }
    
    // MARK: Private methods
    private func configureNavigationBar() {
        configureNavigationBar(Strings.homeTitle.localized())
    }
    
    private func configureTableView() {
        tableView.register(HomeTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.dataSource.bind(to: tableView.rx.items) { [weak self] (_, row, model) in
            guard let self = self else { return UITableViewCell() }
            let indexPath = IndexPath(row: row, section: 0)
            return self.configureTableViewCell(index: indexPath, model: model)
            }.disposed(by: disposeBag)
    }
    
    private func configureObservables() {
        viewModel.errorRelay.bind { [weak self] error in
            guard let self = self else { return }
            self.showSnackError(error)
        }.disposed(by: disposeBag)
    }
    
    private func configureTableViewCell(index: IndexPath, model: Any) -> UITableViewCell {
        if let newModel = model as? HomeTableViewCell.UIModel {
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: index) as? HomeTableViewCell {
                cell.configureView(newModel)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
