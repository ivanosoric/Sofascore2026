import UIKit
import SnapKit

final class MatchRowTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MatchRowTableViewCell"

    private let rowView = MatchRowView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MatchRowViewModel) {
        rowView.configure(with: viewModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        rowView.prepareForReuse()
    }

    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(rowView)
    }

    private func setupLayout() {
        rowView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16))
        }
    }
}
