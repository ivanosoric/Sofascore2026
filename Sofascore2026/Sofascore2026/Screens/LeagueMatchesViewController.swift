import UIKit
import SnapKit
import SofaAcademic

final class LeagueMatchesViewController: UIViewController {
    
    private let dataLoader = LeagueMatchesDataLoader()
    private let mapper = LeagueMatchesMapper()
    
    private let headerView = HomeHeaderView()
    private let sportSelectorView = SportSelectorView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var selectedSport: SportType = .football
    private var sections: [LeagueSectionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        setupActions()
        loadData()
    }
    
    private func setupView() {
        view.backgroundColor = AppColors.headerBackground
        
        view.addSubview(headerView)
        view.addSubview(sportSelectorView)
        view.addSubview(tableView)
        
        sportSelectorView.setSelectedSport(.football)
        
        tableView.register(
            MatchRowTableViewCell.self,
            forCellReuseIdentifier: MatchRowTableViewCell.reuseIdentifier
        )
        
        tableView.register(
            LeagueHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: LeagueHeaderFooterView.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppColors.background
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.sectionHeaderTopPadding = 0
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView()
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        sportSelectorView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        sportSelectorView.onSportSelected = { [weak self] sport in
            self?.selectedSport = sport
            self?.loadData()
        }
        
        headerView.onSettingsTap = { [weak self] in
            self?.openSettings()
        }
    }
    
    private func loadData() {
        let events = dataLoader.fetchEvents(for: selectedSport)
        sections = mapper.makeSections(from: events)
        tableView.reloadData()
    }
    
    private func openSettings() {
        let settingsViewController = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func openEventDetails(for viewModel: EventDetailsViewModel) {
        let viewController = EventDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension LeagueMatchesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].matchRowViewModels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchRowTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MatchRowTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = sections[indexPath.section].matchRowViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}

extension LeagueMatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueHeaderFooterView.reuseIdentifier
        ) as? LeagueHeaderFooterView else {
            return nil
        }
        
        let viewModel = sections[section].headerViewModel
        header.configure(with: viewModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewModel = sections[indexPath.section].matchRowViewModels[indexPath.row]
        openEventDetails(for: viewModel.eventDetailsViewModel)
    }
}
