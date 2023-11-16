//
//  PointsManager.swift
//  Mini3
//
//  Created by Andrea Oquendo on 09/11/23.
//

import CoreData

class PlacesManager: ObservableObject {
    
    @Published var places: [PlaceModel] = []
    
    let controller: PersistenceController

    init(controller: PersistenceController) {
        self.controller = controller
    }

    // Create a new place.
    func createPoint(place: PlaceModel, placeCount: Int) {
        
        let newPlace = Place(context: controller.container.viewContext)
        
        newPlace.id = place.id
        newPlace.name = place.name
        newPlace.notes = place.notes
        newPlace.tour = getTour(tourId: place.tourId!)
        newPlace.orderNumber = Int16(placeCount)
        newPlace.title = place.title
        newPlace.latitude = place.latitude
        newPlace.longitude = place.longitude
//        newplace.picture = place.picture + TO-DO
        
        controller.save() /*+ TO-DO*/
    }

    // Delete a place.
    func deleteplace(placeId: UUID) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            _ = places.map { placeDelete in
                if placeDelete.id == placeId {
                    updateOrder(
                        tourId: placeDelete.tour?.id ?? UUID(),
                        orderNumber: Int(placeDelete.orderNumber)
                    )
                    controller.container.viewContext.delete(placeDelete)
                }
                
            }
        } catch {
            print("Error fetching places and converting to PlaceModel: \(error)")
        }

        controller.save()
    }
    
    func updateOrder(tourId: UUID, orderNumber: Int) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            _ = places.map { placeDelete in
                if placeDelete.tour?.id == tourId {
                    if placeDelete.orderNumber > orderNumber {
                        placeDelete.orderNumber = placeDelete.orderNumber - 1
                    }
                }
                
            }
        } catch {
            print("Error fetching places and converting to PlaceModel: \(error)")
        }

        controller.save()
    }
    
    func editPlace(id: UUID, name: String?) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            _ = places.map { placeEdit in
                if placeEdit.id == id{
                    placeEdit.name = name
                }
                
            }
        } catch {
            print("Error fetching places and converting to placeModel: \(error)")
        }

        controller.save()
    }
    
    func editNote(id: UUID, notes: String) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            _ = places.map { placeEdit in
                if placeEdit.id == id{
                    placeEdit.notes = notes
                }
                
            }
        } catch {
            print("Error fetching places and converting to placeModel: \(error)")
        }

        controller.save()
    }

    // Fetch all places.
    func fetchAllPlaceModels() -> [PlaceModel] {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            let placeModels = places.map { place in
                return PlaceModel(
                    id: place.id ?? UUID(),
                    name: place.name ?? "", // TO-DO: picture
                    orderNumber: Int(place.orderNumber),
                    notes: place.notes,
                    tourId: place.tour?.id,
                    title: place.title ?? "",
                    latitude: place.latitude,
                    longitude: place.longitude
                )
            }
            return placeModels
        } catch {
            print("Error fetching places and converting to placeModel: \(error)")
            return []
        }
    }
    
    func fetchAllPlaceByTour(tourId: UUID) -> [PlaceModel] {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            var placeModels: [PlaceModel] = []
            for place in places {
                if place.tour?.id == tourId{
                    let aux = PlaceModel(
                        id: place.id ?? UUID(),
                        name: place.name ?? "", // TO-DO: picture
                        orderNumber: Int(place.orderNumber),
                        notes: place.notes,
                        tourId: place.tour?.id,
                        title: place.title ?? "",
                        latitude: place.latitude,
                        longitude: place.longitude
                    )
                    placeModels.append(aux)
                }
            }
            return placeModels
        } catch {
            print("Error fetching places and converting to placeModel: \(error)")
            return []
        }
    }
    
    func saveOrder(placesList: [PlaceModel], tourId: UUID){
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        do {
            let places = try controller.container.viewContext.fetch(fetchRequest)
            var placeModels: [PlaceModel] = []
            for place in places {
                if place.tour?.id == tourId{
                    
                    for (index, placeItem) in placesList.enumerated(){
                        if placeItem.id == place.id {
                            place.orderNumber = Int16(index)
                        }
                    }
                    let aux = PlaceModel(
                        id: place.id ?? UUID(),
                        name: place.name ?? "", // TO-DO: picture
                        orderNumber: Int(place.orderNumber),
                        notes: place.notes,
                        tourId: place.tour?.id,
                        title: place.title ?? "",
                        latitude: place.latitude,
                        longitude: place.longitude
                    )
                    placeModels.append(aux)
                }
            }
        } catch {
            print("Error fetching places and converting to placeModel: \(error)")
        }
        
    }
    
    private func getTour(tourId: UUID) -> Tour? {
        let fetchRequest: NSFetchRequest<Tour> = Tour.fetchRequest()

        do {
            let tours = try controller.container.viewContext.fetch(fetchRequest)
            for tour in tours {
                if tour.id == tourId {
                    return tour
                }
            }
            
        } catch {
            print("Error fetching tours and converting to TourModel: \(error)")
        }
        
        return nil

    }

    // You can add more methods for specific querying and management operations as needed.
}
