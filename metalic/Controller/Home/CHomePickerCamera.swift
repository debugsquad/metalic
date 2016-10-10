import UIKit

class CHomePickerCamera:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.camera
        delegate = self
        allowsEditing = true
        self.controller = controller
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        var image:UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if image == nil
        {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        controller.dismiss(animated:true)
        { [weak self] in
            
            self?.controller.imageSelected(image:image)
        }
    }
}
