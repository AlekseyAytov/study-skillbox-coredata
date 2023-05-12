//
//  MainViewController.swift
//  20.6 Practice task
//
//  Created by Alex Aytov on 5/10/23.
//

import SnapKit

class ListViewController: UIViewController {
    
    lazy var listTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .green
        table.dataSource = self
        table.separatorStyle = .none
        table.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationItem()
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
        view.backgroundColor  = .white
        view.addSubview(listTableView)
    }
    
    private func setupConstraints() {
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }

    @objc func addTapped() {
        navigationController?.pushViewController(ModifyViewController(), animated: true)
    }
    
    @objc func sortTapped() {
        navigationController?.pushViewController(SortingViewController(), animated: true)
    }

}


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        if (indexPath.row % 2) == 0 {
            reuseCell.backgroundColor = .yellow
        }
        return reuseCell
    }
    
    
}
