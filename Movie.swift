//
//  Movie.swift
//  MovieSearch
//
//  Created by Habib Miranda on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
//Here we will set up our desired object. The Movie controller will create a movie object and check against this data to confirm that it is a movie. So in this class we want to make sure we create the needed properties for a movie.
class Movie {
    
    private let kTitle = "title"
    private let kRating = "vote_average"
    private let kOverview = "overview"
    private let kImage = "poster_path"
    
    //It looks like we will want title, vote_average(rating???), overview, and an image(poster_path) for every object.
    let title: String
    let rating: Double //vote_average
    let overview: String
    let image: String
    
    init?(dictionary: [String:AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
        let rating = dictionary[kRating] as? Double,
        let overview = dictionary[kOverview] as? String,
            let image = dictionary[kImage] as? String else {
                return nil
        }
        
        self.title = title
        self.rating = rating
        self.overview = overview
        self.image = image
    }
    
    
    
}