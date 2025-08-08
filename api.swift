//  api.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.


func getItems() -> [Book] {
    return [
        Book(
            title: "The Fellowship of the Ring",
            image: "book1",
            description:"A hobbit embarks on a perilous quest to destroy the One Ring"),
        Book(
            title: "The Two Towers",
            image: "book2",
            description:"The Fellowship faces danger as they journey towards Mordor"),
        Book(
            title: "The Return of the King",
            image: "book3",
            description: "The 3rd book")
    ]
}
