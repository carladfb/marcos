//
//  TermsView.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 02/09/24.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Group {
                            Text("1. Purpose of the Terms of Use")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("These terms and conditions are intended to regulate the use of the Whats Next app by you, the user. The use of the service does not require user registration or login.")
                            
                            Text("2. App Purpose")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("The Whats Next app aims to organize and provide historical facts and important dates. All data and information collected come from the following APIs: Calendarific and The Wikimedia Foundation, Inc.")
                            
                            Text("3. Service Free of Charge")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("The Whats Next team does not intend to obtain any financial gain from the app.")
                            
                            Text("4. Applicability of the Terms")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("""
                                These terms apply to everyone who accesses Whats Next and uses the data provided. By using the app, you agree that:
                                • You are free to read, share, and teach using the information provided by Whats Next.
                                • You will not use the app's interface for personal gain.
                                """)
                            
                            Text("5. Information Responsibility")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                            Text("The Whats Next team is not responsible for the information disclosed. By using the app, the user is aware that verifying the information is their responsibility, and they should contact the providers of the following APIs directly: Calendarific and The Wikimedia Foundation, Inc.")
                        }
                        
                        Group {
                            Text("6. Privacy and Security")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("The developers are responsible only for providing the data through an interface developed by them. The Whats Next team does not collect or store any user data. Therefore, any request made in the name of the team and/or the Whats Next app requesting the provision of personal data from the user or financial transactions should be considered as a crime of \"fraud\" ou \"scam\" as provided in art. 171.")
                            
                            Text("7. LGPD Compliance")
                                .fontWeight(.bold)
                                .foregroundColor(.vermeiTchan)
                            Text("The Whats Next team is committed to complying with the General Data Protection Law (LGPD).")
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                }
                .background(Color.fundinho)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Terms of Use")
                                    .padding(.vertical)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                    }

                    .toolbarBackground(.bar, for: .navigationBar)
                    .toolbarBackground(Color.fundinho, for: .navigationBar)
                }
            }
        }



struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
