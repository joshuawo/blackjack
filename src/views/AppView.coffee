class window.AppView extends Backbone.View

  className: 'app'

  template: _.template '
    <div class="dealer-hand-container hidden"></div>
    <div class="player-hand-container hidden"></div>
    <div class="actions-container"><button class="hit-button hidden">Hit</button> <button class="stand-button hidden">Stand</button> <button class="play-button">Play Again</button></div>
    <div class="footer"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-button': ->
      @model.get('playerHand').playAgain()
      @$el.find('.actions-container').children().toggleClass('hidden')
      @$el.find('.player-hand-container').removeClass('hidden')
      @$el.find('.dealer-hand-container').removeClass('hidden')

  initialize: ->
    @model.on 'betTime', =>
      @$el.find('.actions-container').children().toggleClass('hidden')

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.footer').html new StatusView(collection: @model.get 'playerHand').el

