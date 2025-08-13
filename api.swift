//  api.swift
//  Class105
//  Created by Weeraphot Bumbaugh on 8/6/25.


func getItems() -> [Book] {
    return [
        Book(title:"The Fellowship of the Ring",
             author:"J.R.R. Tolkien",
             image:"book1",
             description:"The first book in the trilogy",
             rating: 4,
             review:"A classic tale of good vs evil, a little slow at first but very rewarding.",
             status: .finished
            ),
        Book(title:"The Two Towers",
             author:"J.R.R. Tolkien",
             image:"book2",
             description:"The second book in the trilogy",
             rating: 4,
             review:"Gets more interesting, love the Ents",
             status: .finished
            ),
        Book(title:"The Return of The King",
             author:"J.R.R. Tolkien",
             image:"book3",
             description:"The thid and last book in the trilogy",
             rating: 5,
             review: "A masterpiece, don't have words to describe it",
             status: .reading
            )
    ]
}
