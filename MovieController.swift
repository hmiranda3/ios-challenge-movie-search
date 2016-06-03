//
//  MovieController.swift
//  MovieSearch
//
//  Created by Habib Miranda on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

//In the movie controller, we will create a place where the NetworkController will deposit JSON data. The network controller will then fetch it, unwrap it, serialize the array of dictionaries, and convert it into an array of things we can use. It will then test all properties against the Movie model to see if we indeed have a movie in the form we want to display to the user.
class MovieController{
    
//We need to create a way to access properties in this controller from outside the class.
    static let sharedController = MovieController()

//We need to make a base URL that will in-turn be used to create other URLs. I assume we will need to remove the last portion of the URL up to the /search/ part.
    static let baseURL = NSURL(string: "http://api.themoviedb.org/3/search/")
    
//I dont know exactly how to access all movies, but here I'm supposed to add an endoint that will bring me all the movies available in the API (I believe).
    static let endpoint = baseURL?.URLByAppendingPathExtension("/movie?api_key")

//Running a test to see if I'm getting a movie, looks like I'm not getting one yet!
    init() {
        MovieController.fetchMovie() { (movies) in
            for movie in movies {
                print("Got a movie \(movie)")
            }
        }
    }
    
    var myMovies: [Movie] = []
    
// We need to fetch our movies now and unwrap the url we receive from the NetworkController. In order to do this, we will need to fetch function and perform a fetch request on our Newtwork Controller. We will then put the results into an array that will hold information that we can use to create a movie.
    static func fetchMovie(completion: (movie: [Movie]) -> Void) {
        guard let unwrappedURL = MovieController.endpoint else {
            fatalError("Post Endpoint url failed")
        }
        NetworkController.performRequestForURL(unwrappedURL, httpMethod: .Get) { (data, error) in
            guard let data = data,
            let movieJSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)),
                let resultsArray = movieJSONDictionary["results"] as? [[String:AnyObject]] else {
                    completion(movie: [])
                    return
            }
            print(movieJSONDictionary)
            let movieArray = resultsArray.flatMap({Movie(dictionary: $0)})
            completion(movie: movieArray)
        }
    }
}


