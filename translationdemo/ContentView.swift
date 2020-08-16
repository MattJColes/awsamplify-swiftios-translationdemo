//
//  ContentView.swift
//  translationdemo
//
//  Created by Coles, Matt on 16/8/20.
//  Copyright © 2020 Coles, Matt. All rights reserved.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import AWSPredictionsPlugin

struct ContentView: View {
    @State var textToConvert: String = ""
    @State var convertedText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("User Input", text: $textToConvert)
            Button(
                action: { self.translateText() },
                label: { Text("Translate")}
            )
            Text("Japanese Translation: \(convertedText)")
        }
    }
    
    func translateText() {
        _ = Amplify.Predictions.convert(textToTranslate: textToConvert,
            language: .english,
            targetLanguage: .japanese,
            listener: { (event) in
                switch event {
                case .success(let result):
                    self.convertedText = result.text
                case .failure(let error):
                    print("Error: \(error)")
                }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
