# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @naturalChk()

    @get('playerHand').on 'bustCheck', =>
      if (@get 'playerHand').scores()[0] > 21
        @get('playerHand').setStatus('Busted!')

    @get('playerHand').on 'showdown', =>
      @showdown false

    @get('playerHand').on 'newGame', =>
      @get('playerHand').setStatus('')
      @get('playerHand').reset()
      @get('playerHand').hit()
      @get('playerHand').hit()
      @get('dealerHand').reset()
      @get('dealerHand').hit()
      @get('dealerHand').at(0).flip()
      @get('dealerHand').hit()

      @naturalChk()

  naturalChk: ->
    if (@get 'playerHand').scores()[1] == 21
      @showdown true

  showdown: (natural)->
    playerVal = @bestHand 'playerHand'
    @get('dealerHand').at(0).flip()
    dealerVal = @bestHand 'dealerHand'

    if not natural
      while dealerVal < 18
        @get('dealerHand').hit()
        dealerVal = @bestHand 'dealerHand'

    @alertOutcome playerVal, dealerVal


  bestHand: (hand) ->
    handHiChk = (@get hand).scores()[1]
    if handHiChk and handHiChk < 21
      return handHiChk
    (@get hand).scores()[0]

  alertOutcome: (playerVal, dealerVal) ->
    console.log @get('deck').length

    if dealerVal > 21 or playerVal > dealerVal
      @get('playerHand').setStatus('You Won!')
      console.log @get('playerHand').status 
    else if playerVal < dealerVal
      @get('playerHand').setStatus('The Dealer Won!')
      console.log @get('playerHand').status
    else
      @get('playerHand').setStatus('Push!')
      console.log @get('playerHand').status

    if @get('deck').length < @get('deck').decksInShoe * 52/4
      @get('deck').reset()
      @get('deck').addCardsToDeck @get('deck').decksInShoe


    