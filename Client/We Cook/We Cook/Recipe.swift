//
//  Recipe.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/7/24.
//

import Foundation

struct Recipe: Hashable, Identifiable {
    let id = UUID()
    let ingredients: [String]
    let name: String
    let meals: [String]
    let time: String
    let image: String
    let directions: String
    let likes: Int
    let uri: String = ""
}

struct MockRecipeData {
    static let sampleRecipe = recipes[1]
    static let recipes = [
        Recipe(
            ingredients: ["Beef Strip","Salt","Pepper","Dijon Mustard","Sour Cream","Mushrooms","Onion","Flour","Butter","Beef Stock"],
            name: "Beef Stroganoff",
            meals: ["Dinner"],
            time: "1hr 15min",
            image: "SampleImage",
            directions: "1. Lorem Ipsum Blah blah blah\n2. more random words",
            likes: 10
        ),
        Recipe(
            ingredients: ["1 Chicken Breast","Salt","Pepper","Garlic Powder","1/4 Red Onion","2 Stalks Celery","Greek Yogurt"],
            name: "Chicken Salad",
            meals: ["Breakfast, Brunch, Lunch, Dinner"],
            time: "30 min",
            image: "SampleImage",
            directions: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            likes: 10
        ),
        Recipe(
            ingredients: ["White Onion","Mushrooms","Chicken Stock","Orzo","Heavy Cream","Parmesan","1/2 Lemon","Chicken Breast","salt","Pepper","Garlic Powder", "Onion Powder"],
            name: "Chicken Orzo",
            meals: ["Dinner"],
            time: "1hr 30min",
            image: "SampleImage",
            directions: "1. Lorem Ipsum Blah blah blah\n2. more random words",
            likes: 10
        ),
        Recipe(
            ingredients: ["Beef Strip","Salt","Pepper","Dijon Mustard","Sour Cream","Mushrooms","Onion","Flour","Butter","Beef Stock"],
            name: "Beef Stroganoff",
            meals: ["Dinner"],
            time: "1hr 15min",
            image: "SampleImage",
            directions: "1. Lorem Ipsum Blah blah blah\n2. more random words",
            likes: 10
        ),
        Recipe(
            ingredients: ["1 Chicken Breast","Salt","Pepper","Garlic Powder","1/4 Red Onion","2 Stalks Celery","Greek Yogurt"],
            name: "Chicken Salad",
            meals: ["Breakfast, Brunch, Lunch, Dinner"],
            time: "30 min",
            image: "SampleImage",
            directions: "1. Lorem Ipsum Blah blah blah\n2. more random words",
            likes: 10
        ),
        Recipe(
            ingredients: ["White Onion","Mushrooms","Chicken Stock","Orzo","Heavy Cream","Parmesan","1/2 Lemon","Chicken Breast","salt","Pepper","Garlic Powder", "Onion Powder"],
            name: "Fettucine Alfredo Sauce",
            meals: ["Dinner"],
            time: "1hr 30min",
            image: "SampleImage",
            directions: "1. Lorem Ipsum Blah blah blah\n2. more random words",
            likes: 10
        ),
    ]
}
