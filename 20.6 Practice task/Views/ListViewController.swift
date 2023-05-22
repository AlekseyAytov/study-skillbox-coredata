//
//  MainViewController.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import SnapKit

class ListViewController: UIViewController {
    
    var artistsStorage: ArtistInfoStorageProtocol = ArtistInfoStorage()
    
    var settingsStorage = SettingsStorage()
    
    var artists: [ArtistProtocol] = [] {
        didSet {
            switch settings.sortingField{
            case .lastName:
                
                switch settings.sortingMethod {
                case .alphabetical:
                    artists.sort { $0.lastName < $1.lastName }
                case .reverseAlphabetical:
                    artists.sort { $0.lastName > $1.lastName }
                }
            case .firstname:
                
                switch settings.sortingMethod {
                case .alphabetical:
                    artists.sort { $0.firstName < $1.firstName }
                case .reverseAlphabetical:
                    artists.sort { $0.firstName > $1.firstName }
                }
            }
        }
    }
    
    var settings: Settings! {
        willSet {
            settingsStorage.saveSettings(settings: newValue)
        }
    }
    
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
        artists = artistsStorage.loadArtists()
    }
    
    func setSettings() {
        settings = settingsStorage.loadSettings() ?? Settings(sortingField: .lastName, sortingMethod: .alphabetical)
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
        addScreen.doAfterEdit = { [unowned self] artist in
            self.artists.append(artist)
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


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        switch settings.sortingField {
        case .lastName:
            reuseCell.name = artists[indexPath.row].lastName + " " + artists[indexPath.row].firstName
        case .firstname:
            reuseCell.name = artists[indexPath.row].firstName + " " + artists[indexPath.row].lastName
        }
        reuseCell.dob     = artists[indexPath.row].dob
        reuseCell.country = artists[indexPath.row].country
        return reuseCell
    }
    
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentArtist = artists[indexPath.row]
        let editScreen = ModifyViewController()
        editScreen.artist = currentArtist
        editScreen.setfields()
        editScreen.doAfterEdit = { [unowned self] artist in
            self.artists.remove(at: indexPath.row)
            self.artists.append(artist)
            self.listTableView.reloadData()
            
        }
        navigationController?.pushViewController(editScreen, animated: true)
    }
}