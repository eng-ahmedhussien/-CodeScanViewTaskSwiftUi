//
//  CodeScannerView.swift
//

//  Created by ahmed hussien on 25/05/2023.
//

import SwiftUI
import CodeScanner
import AVFoundation


struct CodeScanView: View {
    @Binding var scaneResult:String?
    @Environment(\.dismiss) var dismiss
    @State var animted = false
    let codeTypes : [AVMetadataObject.ObjectType] = [.qr,.code39,.code93,.code128,.ean8,.ean13,.upce,.itf14]

    var body: some View {
        
        CodeScannerView(codeTypes: codeTypes ,
                        completion:self.handleScan )
        .overlay(
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .stroke(Color.yellow, lineWidth: 2)
                    .frame(width: 200,height: 200)
                    .scaleEffect(animted ?  1.2 : 1)
            }
        )
        .onAppear {
            addanimtion()
        }
    }
    
    func addanimtion(){
        withAnimation(Animation.easeOut(duration: 1.0).repeatForever()) {
            animted.toggle()
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        
            self.animted = false
            switch result {
            case .success(let res):
                scaneResult = res.string
                dismiss()
            case .failure(_):
                scaneResult = nil
                dismiss()
            }
        }
}
struct CodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        CodeScanView(scaneResult: .constant(""))
    }
}


