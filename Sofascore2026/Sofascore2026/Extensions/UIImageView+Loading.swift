import UIKit
import ObjectiveC

private var imageTaskKey: UInt8 = 0
private var imageURLKey: UInt8 = 0

extension UIImageView {

    private var currentImageTask: URLSessionDataTask? {
        get { objc_getAssociatedObject(self, &imageTaskKey) as? URLSessionDataTask }
        set { objc_setAssociatedObject(self, &imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var currentImageURL: URL? {
        get { objc_getAssociatedObject(self, &imageURLKey) as? URL }
        set { objc_setAssociatedObject(self, &imageURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(from url: URL?) {
        cancelImageLoad()
        image = nil
        currentImageURL = url

        guard let url else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  self.currentImageURL == url,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                guard self.currentImageURL == url else { return }
                self.image = image
            }
        }

        currentImageTask = task
        task.resume()
    }

    func cancelImageLoad() {
        currentImageTask?.cancel()
        currentImageTask = nil
        currentImageURL = nil
    }
}

