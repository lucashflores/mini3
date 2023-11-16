//
//  NotesEditorView.swift
//  Mini3
//
//  Created by Andrea Oquendo on 14/11/23.
//

import SwiftUI

struct NotesEditorView: View {
    
    @Binding var sheet: Bool
    @Binding var place: PlaceModel
    
    @EnvironmentObject var placesManager: PlacesManager
    @State private var text: String = "\u{2022} "
    @State private var isEditing = false
    
    @FocusState var isInputActive: Bool
    
    
    var body: some View {
        VStack(alignment: .leading){
            if isEditing {
                HStack(){
                    Button {
                        isInputActive = false
                        isEditing = false
                    } label: {
                        Text("Cancel")
                            .font(Font.custom("Poppins-Regular", size: 15))
                            .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                    }
                    
                    Spacer()
                    
                    Button {
                        isInputActive = false
                        isEditing = false
                        saveNote()
                    } label: {
                        Text("Save")
                            .font(
                            Font.custom("Poppins-Medium", size: 16)
                            )
                            .foregroundColor(Color(red: 0, green: 0.48, blue: 1))
                    }
                }
                .padding(.horizontal, -15)
            } else {
                HStack {
                    
                    Button {
                        placesManager.deleteplace(placeId: place.id)
                        sheet = false
                    } label: {
                        Text("Delete")
                            .font(Font.custom("Poppins-Regular", size: 15))
                            .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                    }
                    
                    Spacer()
                    Button {
                        sheet = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(
                                .system(size: 24)
                                .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                    }
                }
                .padding(.horizontal, -15)
            }
            
            Text(place.name)
                .font(.notesTitle)
                .foregroundColor(.textNotesTitle)
                .padding(.top, 2)
            Text("São Francisco, Curitiba - PR")
                .font(.notesSubTitle)
                .foregroundColor(.notesSubTitle)
            
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: "pencil.line")
                    Text("Write about this highlight")
                }
                
                Rectangle()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height:1)
            }
            .padding(.top, 16)
            
            TextEditor(text: $text)
            .scrollContentBackground(.hidden)
            .foregroundColor(Color.textNotes)
            .onTapGesture {
                if text.isEmpty {
                    text = "\u{2022} "
                }
                isEditing.toggle()
            }
            .focused($isInputActive)
            .onChange(of: text) { [text] newText in
                if newText.suffix(1) == "\n" && newText > text {
                    self.text.append("\u{2022} ")
                }
            }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 30)
        .background(Color.sheetBackground)
        .onAppear{
            text = place.notes ?? "\u{2022} "
            
            
        }
        
    }
    
    func saveNote(){
        placesManager.editNote(id: place.id, notes: text)
    }
}
//
//#Preview {
//    NotesEditorView()
//}
