class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img title="<%= rankName %> of <%= suitName %>" class = "card" src="img/cards/<%= rankName %>-<%= suitName %>.png" />'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

