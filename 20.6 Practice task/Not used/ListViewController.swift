//
//  MainViewController.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import SnapKit
import CoreData

class ListViewController: UIViewController {
    
    var artistsStorage = ArtistInfoStorage.shared
    
    var settingsStorage = SettingsStorage()
    
    private let defaultSettings = Settings(sortingField: .lastName, ascending: true)
    
    var artists: [Artist]! {
        // сортировка в зависимости от настроек
        didSet {
            switch settings.sortingField {
            case .lastName:
                
                switch settings.ascending {
                case true:
                    artists.sort { $0.lastName ?? "" < $1.lastName ?? "" }
                case false:
                    artists.sort { $0.lastName ?? "" > $1.lastName ?? "" }
                }
            case .firstName:
                
                switch settings.ascending {
                case true:
                    artists.sort { $0.firstName ?? "" < $1.firstName ?? "" }
                case false:
                    artists.sort { $0.firstName ?? "" > $1.firstName ?? "" }
                }
            default:
                break
            }
        }
    }
    
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
        setArtists()
    }
    
    // метод используется для наполнения свойства artists после создания экземпляра класса
    func setArtists() {
        artists = artistsStorage.fetchObjects()
    }
    
    func setSettings() {
        settings = settingsStorage.loadSettings() ?? defaultSettings
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Заголовок сцены"
        navigationItem.backButtonTitle = "Назад"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))

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
            let newArtist = self.artistsStorage.insertNewObject(newArtist: artist, birth: birth)
            self.artists.append(newArtist)
            self.listTableView.reloadData()
        }
        navigationController?.pushViewController(addScreen, animated: true)
    }
    
    @objc func sortTapped() {
        let sortScreen = SortSettingTableViewController()
        sortScreen.sortingSettings = self.settings
        sortScreen.doAfterEdit = { [unowned self] setttt in
            self.settings = setttt
            self.artists = self.artists
            self.listTableView.reloadData()
        }
        navigationController?.pushViewController(sortScreen, animated: true)
    }
}

// MARK: - DataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        switch settings.sortingField {
        case .lastName:
            reuseCell.name = artists[indexPath.row].lastName! + " " + artists[indexPath.row].firstName!
        case .firstName:
            reuseCell.name = artists[indexPath.row].firstName! + " " + artists[indexPath.row].lastName!
        default:
            break
        }
        reuseCell.dob     = dateFormatter.string(from: artists[indexPath.row].dob!)
        reuseCell.country = artists[indexPath.row].country
        return reuseCell
    }
    
    
}

// MARK: - Delegate

extension ListViewController: UITableViewDelegate {
    
    // редактирование при селекте
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currentArtist = artists[indexPath.row]
        let editScreen = ModifyViewController()
        
        editScreen.artistFields[.firstName] = currentArtist.firstName
        editScreen.artistFields[.lastName]  = currentArtist.lastName
        editScreen.artistFields[.gender]    = currentArtist.gender
        editScreen.artistFields[.country]   = currentArtist.country
        editScreen.artistFields[.city]      = currentArtist.city
        editScreen.artistDob                = currentArtist.dob
        editScreen.setfields()
        
        editScreen.doAfterEdit = { [unowned self] artist, birth in
            currentArtist.firstName = artist[.firstName]
            currentArtist.lastName  = artist[.lastName]
            currentArtist.gender    = artist[.gender]
            currentArtist.country   = artist[.country]
            currentArtist.city      = artist[.city]
            currentArtist.dob       = birth
            artistsStorage.saveContext()
            self.listTableView.reloadData()
        }
        
        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // удаление при свайпе влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteArtist = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let currentArtist = self.artists[indexPath.row]
            self.artistsStorage.deleteOblect(artist: currentArtist)
            self.artists.remove(at: indexPath.row)
            self.listTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteArtist])
    }
}
