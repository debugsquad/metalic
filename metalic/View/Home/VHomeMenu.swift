import UIKit

class VHomeMenu:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHome!
    weak var collectionView:UICollectionView!
    weak var selectedItem:MFiltersItem?
    let model:MFilters
    private let kCellWidth:CGFloat = 90
    private let kAfterSelect:TimeInterval = 0.1
    
    init(controller:CHome)
    {
        model = MFilters()
        
        super.init(frame:CGRect.zero)
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.register(
            VHomeMenuCell.self,
            forCellWithReuseIdentifier:
            VHomeMenuCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kAfterSelect)
        { [weak self] in
            
            let index:IndexPath = IndexPath(item:0, section:0)
            self?.collectionView.selectItem(
                at:index,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
            
            self?.selectItemAtIndex(index:index)
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MFiltersItem
    {
        let item:MFiltersItem = model.items[index.item]
        
        return item
    }
    
    private func selectItemAtIndex(index:IndexPath)
    {
        let item:MFiltersItem = modelAtIndex(index:index)
        
        if selectedItem !== item
        {
            selectedItem = item
            controller.updateFilter()
        }
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:kCellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MFiltersItem = modelAtIndex(index:indexPath)
        let cell:VHomeMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeMenuCell.reusableIdentifier,
            for:indexPath) as! VHomeMenuCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
        selectItemAtIndex(index:indexPath)
    }
}
