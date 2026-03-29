import UIKit
import SnapKit
import SofaAcademic

final class SportSelectorView: BaseView {

    var onSportSelected: ((SportType) -> Void)?
    

    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
    private var selectedSport: SportType = .football

    override func addViews() {
        addSubview(stackView)
    }

    override func styleViews() {
        backgroundColor = AppColors.sportSelectorBackground

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0

        SportType.allCases.forEach { sport in
            let button = makeButton(for: sport)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        updateSelectionUI()
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setSelectedSport(_ sport: SportType) {
        selectedSport = sport
        updateSelectionUI()
    }
}

private extension SportSelectorView {

    func makeButton(for sport: SportType) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = sport.rawValue

        let title = sport.title
        let image = UIImage(systemName: sport.iconSystemName)

        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)

        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)

        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.title = title
            configuration.image = image
            configuration.imagePlacement = .top
            configuration.imagePadding = 6
            configuration.baseForegroundColor = .white
            button.configuration = configuration
        } else {
            button.titleEdgeInsets = UIEdgeInsets(top: 28, left: -20, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: -12, left: 0, bottom: 10, right: CGFloat(-title.count * 4))
        }

        button.addTarget(self, action: #selector(didTapSport(_:)), for: .touchUpInside)
        return button
    }

    @objc func didTapSport(_ sender: UIButton) {
        guard let sport = SportType(rawValue: sender.tag) else { return }
        selectedSport = sport
        updateSelectionUI()
        onSportSelected?(sport)
    }

    func updateSelectionUI() {
        buttons.forEach { button in
            let isSelected = button.tag == selectedSport.rawValue
            button.alpha = isSelected ? 1.0 : 0.65
        }
    }
}
