//
//  Buttons.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import Foundation
import SwiftUI


// MARK: Sign Up Buttons
struct ContinueWithEmailButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.black)
                Text("Iniciar sesion")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
            }
            .frame(width: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 3, y: 4)
        }
    }
}


struct ContinueToSignUpButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.black)
                Text("Registrate")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
            }
            .frame(width: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 3, y: 4)
        }
    }
}


// MARK: Apple button
struct ContinueWithAppleButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "apple.logo")
                    .foregroundColor(.white)
                Text("Continue with Apple")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .frame(width: 200)
            .padding()
            .background(Color.black)
            .cornerRadius(25)
            .shadow(radius: 3, y: 4)
        }
    }
}


// MARK: Continue Buttons for Onboarding
struct OnboardingContinueButton: View {
    var action: () -> Void
    @State var title: String
    @Binding var isLoading: Bool

    var body: some View {
        Button(action: action) {
            HStack {
                Group {
                    if isLoading {
                        ActivityIndicator(style: .medium, color: .white, isAnimating: $isLoading)
                    } else {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                    }
                }
            }
            .frame(width: 200)
            .padding()
            .background(Color.mainColor)
            .cornerRadius(25)
            .shadow(radius: 2, y: 4)
        }
        .disabled(isLoading)
    }
}


// MARK: Continue Buttons for Onboarding
struct OnboardingContinueButtonWithIcon: View {
    var action: () -> Void
    @State var title: String
    @Binding var isLoading: Bool

    var body: some View {
        Button(action: action) {
            HStack {
                Group {
                    if isLoading {
                        ActivityIndicator(style: .medium, color: .white, isAnimating: $isLoading)
                    } else {
                        Image(systemName: "wineglass.fill")
                            .foregroundColor(.white)
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                    }
                }
            }
            .frame(width: 200)
            .padding()
            .background(Color.mainColor)
            .cornerRadius(25)
            .shadow(radius: 2, y: 4)
        }
        .disabled(isLoading)
    }
}




// MARK: Continue Buttons in White
struct OnboardingContinueButtonWhite: View {
    var action: () -> Void
    @State var title: String

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
            }
            .frame(width: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 2, y: 4)
        }
    }
}


#Preview {
    ZStack {
        Color.gray
            .edgesIgnoringSafeArea(.all)
        VStack {
            ContinueWithEmailButton(action: {})
            ContinueToSignUpButton(action: {})
            ContinueWithAppleButton(action: {})
            OnboardingContinueButton(action: {}, title: "Continue", isLoading: .constant(true))
            OnboardingContinueButtonWithIcon(action: {}, title: "Continue", isLoading: .constant(false))
            OnboardingContinueButtonWhite(action: {}, title: "Allow notifications")
        }
    }
}



// MARK: Activity indicator

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    let color: UIColor
    @Binding var isAnimating: Bool

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
