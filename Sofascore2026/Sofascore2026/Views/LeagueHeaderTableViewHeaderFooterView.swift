import UIKit
import SnapKit

final class LeagueHeaderTableViewHeaderFooterView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "LeagueHeaderTableViewHeaderFooterView"

    private let headerView = LeagueHeaderView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: LeagueHeaderViewModel) {
        headerView.prepareForReuse()
        headerView.configure(with: viewModel)
    }

    private func setupView() {
        contentView.backgroundColor = AppColors.background
        contentView.addSubview(headerView)
    }

    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
    }
}
