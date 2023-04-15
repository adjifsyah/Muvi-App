//
//  CoreDataManager.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 15/04/23.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    func save(moviesId: Int, moviesTitle: String, overview: String, releaseDate: String, backdropPath: String, posterPath: String,
                     completion: @escaping (Result<String, GeneralError>) -> Void) {
        var users = [MoviesModel]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let newEntity =  NSEntityDescription.entity(forEntityName: "MyMovies", in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMovies")
        let newHistory =  NSManagedObject(entity: newEntity, insertInto: managedContext)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ user in
                users.append(
                    MoviesModel(movieId: user.value(forKey: "movie_id") as? Int ?? 0,
                                movieTitle: user.value(forKey: "movie_title") as? String ?? "",
                                overview: user.value(forKey: "overview") as? String ?? "",
                                releaseDate: user.value(forKey: "release_date") as? String ?? "",
                                backdropUrlPath: user.value(forKey: "backdrop_path") as? String ?? "",
                                posterUrlPath: user.value(forKey: "poster_path") as? String ?? "")
                )
            }
            guard
                users.filter({ $0.movieTitle == moviesTitle }).isEmpty
            else {
                return completion(.failure(.existData))
            }
            
            newHistory.setValue(moviesId, forKey: "movie_id")
            newHistory.setValue(moviesTitle, forKey: "movie_title")
            newHistory.setValue(overview, forKey: "overview")
            newHistory.setValue(releaseDate, forKey: "release_date")
            newHistory.setValue(backdropPath, forKey: "backdrop_path")
            newHistory.setValue(posterPath, forKey: "poster_path")
            
            try managedContext.save()
            completion(.success(moviesTitle))
        } catch {
            completion(.failure(.failLocalSave))
        }
    }
    
    // fungsi refrieve semua data
    func retrieve(completion: @escaping (Result<[MoviesModel], Error>) -> Void) {
        var users = [MoviesModel]()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMovies")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ user in
                users.append(
                    MoviesModel(movieId: user.value(forKey: "movie_id") as? Int ?? 0,
                                movieTitle: user.value(forKey: "movie_title") as? String ?? "",
                                overview: user.value(forKey: "overview") as? String ?? "",
                                releaseDate: user.value(forKey: "release_date") as? String ?? "",
                                backdropUrlPath: user.value(forKey: "backdrop_path") as? String ?? "",
                                posterUrlPath: user.value(forKey: "poster_path") as? String ?? "")
                )
            }
            completion(.success(users))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    func delete(_ movieTitle: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MyMovies")
        fetchRequest.predicate = NSPredicate(format: "movie_title = %@", movieTitle)
        
        do {
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
            completion(.success(movieTitle))
        } catch let err {
            completion(.failure(err))
        }
    }
    
}
