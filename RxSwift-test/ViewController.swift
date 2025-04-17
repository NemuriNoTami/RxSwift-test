//
//  ViewController.swift
//  RxSwift-test
//
//  Created by 平田亮河 on 2025/04/17.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //        let label = UILabel()
        //        //        ラベルのサイズと位置を指定
        //        label.frame = CGRect(x:50, y:100, width: 500, height: 100)
        //
        //        label.text = "RxSwiftのサンプル実装"
        //        label.textColor = .red
        //        label.font = UIFont.systemFont(ofSize: 30)
        
        //        Viewにlabelを追加
        //        view.addSubview(label)
        
        // RxSwiftによるバインディング処理
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                print("検索クエリ: \(query)")
            })
            .disposed(by: disposeBag)
    }
    
    // UIの初期設定を行うプライベートメソッド
    private func setupUI() {
        // UIコンポーネントの設定とレイアウト
        view.backgroundColor = .white
        
        searchBar.placeholder = "検索語を入力"
        searchBar.searchBarStyle = .prominent
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

