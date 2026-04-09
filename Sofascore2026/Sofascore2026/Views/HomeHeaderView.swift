import UIKit
import SnapKit
import SofaAcademic

final class HomeHeaderView: BaseView {
    
    var onSettingsTap: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let settingsButton = UIButton(type: .system)
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(settingsButton)
    }
    
    override func styleViews() {
        backgroundColor = AppColors.headerBackground
        
        titleLabel.text = "Sofascore"
        titleLabel.font = AppFonts.headerTitle
        titleLabel.textColor = AppColors.headerText
        
        let image = UIImage(systemName: "gearshape.fill")
        settingsButton.setImage(image, for: .normal)
        settingsButton.tintColor = .white
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(32)
        }
    }
    
    override func setupGestureRecognizers() {
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
    }
    
    @objc private func didTapSettings() {
        onSettingsTap?()
    }
}
