//
//  SortSettingTableViewController.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/15/23.
//

import UIKit

class SortSettingTableViewController: UITableViewController {
    
    var sortingSettings: Settings?
    
    private let sortingBy: [ArtistProperties] = [.firstName, .lastName]
    
    private let ascendingOrder: [Bool] = [true, false]
    
    var doAfterEdit: ((Settings) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Сортировка"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))

        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveTapped() {
        doAfterEdit?(sortingSettings!)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = UIView()
        let sectionLabel = UILabel()
        sectionHeader.addSubview(sectionLabel)
        
        sectionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(35)
        }
        sectionLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        switch section {
        case 0:
            sectionLabel.text = "Sort order"
        case 1:
            sectionLabel.text = "Display order"
        default:
            break
        }
        return sectionHeader
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ascendingOrder.count
        case 1:
            return sortingBy.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ?? UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            
            let sortMethodElement = ascendingOrder[indexPath.row]
            
            switch sortMethodElement {
            case true:
                configuration.text = "alphabetical"
                configuration.secondaryText = "alphabetical"
            case false:
                configuration.text = "reverseAlphabetical"
                configuration.secondaryText = "reverseAlphabetical"
            }
            
            if sortMethodElement == sortingSettings!.ascending {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        case 1:
            let sortFieldElement = sortingBy[indexPath.row]
            
            switch sortFieldElement {
            case .lastName:
                configuration.text = "lastName"
                configuration.secondaryText = "lastName"
            case .firstName:
                configuration.text = "firstName"
                configuration.secondaryText = "firstName"
            default:
                break
            }
            
            if sortFieldElement == sortingSettings!.sortingField {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        default:
            break
        }
        
        cell.contentConfiguration = configuration
        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            sortingSettings!.ascending = ascendingOrder[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        case 1:
            sortingSettings!.sortingField = sortingBy[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        default:
            break
        }
    }
}
