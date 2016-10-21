import UIKit

class VStore:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CStore!
    weak var viewStore:VStore!
    weak var viewSpinner:VSpinner!
    weak var collectionView:UICollectionView!
    
    convenience init(controller:CStore)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let viewSpinner:VSpinner = VSpinner()
        self.viewSpinner = viewSpinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = false
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewSpinner)
        
        let views:[String:UIView] = [
            "viewSpinner":viewSpinner,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[viewSpinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[viewSpinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    //MARK: public
    
    func showLoading()
    {
        viewSpinner.startAnimating()
    }
    
    //MARK: collection delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    
}
