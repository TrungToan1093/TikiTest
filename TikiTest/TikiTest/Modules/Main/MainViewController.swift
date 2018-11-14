//
//  MainViewController.swift
//  TikiTest
//
//  Created by Ho Trung Toan on 11/13/18.
//  Copyright © 2018 Ho Trung Toan. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: BaseViewController, HUDManager {
    
    //MARK: Properties
    let viewModel: MainViewModel
    let fontLabel : UIFont = UIFont.systemFont(ofSize: 14.0)
    
    
    //MARK: Outlet
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var hotKeyCollectionView: UICollectionView!
    @IBOutlet weak var hotKeyCVHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    @IBOutlet weak var historyCVHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var historyHeaderView: UIView!
    @IBAction func deleteAllHistoryTapped(_ sender: Any) {
        viewModel.deleteHistory()
    }
    
    //MARK: Lifecycle
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: MainViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        viewModel.getProducts()
    }
    
    //MARK: Other
    private func configView(){
        registerCell()
        prepareProductCVC()
        prepareHistoryCVC()
    }
    
    private func registerCell(){
        let nibProduct = UINib(nibName: ProductCollectionViewCell.className, bundle: nil)
        self.hotKeyCollectionView.register(nibProduct, forCellWithReuseIdentifier: ProductCollectionViewCell.className)
        let nibHistory = UINib(nibName: KeyworkCollectionViewCell.className, bundle: nil)
        self.historyCollectionView.register(nibHistory, forCellWithReuseIdentifier: KeyworkCollectionViewCell.className)
    }
    
    private func prepareProductCVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        hotKeyCollectionView.collectionViewLayout = layout
    }
    
    private func prepareHistoryCVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        historyCollectionView.collectionViewLayout = layout
    }
    
    override func bind() {
        viewModel.shouldShowProgress
            .asObservable()
            .subscribe(onNext: { [weak self] (shouldShowProgress) in
                guard let this = self else { return }
                if(shouldShowProgress) {
                    this.showResponseWaiting()
                }else {
                    this.hideResponseWaiting()
                }
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.productsFilter.asObservable().skip(1).subscribe( onNext : { [weak self] newsList in
            guard let this = self else { return }
            this.hotKeyCollectionView.reloadData()
        }).disposed(by: self.rx.disposeBag)
        
        
        viewModel.historiesToken = viewModel.histories?.observe { [weak self]  _ in
            guard let this = self else { return }
            this.historyCollectionView.reloadData()
            self?.historyHeaderView.isHidden = this.viewModel.histories?.count == 0
            self?.historyCollectionView.isHidden = this.viewModel.histories?.count == 0
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotKeyCollectionView{
            return viewModel.numberOfItemsHotKey
        }
        return viewModel.numberOfItemsHistory
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.hotKeyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.className, for: indexPath) as! ProductCollectionViewCell
            cell.configView(product: viewModel.productsFilter.value[indexPath.row])
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyworkCollectionViewCell.className, for: indexPath) as! KeyworkCollectionViewCell
            cell.configView(history: viewModel.histories![indexPath.row])
            return cell
        }

    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.hotKeyCollectionView {
            let witdh = Utility.widthForViewWithTwoLines(text: viewModel.productsFilter.value[indexPath.row].keyword, font: fontLabel, height: 50)
            return  CGSize(width: witdh > 112 ? witdh : 112, height: 176)
        }else {
            let witdh = Utility.widthForViewWithTwoLines(text: viewModel.histories![indexPath.row].key, font: fontLabel, height: 50)
            return  CGSize(width: witdh > 112 ? witdh : 112, height: 100)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.productsFilter.value = viewModel.firstProducts
        self.searchBarView.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        if (searchText.isEmpty) {
            viewModel.productsFilter.value = viewModel.firstProducts
        } else {
            viewModel.productsFilter.value = viewModel.firstProducts.filter {
            let text = searchText.folding(options:NSString.CompareOptions.diacriticInsensitive, locale: NSLocale.current).lowercased()
            return  $0.keyword.folding(options:NSString.CompareOptions.diacriticInsensitive, locale: NSLocale.current).lowercased().contains(text)
            }
            viewModel.productsFilter.value.forEach {
                let history = History($0.keyword, hexStringColor: $0.hexStringColor!)
                viewModel.addHistory(history: history)
                
            }
        }
    }
}
