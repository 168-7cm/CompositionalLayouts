//
//  CompositionalLayoutViewController.swift
//  CompositionalLayouts
//
//  Created by kou yamamoto on 2021/05/09.
//

import UIKit
import RxSwift
import RxDataSources

final class MainViewController: UIViewController {

    private lazy var mainDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
        configureCell: { dataSource, collectionView, indexPath, str in
            switch dataSource[indexPath] {
            case let .main(town: town):
                let cell = collectionView.dequeueReusableCustomCell(with: MainCell.self, indexPath: indexPath)
                cell.configure(town: town)
                return cell
            case let .sub(shop: shop):
                let cell = collectionView.dequeueReusableCustomCell(with: SubCell.self, indexPath: indexPath)
                cell.configure(shop: shop)
                return cell
            }
        },
        configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            switch dataSource[indexPath.section] {
            case let .main(title: title, items: _):
                return self.configureSupplementaryView(title: title, kind: kind, collectionView: collectionView, indexPath: indexPath)
            case let .sub(title: title, items: _):
                return self.configureSupplementaryView(title: title, kind: kind, collectionView: collectionView, indexPath: indexPath)
            }
        })

    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModelType = MainViewModel()

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        viewModel.inputs.viewDidLoad()
    }

    private func setup() {

        // CollectionView周りの設定
        collectionView.registerCustomCell(MainCell.self)
        collectionView.registerCustomCell(SubCell.self)
        collectionView.registerCustomHeaderView(HeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.registerCustomFooterView(FooterView.self, kind: UICollectionView.elementKindSectionFooter)

        // Compositonal Layoutの設定
        collectionView.collectionViewLayout = layout()
    }

    // CompositionalLayoutの実装
    private func layout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch self.mainDataSource[sectionIndex] {
            case .main:
                let section = self.generateSectionLayout()
                let header = self.generateHeaderLayout()
                section.boundarySupplementaryItems = [header]
                return section
            case .sub:
                let section = self.generateSectionLayout()
                let header = self.generateHeaderLayout()
                let footer = self.generateFooterLayout()
                section.boundarySupplementaryItems = [header, footer]
                return section
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        return layout
    }
    
    private func bind() {

        viewModel.outputs.result.bind(to: collectionView.rx.items(dataSource: mainDataSource)).disposed(by: disposeBag)

    }

    // Compositional Layout Sectionを作成する
    private func generateSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    // CollectionView Headerを作成する
    private func generateHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }

    // CollectionView Footerを作成する
    private func generateFooterLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        return sectionFooter
    }

    private func configureSupplementaryView(title: String, kind: String, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableCustomHeaderView(with: HeaderView.self, kind: kind, indexPath: indexPath)
            header.configure(str: title)
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableCustomFooterView(with: FooterView.self, kind: kind, indexPath: indexPath)
            footer.bind()
            self.viewModel.outputs.loading.bind(to: footer.isLoadingRelay).disposed(by: footer.disposeBag)
            if collectionView.isDragging { self.viewModel.inputs.viewDidLoad() }
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}