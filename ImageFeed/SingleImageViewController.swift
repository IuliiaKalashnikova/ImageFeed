import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }

            imageView.image = image
            imageView.frame.size = image.size
            rescaleAndCenterImageInScrollView(image: image)
        }
    }

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25

        guard let image else { return }
        imageView.image = image
        imageView.frame.size = image.size
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    @IBAction func didTapShareButton(_ sender: UIButton) {
        guard image != nil else { return }
        let items: [Any] = [imageView.image!]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
    
    func rescaleAndCenterImageInScrollView(image: UIImage) {
       let minZoomScale = scrollView.minimumZoomScale
       let maxZoomScale = scrollView.maximumZoomScale
       view.layoutIfNeeded()
       let visibleRectSize = scrollView.bounds.size
       let imageSize = image.size
       let hScale = visibleRectSize.width / imageSize.width
       let vScale = visibleRectSize.height / imageSize.height
       let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
       scrollView.setZoomScale(scale, animated: false)
       scrollView.layoutIfNeeded()
       let newContentSize = scrollView.contentSize
       let x = (newContentSize.width - visibleRectSize.width) / 2
       let y = (newContentSize.height - visibleRectSize.height) / 2
       scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
   }
}


extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
