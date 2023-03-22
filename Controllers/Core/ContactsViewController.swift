//
//  ContactsViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 02.12.22.
//

import UIKit

class ContactsViewController: UIViewController {
    
    public var data = TableModel(sections:[
            SectionModel(title: "B", cells: [
                ContactsTableCollectionViewCellModel(fullName: "Beka Buturishvili", phoneNumber: "571 92 76 67"),
            ]),
        ]
    )
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        return tableView
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ContactsCollectionViewCell.self, forCellWithReuseIdentifier: ContactsCollectionViewCell.identifier)
        collectionView.register(CollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderReusableView.identifier)
        collectionView.isHidden = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(tableView)
        view.addSubview(collectionView)
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    private func configureNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addContactButtonHasPressed))
        let viewButton =  UIBarButtonItem(image: UIImage(systemName: "circle.grid.3x3.fill"), style: .plain, target: self, action: #selector(swapBetweenTableViewAndCollectionView))
        navigationItem.rightBarButtonItems = [addButton, viewButton]
        navigationItem.title = "Contacts"
    }
    
    @objc private func swapBetweenTableViewAndCollectionView(_ sender: UIBarButtonItem) {
            if(collectionView.isHidden) {
                tableView.isHidden = true
                navigationItem.rightBarButtonItems?.last?.image = UIImage(systemName: "text.justify")
                collectionView.isHidden = false
            }else {
                collectionView.isHidden = true
                navigationItem.rightBarButtonItems?.last?.image = UIImage(systemName: "circle.grid.3x3.fill")
                tableView.isHidden = false
            }
    }
    
    @objc private func addContactButtonHasPressed(_ sender: UIBarButtonItem) {
        let vc = AddContactViewController()
        vc.data = data
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func deleteCell(at indexPath: IndexPath) {
        if data.sections[indexPath.section].cells.count > 1 {
            let index = indexPath.row
            data.sections[indexPath.section].cells.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            collectionView.deleteItems(at: [indexPath])
        } else {
            let index = indexPath.section
            data.sections.remove(at: index)
            tableView.deleteSections(IndexSet(integer: index), with: .automatic)
            collectionView.deleteSections(IndexSet(integer: index))
        }
    }
    
    @objc private func didLongPressToDelete(_ sender: UILongPressGestureRecognizer) {
        if(sender.delaysTouchesEnded) {
            let location = sender.location(in: collectionView)
            guard let indexPath = collectionView.indexPathForItem(at: location) else {return}
            let vc = UIAlertController(title: "Delete Contact", message: "Are you sure that you want to delete this contact?", preferredStyle: .actionSheet)
            vc.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.deleteCell(at: indexPath)
            }))
            vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(vc, animated: true)
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as?
                ContactsTableViewCell else {return UITableViewCell()}
        cell.configure(with: data.sections[indexPath.section].cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ContactViewController()
        let model = data.sections[indexPath.section].cells[indexPath.row]
        vc.configure(with: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { [unowned self] _,_,_ in
                deleteCell(at: indexPath)
            }
        )
        let config = UISwipeActionsConfiguration(actions: [delete])
        return config
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsCollectionViewCell.identifier, for: indexPath) as? ContactsCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: data.sections[indexPath.section].cells[indexPath.row])
        cell.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didLongPressToDelete)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CollectionHeaderReusableView.identifier,
                for: indexPath
            )
            
            if let headerView = header as? CollectionHeaderReusableView {
                headerView.configure(with: CollectionHeaderReusableViewModel(title: data.sections[indexPath.section].title))
            }
            return header
        }else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = ContactViewController()
        let model = data.sections[indexPath.section].cells[indexPath.row]
        vc.configure(with: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactsViewController: AddContactViewControllerDelegate {
    func AddContactViewControllerWillDismiss(_ sender: AddContactViewController, withData data: TableModel) {
        self.data = data
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = 2 * Constants.spacing
        let itemSpacing = (Constants.itemCount - 1) * Constants.spacing
        let spaceWidth = collectionView.frame.width - insets - itemSpacing
        let itemSize = spaceWidth / Constants.itemCount
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0,
            left: Constants.spacing,
            bottom: 0,
            right: Constants.spacing
        )
    }
}

extension ContactsViewController {
    struct Constants {
        static let itemCount: CGFloat = 3
        static let spacing: CGFloat = 20
    }
}

