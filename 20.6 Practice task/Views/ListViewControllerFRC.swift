//
//  MainViewController.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import SnapKit
import CoreData

class ListViewControllerFRC: UIViewController {
    
    let artistsStorage = ArtistInfoStorageFRC.shared
    
    var fetchController: NSFetchedResultsController<Artist>!
    
    let settingsStorage = SettingsStorage()
    
    private let defaultSettings = Settings(sortingField: .lastName, ascending: true)
        
    var settings: Settings! {
        willSet {
            settingsStorage.saveSettings(settings: newValue)
        }
    }
    
    // для отображения даты в ячейке
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    lazy var listTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationItem()
        setSettings()
        setFetchController()
    }
    
    private func setSettings() {
        settings = settingsStorage.loadSettings() ?? defaultSettings
    }
    
    private func setFetchController() {
        fetchController = artistsStorage.getFetchController(sortingKey: settings.sortingField.rawValue, ascending: settings.ascending )
        fetchController.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Список исполнителей"
        navigationItem.backButtonTitle = "Назад"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let sortButton = UIBarButtonItem(title: "Сортировка", style: .plain, target: self, action: #selector(sortTapped))

        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = sortButton
    }
    
    private func setupViews() {
        view.addSubview(listTableView)
    }
    
    private func setupConstraints() {
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview()
        }
    }

    @objc func addTapped() {
        let addScreen = ModifyViewController()
        addScreen.doAfterEdit = { [unowned self] artist, birth in
            self.artistsStorage.insertNewObject(newArtist: artist, birth: birth)
        }
        navigationController?.pushViewController(addScreen, animated: true)
    }
    
    @objc func sortTapped() {
        let sortScreen = SortSettingTableViewController()
        sortScreen.sortingSettings = self.settings
        sortScreen.doAfterEdit = { [unowned self] setttt in
            self.settings = setttt
            self.setFetchController()
            self.listTableView.reloadData()
        }
        navigationController?.pushViewController(sortScreen, animated: true)
    }
}

// MARK: - DataSource

extension ListViewControllerFRC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currSection = fetchController.sections?[section] {
            return currSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath)
        configure(cell: &reuseCell, for: indexPath)
        return reuseCell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        let cell = cell as! ListTableViewCell
        let object = fetchController.object(at: indexPath)
        
        switch settings.sortingField {
        case .lastName:
            cell.name = (object.lastName ?? "") + " " + (object.firstName ?? "")
        case .firstName:
            cell.name = (object.firstName ?? "") + " " + (object.lastName ?? "")
        default:
            break
        }
        cell.dob     = dateFormatter.string(from: object.dob!)
        cell.country = object.country
    }
}

// MARK: - Delegate

extension ListViewControllerFRC: UITableViewDelegate {
    
    // редактирование при селекте
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currentArtist = fetchController.object(at: indexPath)
        let editScreen = ModifyViewController()

        editScreen.artistFields[.firstName] = currentArtist.firstName
        editScreen.artistFields[.lastName]  = currentArtist.lastName
        editScreen.artistFields[.gender]    = currentArtist.gender
        editScreen.artistFields[.country]   = currentArtist.country
        editScreen.artistFields[.city]      = currentArtist.city
        editScreen.artistDob                = currentArtist.dob
        editScreen.setfields()

        editScreen.doAfterEdit = { [weak self] artist, birth in
            currentArtist.firstName = artist[.firstName]
            currentArtist.lastName  = artist[.lastName]
            currentArtist.gender    = artist[.gender]
            currentArtist.country   = artist[.country]
            currentArtist.city      = artist[.city]
            currentArtist.dob       = birth
            self!.artistsStorage.saveContext()
        }

        navigationController?.pushViewController(editScreen, animated: true)
    }

    // удаление при свайпе влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteArtist = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            let object = self.fetchController.object(at: indexPath)
            self.artistsStorage.deleteOblect(artist: object)
        }

        return UISwipeActionsConfiguration(actions: [deleteArtist])
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ListViewControllerFRC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        listTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        listTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            listTableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { return }
            listTableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            if let indexPath = indexPath {
                var cell = self.listTableView.cellForRow(at: indexPath)!
                configure(cell: &cell, for: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                listTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath {
                listTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
}
