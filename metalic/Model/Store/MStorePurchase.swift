import Foundation

class MStorePurchase
{
    var mapItems:[String:MStorePurchaseItem]
    private let priceFormatter:NumberFormatter
    
    init()
    {
        mapItems = [:]
        priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = NumberFormatter.Style.currencyISOCode
    }
}
