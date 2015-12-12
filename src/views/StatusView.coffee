class window.StatusView extends Backbone.View
  className: 'footer'

  template: _.template '<span><%= status %></span>'

  initialize: -> 
    @collection.on 'add remove newStatus', => 
      console.log 'fire!'
      @render()
    @render()

  render: ->
    @$el.children().detach()
    console.log @collection
    console.log @collection.attributes
    @$el.html @template @collection

