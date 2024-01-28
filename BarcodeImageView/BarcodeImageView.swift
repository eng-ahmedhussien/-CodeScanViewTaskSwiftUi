//
//  BarcodeImageView.swift
//
//  Created by ahmed hussien on 31/05/2023.
//

import SwiftUI

struct BarcodeImageView: View {
    
    @State var text : String
    
    var body: some View {
        
        VStack(spacing:20){
            if let image = generateBarcodeData(from: self.text){
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFit()
            }else{
                Image(systemName: "camera.metering.unknown")
                    .resizable()
                    .scaledToFit()
            }
            
            Text(text)
        }
        .frame(width: 350, height: 200, alignment: .center)
        .background(.gray)
        .cornerRadius(20)
    }
    
    func generateBarcodeData(from string: String) -> Data?{
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            if let image = filter.outputImage{
                let uiimage = UIImage(ciImage: image)
                return uiimage.pngData()!
            }
        }
        return nil
    }
}

struct BarcodeGenerator_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeImageView(text: "12345")
    }
}
