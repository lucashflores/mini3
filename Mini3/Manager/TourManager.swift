//
//  TourManager.swift
//  Mini3
//
//  Created by Andrea Oquendo on 07/11/23.
//

import CoreData

class TourManager: ObservableObject {
    
    @Published var tours: [Tour] = []
    
    let controller: PersistenceController

    init(controller: PersistenceController) {
        self.controller = controller
    }

    // Create a new tour.
    func createTour(tour: TourModel) {
        print("create")
        let newTour = Tour(context: controller.container.viewContext)
        
        newTour.id = tour.id
        newTour.name = tour.name
        newTour.desc = tour.description
//        newTour.picture = tour.picture + TO-DO
        
        

        controller.save() /*+ TO-DO*/
    }

    // Update an existing tour.
    func updateTour(_ tour: Tour, tourUpdate: TourModel) {
        
        tour.id = tourUpdate.id
        tour.name = tourUpdate.name
        tour.desc = tourUpdate.description
//        tour.picture = tourUpdate.picture + TO-DO

//        persistenceController.save() + TO-DO
    }

    // Delete a tour.
    func deleteTour(tourId: UUID) {
        let fetchRequest: NSFetchRequest<Tour> = Tour.fetchRequest()

        do {
            let tours = try controller.container.viewContext.fetch(fetchRequest)
            _ = tours.map { tourDelete in
                if tourDelete.id == tourId {
                    controller.container.viewContext.delete(tourDelete)
                }
                
            }
        } catch {
            print("Error fetching tours and converting to TourModel: \(error)")
        }

        controller.save()
    }
    
    func editTour(id: UUID, name: String?) {
        let fetchRequest: NSFetchRequest<Tour> = Tour.fetchRequest()

        do {
            let tours = try controller.container.viewContext.fetch(fetchRequest)
            _ = tours.map { tourEdit in
                if tourEdit.id == id{
                    tourEdit.name = name
                }
                
            }
        } catch {
            print("Error fetching tours and converting to TourModel: \(error)")
        }

        controller.save()
    }

    // Fetch all tours.
    func fetchAllTourModels() -> [TourModel] {
        let fetchRequest: NSFetchRequest<Tour> = Tour.fetchRequest()

        do {
            let tours = try controller.container.viewContext.fetch(fetchRequest)
            let tourModels = tours.map { tour in
                return TourModel(
                    id: tour.id ?? UUID(),
                    name: tour.name ?? "", // TO-DO: picture
                    description: tour.desc
                )
            }
            return tourModels
        } catch {
            print("Error fetching tours and converting to TourModel: \(error)")
            return []
        }
    }

    // You can add more methods for specific querying and management operations as needed.
}