import Foundation

extension Notification
{
    enum Notifications:String
    {
        case filtersLoaded = "filtersLoaded"
        
        var Value:Notification.Name
        {
            return Notification.Name(rawValue:self.rawValue)
        }
    }
}
