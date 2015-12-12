class window.WagerView extends Backbone.View

  template: _.template '
    <div class="wager">Player\'s Wager: $<%= currentWager %></div>
    <form>
      <input type="text" name="wagerAmount">
      <input type="submit" value="submit">
    </form>
    '

  initialize: -> 
    @collection.on 'change newWager', => 
      @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection