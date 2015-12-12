class window.StatusView extends Backbone.View
  className: 'footer'

  template: _.template '<div class="balance">Player\'s Balance: $<%= bankBalance %></div><span><%= status %></span>'

  initialize: -> 
    @collection.on 'add remove newStatus', => 
      @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection

