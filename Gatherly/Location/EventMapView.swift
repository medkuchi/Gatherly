//
//  EventMapView.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 5/4/26.
//

import SwiftUI
import _MapKit_SwiftUI

struct EventMapView: View {
    @State private var vm = EventsMapViewModel()
    @State private var position = MapCameraPosition.automatic
    @State private var selectedEvent: Event?
    var body: some View {
        MapReader { proxy in
            Map(position: $position) {
                // TODO: iterate over vm.annotations using a ForEach
                ForEach(vm.annotations) { annotation in
                    Annotation(annotation.event.title, coordinate: annotation.coordinate) {
                        // TODO: inside this Annotation should be a button
                        // the button should set the selectedEvent equal to the current annotation's event
                        // the button label should be the SF symbol "mappin" set to .largeTitle
                        // the button style should be plain
                        Button{
                            selectedEvent = annotation.event
                        }label:{
                        Image(systemName:"mappin")
                                .font(.largeTitle)
                        }
                    }
                }
            }
          }
          .task {
              do {
                // TODO: call your ViewModel's load function
                  try await vm.load()
            } catch {
              // TODO: add geocoding error to your ErrorType
              // this error's description should be "Failed to geocode addresses"
                print(ErrorType.geocodingError.localizedDescription)
            }
           }
           .sheet(item: $selectedEvent) { event in
               // TODO: show MapDetailView and pass in event
               MapDetailView(event: event)
           }
        }
    }


#Preview {
    EventMapView()
}
