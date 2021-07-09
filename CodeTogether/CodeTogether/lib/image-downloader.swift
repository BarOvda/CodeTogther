//
//  image-downloading-lib.swift
//  charms-doctor-ios
//
//  Created by Adil Anwer on 22/04/2021.
//

import SwiftUI
import Kingfisher
import UIKit

enum ContentModeType{
    case aspectFitType
    case aspectFillType
}

struct ImageDownloader<Content: View>: View {
    var width:CGFloat
    var height:CGFloat
    var imageURL:String
    let placeHolder:Content
    var circleShape:Bool
    var isSelected: Bool?
    var contentModeType:ContentModeType
    @State var showLoader = false
    
    init(height: CGFloat = 50, width:CGFloat = 50,imageURL:String,isCircleShape:Bool ,isSelected: Bool? = false,  contentMode:ContentModeType = .aspectFillType ,@ViewBuilder placeHolder: () -> Content) {
        self.isSelected = isSelected
        self.height = height
        self.width = width
        self.placeHolder = placeHolder()
        self.imageURL = imageURL
        self.circleShape = isCircleShape
        self.contentModeType = contentMode
        showLoader = true
       
    }
    
    var body: some View {
        
//        if self.imageURL.validateUrl(){
            
            if circleShape == true{
                ZStack{
                  
                        KFImage.url(URL(string: self.imageURL))
                            .placeholder { placeHolder }
                            .resizable()
                            .onSuccess { result in
                                showLoader = false
                            }
                            .onFailure { error in
                                showLoader = false
                            }
                            .frame(width: self.height, height: self.width, alignment: .center)
                            .aspectRatio(contentMode: (contentModeType == .aspectFitType) ? .fit : .fill)
                            .clipShape(Circle())
                  
                    }
                
               
            } else {
                ZStack{
                  
                KFImage.url(URL(string: self.imageURL))
                    .placeholder { placeHolder }
                    .resizable()
                    .fade(duration: 1)
                                  .forceTransition()
                    .frame(width: self.height, height: self.width, alignment: .center)
                    .aspectRatio(contentMode: (contentModeType == .aspectFitType) ? .fit : .fill)
                    .foregroundColor((isSelected == true) ? Color.white : nil)
                  
                    if showLoader{
//                        VStack {
//                            CustomImageActivityIndicator(isAnimating: .constant(true), style: .large)
//                                .foregroundColor(Color.blue)
//                        }
//                        .frame(width: width,
//                               height: height )
                    }
                }
                .frame(width: self.height, height: self.width, alignment: .center)
            }
            
            // Other params of kfimage
            //                    KFImage.url(URL(string: patient.image!)!)
            //                              .placeholder(Image(systemName: "photo"))
            ////                              .setProcessor(processor)
            //                              .loadDiskFileSynchronously()
            //                              .cacheMemoryOnly()
            //                              .fade(duration: 0.25)
            ////                              .lowDataModeSource(.network(lowResolutionURL))
            //                              .onProgress { receivedSize, totalSize in  }
            //                              .onSuccess { result in  }
            //                              .onFailure { error in }
            
//        } else {
//            if circleShape == true{
//                placeHolder
//                    .frame(width:width, height: height, alignment: .center)
//                    .aspectRatio(contentMode: .fit)
//                    .clipShape(Circle())
//            } else {
//                placeHolder
//                    .foregroundColor(.gray)
//                    .frame(width:width, height: height, alignment: .center)
//                    .aspectRatio(contentMode: .fit)
//                //                    .clipShape(Circle())
//                
//            }
//            
//        }
    }
}


//struct CustomImageActivityIndicator: UIViewRepresentable {
//
//    @Binding var isAnimating: Bool
//    let style: UIActivityIndicatorView.Style
//
//    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
//        return UIActivityIndicatorView(style: style)
//    }
//
//    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
//        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
//    }
//}


enum ImageDownloadStatus {
    case downloading
    case failed
    case success
}

struct PlaceHolderView:View {
    
    @State var placeholderColor : Color?
    var circleShape:Bool
    var isProfilePlaceholder: Bool?
    
    var body: some View{
        
        HStack{
            if isProfilePlaceholder ?? false{
                Image("person_placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }else{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .foregroundColor((placeholderColor != nil) ? placeholderColor : .black)
    }
}
