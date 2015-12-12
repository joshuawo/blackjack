# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

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

    @get('playerHand').on 'bustCheck', =>
      if (@get 'playerHand').scores()[0] > 21
        @get('playerHand').setStatus('Busted!')
        @trigger 'betTime', @

    @get('playerHand').on 'showdown', =>
      @showdown false

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
    if handHiChk <= 21
      return handHiChk
    (@get hand).scores()[0]

  alertOutcome: (playerVal, dealerVal) ->
    if dealerVal > 21 or playerVal > dealerVal
      @get('playerHand').setStatus('You Won!')
    else if playerVal < dealerVal
      @get('playerHand').setStatus('The Dealer Won!')
    else
      @get('playerHand').setStatus('Push!')

    if @get('deck').length < @get('deck').decksInShoe * 52/4
      @get('deck').reset()
      @get('deck').addCardsToDeck @get('deck').decksInShoe

    @trigger 'betTime', @


    