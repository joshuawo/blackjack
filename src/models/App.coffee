# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bustCheck', =>
      if (@get 'playerHand').scores()[0] > 21
        window.alert('Busted!')

    @get('playerHand').on 'showdown', =>
      playerVal = @showDown 'playerHand'
      @get('dealerHand').at(0).flip()
      dealerVal = @showDown 'dealerHand'
      
      while dealerVal < 18
        @get('dealerHand').hit()
        dealerVal = @showDown 'dealerHand'

      @alertOutcome playerVal, dealerVal

  showDown: (hand) ->
    handHiChk = (@get hand).scores()[1]
    if handHiChk and handHiChk < 21
      return handHiChk
    (@get hand).scores()[0]

  alertOutcome: (playerVal, dealerVal) ->
    if dealerVal > 21 or playerVal > dealerVal
      window.alert('You Win!')
    else if playerVal < dealerVal
      window.alert('You Lose')
    else
      window.alert('Push')


    