import UIKit

class VHomeEditMenu:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHomeEdit!
    weak var collectionView:UICollectionView!
    let model:MEdit
    private let kCellWidth:CGFloat = 50
    private let kAfterSelectTime:TimeInterval = 1
    
    init(controller:CHomeEdit)
    {
        model = MEdit()
        
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeEditMenuCell.self,
            forCellWithReuseIdentifier:
            VHomeEditMenuCell.reusableIdentifier)
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
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MEditItem
    {
        let item:MEditItem = model.items[index.item]
        
        return item
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let count:CGFloat = CGFloat(model.items.count)
        let cellsWidth:CGFloat = count * kCellWidth
        let remain:CGFloat = width - cellsWidth
        let edgeInsets:UIEdgeInsets = UIEdgeInsets(top:0, left:0, bottom:0, right:remain)
        
        return edgeInsets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:kCellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MEditItem = modelAtIndex(index:indexPath)
        let cell:VHomeEditMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeEditMenuCell.reusableIdentifier,
            for:indexPath) as! VHomeEditMenuCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MEditItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kAfterSelectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:
                UICollectionViewScrollPosition())
        }
    }
}
