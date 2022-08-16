//
//  Home.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 16/07/2022.
//

import UIKit
import SwiftUI
import SnapKit
import NVActivityIndicatorView

class HomeVC: BaseViewController {
    
    //    enum Section: Hashable {
    //        case header
    //        case main
    //    }
    //
    //    enum SectionItems: Hashable {
    //        case header([Card])
    //        case main([Card])
    //    }
    //
    //
    //
    //    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SectionItems>
    //    typealias DataSource = UITableViewDiffableDataSource<Section, SectionItems>
    //    private lazy var dataSource = setupDataSource()
    
    enum CellStyles {
        case image
        case checklist
        case textOnly
    }
    private var style: CellStyles = .checklist
    private var viewModel : HomeViewModel = HomeViewModel()
    private let tableView = UITableView()
    private let searchControleller = UISearchController()
    
    
    
    override func setupUI() {
        setupLayout()
        setupTableView()
        setupNavigationBar()
    }
    
    override func setupData() {
        
    }
    
    override func bindingToView() {
        viewModel.$isLoading
            .sink { isLoading in
                if isLoading {
                    Task {
                        await self.startAnimating()
                    }
                } else {
                    Task {
                        await self.stopAnimating()
                    }
                }
            }
            .store(in: &subscriptions)
        
        
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.bringSubviewToFront(viewIndicator)
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchControleller
        navigationItem.hidesSearchBarWhenScrolling = false
        searchControleller.hidesNavigationBarDuringPresentation = false
        searchControleller.obscuresBackgroundDuringPresentation = false
        searchControleller.searchBar.searchTextField.publisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { (str) in
                Task {
                    self.viewModel.data = []
                    await self.viewModel.fetch(str ?? "")
                    self.tableView.reloadData()
                    self.tableView.setNeedsLayout()
                    self.tableView.layoutIfNeeded()
                    self.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)

        searchControleller.searchBar.showsBookmarkButton = true
        

        
        let options = UIBarButtonItem(title: "", image: .init(systemName: "ellipsis"), primaryAction: nil, menu: setupOptionsMenu())
        
        navigationItem.rightBarButtonItems = [options]
    }
    
    func setupOptionsMenu() -> UIMenu {
        return UIMenu(children: [
            UIAction(title: "Image Only", image: UIImage(systemName: "photo"), handler: { (_) in
                self.tapOnImage()
            }),
            UIAction(title: "Check list", image: UIImage(systemName: "list.bullet.rectangle"), handler: { (_) in
                self.tapOnChecklist()
            }),
            UIAction(title: "Text Only", image: UIImage(systemName: "doc.plaintext"), handler: { (_) in
                self.tapOnTextOnly()
            })
        ])
    }

    func tapOnImage() {
        style = .image
        Task {
            await startAnimating()
            tableView.reloadData()
            if !viewModel.data.isEmpty {
                scrollToFirstRow()
            }
            await stopAnimating()
        }
    }
    
    func tapOnChecklist() {
        style = .checklist
        Task {
            await startAnimating()
            tableView.reloadData()
            if !viewModel.data.isEmpty {
                scrollToFirstRow()
            }
            await stopAnimating()
        }
    }
    
    func tapOnTextOnly() {
        style = .textOnly
        Task {
            await startAnimating()
            tableView.reloadData()
            if !viewModel.data.isEmpty {
                scrollToFirstRow()
            }
            await stopAnimating()
        }
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
      }
    
    private func setupTableView() {
        tableView.register(CheckListCardCell.self)
        tableView.register(ImageCardCell.self)
        tableView.register(TextOnlyCardCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0.0
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch style {
        case .checklist:
            return 50
        case .image:
            return 450
        case .textOnly:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch style {
        case .image:
            let cell = tableView.reuse(ImageCardCell.self,for: indexPath)
            cell.selectionStyle = .none
            let card = viewModel.data[indexPath.row]
            cell.cardVM = CardViewModel(card: card)
            cell.clicked = {
                self.viewModel.data[indexPath.row].isFlipped.toggle()
                cell.flipImage()
            }
            return cell
        case .checklist:
            let cell = tableView.reuse(CheckListCardCell.self,for: indexPath)
            cell.selectionStyle = .none
            let card = viewModel.data[indexPath.row]
            cell.cardVM = CheckListCardViewModel(card: card)
            if indexPath.row % 2 == 0 {
                cell.containerView.backgroundColor = .white
            } else {
                cell.containerView.backgroundColor = .backgroundColor
            }
            return cell
        case .textOnly:
            let cell = tableView.reuse(TextOnlyCardCell.self, for: indexPath)
            cell.selectionStyle = .none
            let card = viewModel.data[indexPath.row]
            cell.cardVM = TextOnlyCardViewModel(card: card)
            return cell
        }
    }
    
    
    
}

