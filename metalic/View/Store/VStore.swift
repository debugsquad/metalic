import UIKit

class VStore:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CStore!
    weak var viewStore:VStore!
    weak var viewSpinner:VSpinner!
    weak var collectionView:UICollectionView!
    private let kHeaderSize:CGFloat = 75
    private let kFooterSize:CGFloat = 100
    private let kCollectionBottom:CGFloat = 20
    private let kCellSize:CGFloat = 120
    private let kInterLine:CGFloat = 1
    
    convenience init(controller:CStore)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.background
        translatesAutoresizingMaskIntoConstraints = false
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let viewSpinner:VSpinner = VSpinner()
        self.viewSpinner = viewSpinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(top:0, left:0, bottom:kCollectionBottom, right:0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
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
        collectionView.register(
            VStoreHeader.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:
            VStoreHeader.reusableIdentifier)
        collectionView.register(
            VStoreFooter.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VStoreFooter.reusableIdentifier)
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
        
        storeLoaded()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedStoreLoaded(sender:)),
            name:Notification.storeLoaded,
            object:nil)
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: notified
    
    func notifiedStoreLoaded(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.storeLoaded()
        }
    }
    
    //MARK: private
    
    private func storeLoaded()
    {
        collectionView.reloadData()
        
        if MStore.sharedInstance.purchase.mapItems.count == 0 && MStore.sharedInstance.error == nil
        {
            collectionView.isHidden = true
            viewSpinner.startAnimating()
        }
        else
        {
            collectionView.isHidden = false
            viewSpinner.stopAnimating()
        }
    }
    
    //MARK: public
    
    func showLoading()
    {
        viewSpinner.startAnimating()
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if MStore.sharedInstance.purchase.mapItems.count > 0 && MStore.sharedInstance.error == nil
        {
            size = CGSize(width:0, height:kHeaderSize)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if MStore.sharedInstance.purchase.mapItems.count > 0 || MStore.sharedInstance.error == nil
        {
            size = CGSize.zero
        }
        else
        {
            size = CGSize(width:0, height:kFooterSize)
        }
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kHeaderSize)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if MStore.sharedInstance.error == nil
        {
            count = MStore.sharedInstance.purchase.mapItems.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusableView:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:VStoreHeader.reusableIdentifier,
                for:indexPath)
        }
        else
        {
            reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:VStoreFooter.reusableIdentifier,
                for:indexPath)
        }
        
        return reusableView
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
