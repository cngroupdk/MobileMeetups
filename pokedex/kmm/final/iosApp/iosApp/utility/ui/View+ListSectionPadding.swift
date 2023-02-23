import SwiftUI

extension View {

    public func removeListSectionPadding() -> some View {
        self.onAppear {
            if #available(iOS 16.0, *) {
                var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
                layoutConfig.headerMode = .supplementary
                layoutConfig.headerTopPadding = 0
                layoutConfig.showsSeparators = false

                let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
                UICollectionView.appearance().collectionViewLayout = listLayout
            } else if #available(iOS 15.0, *) {
                UITableView.appearance().sectionHeaderTopPadding = 0
            }
        }
    }

}
