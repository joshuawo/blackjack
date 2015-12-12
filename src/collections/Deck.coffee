class window.Deck extends Backbone.Collection
  model: Card

  decksInShoe: 3

  initialize: ->
    @addCardsToDeck @decksInShoe

  addCardsToDeck: (numDecks)=>

    while numDecks
      @add _([0...52]).shuffle().map (card) ->
        new Card
          rank: card % 13
          suit: Math.floor(card / 13)
      numDecks -= 1

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

