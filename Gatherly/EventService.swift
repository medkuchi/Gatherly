//
//  EventService.swift
//  Gatherly
//
//  Created by Medha Kuchimanchi on 3/5/26.
//

import Foundation
import PhotosUI

@Observable
class EventService {
    static let shared = try! EventService()
    private let baseURL: URL
    
    private init() throws {
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/") else {
            throw ErrorType.invalidURL
        }
        self.baseURL = url
    }
    
    //    func CreateEvent(title: String, description: String, date: Date, location: String, image: String) async throws -> Event {
    //        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
    //            return
    //        }
    //
    //        do{
    //            let URLSession = URLSession.shared
    //            let (data,_) = try await URLSession.data(from: url)
    //            let decoder=JSONDecoder()
    //            decoder.dateDecodingStrategy = .iso8601
    //            let decodedresponse=try decoder.decode(EventResponse.self, from:data)
    //           // events=decodedresponse.events
    //
    //           // return filteredEventIndices
    //
    //        }catch{
    //            print("Unable to fetch events")
    //            //return filteredEventIndices
    //        }
    //    }
    
    //try await EventService.shared.createEvent( params here )
    func createEvent(title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws -> Event? {
        let path = baseURL.appending(path: "events")
        var imageString: String = ""
        if let image = uiImage, let data = image.jpegData(compressionQuality: 0.8) {
            imageString = "data:image/jpeg;base64,\(data.base64EncodedString())"
        }
        
        var request = URLRequest(url: path)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = Event(title: title, location: location, description: description, image: imageString ,timestamp: timestamp)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do{
            request.httpBody = try? encoder.encode(body)
        } catch{
            throw ErrorType.codingError
        }
        do{
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ErrorType.networkError
            }
            guard httpResponse.statusCode == 201 else{
                throw ErrorType.networkError
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do{
                let created = try decoder.decode(Event.self, from: data)
                return created
            } catch{
                throw ErrorType.codingError
            }
        }catch is URLError{
            throw ErrorType.networkError
        } catch{
            throw ErrorType.unknown
        }
    }
    
    func editEvent(id: String, title: String, description: String, timestamp: Date, location: String, uiImage: UIImage? = nil) async throws {
        let path = baseURL.appending(path: "events/\(id)")
        
        var request = URLRequest(url: path)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = Event(title: title, location: location, description: description ,timestamp: timestamp)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            print("Failed to edit event")
            return
        }
        
    }
    func deleteEvent(id: String) async throws {
        let path = baseURL.appending(path: "events/\(id)")
        
        var request = URLRequest(url: path)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["creatorPid":"730858271"]
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            print("Failed to delete event")
            return
        }
        
    }
    func fetchEvents() async throws -> [Event] {
        guard let url = URL(string: "https://gatherly-backend-q9vm.onrender.com/events") else {
            throw ErrorType.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let decodedresponse = try decoder.decode(EventResponse.self, from: data)
                return decodedresponse.events
            } catch {
                throw ErrorType.codingError
            }
        } catch is URLError {
            throw ErrorType.networkError
        } catch {
            throw ErrorType.unknown
        }
    }
}

