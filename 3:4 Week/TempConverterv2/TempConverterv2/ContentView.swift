//
//  ContentView.swift
//  TempConverterv2
//
//  Created by Laudeman, Luke D on 3/05/25.
//

import SwiftUI

//General Idea:
/*
- Create a few text fields which allow the user to enter either farenheight or celcius temperatures
- Then a function is called to convert the temperture based on whichever box it is entered in
- Since text fields default to string values I'll also need to convert the user-entered values to an integer or double, then do the calculations, and convert back again
 */

//Later I could add some other features like below:
/*
 - a home screen with a picker to let the user choose which conversions they want to do
 - Along with this, I could add systems for differet helpful conversions like Miles Per Hour and Kilometers Per Hour, etc
 - Also, just looking into a better UI and learning how to add features to make it look nicer
 */


struct ContentView: View {
    
    //Here I've created two state private variables to keep track of the user-entered data from the text fields
    @State private var Farenheit: String = ""
    @State private var Celcius: String = ""
    
    var body: some View {
        VStack {
            
            //adds a title to the top of the page
            Text("Temperature Conversion:")
                .font(.largeTitle.bold())
            //Spacer()
                .padding(.bottom)
            
            Text("Enter either a Farenheit or Celcius temperature below and the other will be automatically converted for you!")
                .font(.caption)
                .foregroundColor(.secondary)
            
            
            TextField("Enter Farenheit Temperature:", text: $Farenheit)
                .padding(.top)
            Text("Celcius temp: \(convertFarenheitToCelcius(farenheit: Farenheit))")
                .padding(.bottom)
            
            TextField("Enter Celcius Temperature:", text: $Celcius)
                .padding(.top)
            Text("Farenheight temp: \(convertCelciusToFarenheit(celcius: Celcius))")
                .padding(.bottom)
            
            
            
            
            /* - come back to this idea of adding a "convert" button and not automatically converting - LDL
            Button(action: {
                convertFarenheitToCelcius()
            }) {
                
            }
             */
             
        
            
        } //end of Vstack
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle()) //this adds a rounded border over all of the text fields in the main screen
        
        
        
        
        
        
        
    } //end of body
    
    //below are the two functions for converting temperatures
    
    func convertFarenheitToCelcius(farenheit: String) -> String {
        //this function will convert the user-entered Farenheit temperature to a double, then convert it to celcius, then back to a string and return it
        
        if var farenheitValue = Double(farenheit) {
            //this if statement makes sure that the value the user entered actually converts to a number and if it doesn't, it goes to the else statement which send an error. This is just a simple way I'm doing a little error checking
            
            farenheitValue = (farenheitValue - 32) * 5 / 9 //converts the value to celcius
            
            return String(farenheitValue) //converts it back into a string and returns it
        } else {
            return "Error: Please enter a valid number"
        }
        
    }
    
    
    func convertCelciusToFarenheit(celcius: String) -> String {
        
        if var celciusValue = Double(celcius) {
            //same thing as above but for celcius
            celciusValue = (celciusValue * 9 / 5) + 32
            
            return String(celciusValue)
        } else {
            return "Error: Please enter a valid number"
        }
        
    }
    
}

#Preview {
    ContentView()
              }
