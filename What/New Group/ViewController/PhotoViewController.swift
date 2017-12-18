//
//  PhotoViewController.swift
//  What
//
//  Created by Will on 12/15/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

let imagePicker = UIImagePickerController()
var GoogleVisions = [GoogleVision]()
var googleArray = [GoogleVisionR]()
var theImagePassed = UIImage()



class PhotoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // if no camera or the camera is not working
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
     
//        func dataProcess(image : UIImage){
//            Google.GoogleVisionUsingCodable(with: image)
//        }
        
        //显示的图片
        let image:UIImage!
        //获取选择的原图
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        theImagePassed = image
//        imageView.image = image
        print("picked image", theImagePassed)
        
        Google.GoogleVisionUsingCodable(with: theImagePassed, completion: {(result) in
            DispatchQueue.main.async {
//                print("in photo ",result)
                googleArray = result
                self.performSegue(withIdentifier: "showPic", sender: nil)
                picker.dismiss(animated: true, completion: {
                    () -> Void in
                })
            }
        })
//        Google.GoogleVisionUsingCodable(with: theImagePassed, completion: {
//            let number = GoogleVisions.count
//            print("in pnoto number of result",number)
//               for i in 0...number {
//              let g = GoogleVisions[i]
//            
//                 googleArray[i] = g.description
//              }
//        })
        
        
     
        //图片控制器退出
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func CameraPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
       
        
    }
    

    @IBAction func AlbumPressed(_ sender: Any) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
            
        }else{
            print("读取相册错误")
        }
    }
    
//   func prepareForSegueCamera(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        if segue.identifier == "showPic" {
//            let dvc = segue.destination as! PhotoIDViewController
//            dvc.newImage = theImagePassed
//        }
//    }
// func prepareForSegueAlbum(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        if segue.identifier == "toBrowseAlbum" {
//            let dvc = segue.destination as! PhotoIDViewController
//            dvc.newImage = theImagePassed
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPic" || segue.identifier == "showCamera"  {
            print("here to prepare picture")
            let dvc = segue.destination as! PhotoIDViewController
            dvc.newImage = theImagePassed
            dvc.resultAPI = googleArray
        }
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,
        imagePicker.delegate = self
        
        
        Google.delegate = self as? GoogleVisionAPIDelegate
        
        
    }
}
