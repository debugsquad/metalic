import UIKit

class VStore:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CStore!
    weak var viewStore:VStore!
    weak var viewSpinner:VSpinner!
    weak var collectionView:UICollectionView!
    private let kHeaderSize:CGFloat = 100
    private let kFooterSize:CGFloat = 100
    private let kCellSize:CGFloat = 120
    private let kInterLine:CGFloat = 1
    
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
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.isHidden = false
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VStoreCell.self,
            forCellWithReuseIdentifier:
            VStoreCell.reusableIdentifier)
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
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if MStore.sharedInstance.purchase.mapItems.count > 0
        {
            size = CGSize(width:0, height:kHeaderSize)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 0
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VStoreCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VStoreCell.reusableIdentifier,
            for:indexPath) as! VStoreCell
        
        return cell
    }
}
